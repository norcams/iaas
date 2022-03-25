========
Patching
========

Last changed: 2021-08-26

.. contents:: Table of Contents
    :depth: 2

Update repo
============

Repo list (test and/or prod) are updated during the planing phase of an
upgrade. Repo we will need to update for el7 and el8::

* centos-*
* ceph-*
* epel
* mariadb-*
* rdo-*
* sensu
* puppetlabs5

.. IMPORTANT::
   Do **NOT** update :file:`calico`-repo without extra planned testing og
   repackaging.

Avoid updating management repos at the same time as normal patching.

Before we start
===============

.. IMPORTANT::
   Before you start, make sure the repo is up to date with the
   snapshot you wish to use.

Update ansible inventory for both `OSL` and `BGO`
:file:`$himlarcli/ansible_hosts.py`

Set `location` variable according to the environment which is going to
be patched::

  location=bgo

or::

  location=osl

Make sure all nodes will autostart with::

  sudo ansible-playbook -e "myhosts=${location}-controller" lib/autostart_nodes.yaml


Normal OS patching
==================

.. IMPORTANT::
  When we patch BGO and OSL at the same time, make sure to keep one NS node up
  at all time!

For each for the production regions, `BGO` and `OSL`, do the following:


Patching controller-04/08
-------------------------

The node controller-04/08 (OSL/BGO) is usually running virtual nodes that are not
critical to the operation of Openstack, and controller-04/08 can
therefore be patched and rebooted outside of a maintenance window.

The controller node and all virtual nodes running on the controller
can be patched with a single Ansible playbook::

  sudo ansible-playbook -e "myhosts=${location}-controller-04" lib/yum_update_controller.yaml

This playbook takes extra options, if needed:

=====================  ===========================================================
Option                 Effect
=====================  ===========================================================
``async=1``            will run yum and puppet in parallel on the vms
``no_reboot=1``        will not reboot controller (vms will still be turned off)
``exclude="package"``  will not update package with yum
=====================  ===========================================================

Also, consider patching `Firmware`_.

.. IMPORTANT::
  As controller-04/08 hosts the proxy node, the reboot playbook will not work. Use normal
  reboot command.


Patching other controller nodes
-------------------------------

#. Upgrade virtual nodes, while excluding the **httpd**, **mariadb**
   and **mod_ssl** packages. This is usually safe to do outside of a
   scheduled maintenance window::

     sudo ansible-playbook -e "myhosts=${location}-nodes exclude=httpd*,MariaDB*,mod_ssl,nfs-utils" lib/yumupdate.yaml

#. While in a scheduled maintenance window, upgrade virtual nodes::

     sudo ansible-playbook -e "myhosts=${location}-nodes" lib/yumupdate.yaml

#. Check if all virtual nodes are updated::

     sudo ansible-playbook -e "myhosts=${location}-nodes" lib/checkupdate.yaml

#. Upgrade controller nodes::

     sudo ansible-playbook -e "myhosts=${location}-controller" lib/yumupdate.yaml

#. Check if all controller nodes are updated::

     sudo ansible-playbook -e "myhosts=${location}-controller" lib/checkupdate.yaml

For each controller do the following. Make sure cephmon is running
without error before starting on the next controller.

#. Check ceph status on cephmon::

     sudo ssh iaas@${location}-cephmon-01 'sudo ceph status'

   Or, alternatively::

     for i in $(seq 1 3); do sudo ssh iaas@${location}-cephmon-0$i 'sudo ceph status' ; done

   In addition, check "cephmon-object" in BGO::

     for i in $(seq 1 3); do sudo ssh iaas@${location}-cephmon-object-0$i 'sudo ceph status' ; done

#. Turn off the nodes on the controller before reboot::

     sudo ansible-playbook -e "myhosts=${location}-controller-<id> action=stop" lib/manage_nodes.yaml

   Monitor through **virt-manager** or **virsh list** that all virtual
   nodes are shut down before proceeding with rebooting the controller.

#. Consider patching `Firmware`_.

.. IMPORTANT::
  To keep services for the instances uninterrupted, consider nodes and workloads which depends
  on the NAT nodes. This includes IPv4 access for instances with private IPv4 addresses, the
  resolver nodes and the identity nodes. Most of these nodes and instances consumes nat-01 by
  default, which runs on controller-01, but temporarily they can use nat-02. The resolver-02 nodes
  use nat-01 by default.

#. Reboot the controller node::

     sudo ansible-playbook -e "myhosts=${location}-controller-<id>" lib/reboot.yaml

.. TIP::
   Check that things work before rebooting controller-04, as error
   analysis etc. often depends on the virtual nodes running on
   controller-04.


None disruptive patching
========================

These steps can be done without notification and can be done later then normal
patching.

Storage
-------

#. Before you begin, you can avoid automatic rebalancing of the ceph
   cluster during maintenance. Run this command on a cephmon or
   storage node::

     ceph osd set noout

#. Run **ceph status** continuously in another window on one of the cephmon nodes::

     watch ceph status

   Before rebooting a node, check that all OSDs are up, e.g.::

     osd: 30 osds: 30 up, 30 in

#. Upgrade storage::

     sudo ansible-playbook -e "myhosts=${location}-storage" lib/yumupdate.yaml

#. Check if the storage nodes are upgraded::

     sudo ansible-playbook -e "myhosts=${location}-storage" lib/checkupdate.yaml

#. Consider patching `Firmware`_.

#. Reboot one storage node at the time::

     sudo ansible-playbook -e "myhosts=${location}-<node>" lib/reboot.yaml

   NB! Check **ceph status**, see above.

#. After all nodes are rebooted, ensure that automatic rebalancing is enabled::

     ceph osd unset noout

Compute
-------

None disruptive patching will only be possible for compute nodes
running in host aggregate ``central1``.

Before you start check to documentation for
`reinstall of compute <compute.html#compute-reinstall>`_

#. You will need an empty compute node first. There will usually always be one
   in AZ ``iaas-team-only``. Reinstall this first and test it. Disable all other
   compute nodes and enable the new one.

#. For each compute node migrate all instances to the enabled compute node
   (the empty one). Use :file:`himlarcli/migrate.py`. Then reinstall the newly
   empty compute node, and start over with the next one.

#. The last compute node will now be empty and can be reinstalled, disabled
   and added back to the AZ iaas-team-only. Update trello status for
   `Availability zone / Host aggregate`.

Leaf
----

   Only reboot one node at a time, and never if one node is a single point of
   failure.

   .. WARNING::
      Never patch Cumulus VX (virtual appliance). Only physical hardware. Cumulus VX
      are only used in testing/development.

   Upgrade node::

     apt-get update
     apt-get dist-upgrade

   Reboot node.

Compute (dedicated compute resources/HPC)
=========================================

#. Before we start (3-5 days before) we should notify all users in the aggregate (e.g. ``hpc1``)

   .. code-block:: bash

      himlarcli/mail.py aggregate -s 'Scheduled maintenance 2021-03-13' -t notify/maintenance/hpc.txt --date '2021-03-13 12:00-16:00' hpc1 --debug [--dry-run]

   Aggregate to consider patching on second Tuesday of every month:

  +------------------+--------+----------------------------------------+
  | Aggregate        | Region | Template                               |
  +==================+========+========================================+
  | hpc1             | osl    | notify/maintenance/hpc.txt             |
  +------------------+--------+----------------------------------------+
  | robin1           | osl    | notify/maintenance/dedicated.txt       |
  +------------------+--------+----------------------------------------+
  | shpc_cpu1        | bgo    | notify/maintenance/shpc.txt            |
  +------------------+--------+----------------------------------------+
  | shpc_ram1        | bgo    | notify/maintenance/shpc.txt            |
  +------------------+--------+----------------------------------------+
  | vgpu1            | bgo    | notify/maintenance/dedicated.txt       |
  +------------------+--------+----------------------------------------+
  | vgpu1            | osl    | notify/maintenance/dedicated.txt       |
  +------------------+--------+----------------------------------------+

#. Purge state database (once per region)::

    himlarcli/state.py purge instance

#. Check instance status::

    himlarcli/aggregate.py instances <aggregate>

#. Stop instances::

    himlarcli/aggregate.py stop-instance <aggregate>

#. Upgrade compute HPC::

    sudo ansible-playbook -e "myhosts=${location}-compute-hpc" lib/yumupdate.yaml

#. Check if the nodes are upgraded::

    sudo ansible-playbook -e "myhosts=${location}-compute-hpc" lib/checkupdate.yaml

#. Reboot nodes. Always check inventory to make sure the target of ``myhosts``
   match the intended targets for reboot. Some hosts might be running in other
   aggregates::

    sudo ansible-playbook -e "myhosts=${location}-compute-hpc" lib/reboot.yaml

#. Start the instances::

    himlarcli/aggregate.py start-instance <aggregate>


Firmware
========

For physical nodes it might be worth considering firmware patching.

Dell
----

#. Install **DSU** on the node::

     sudo ansible-playbook -e "myhosts=${location}-<node>" lib/install_dsu.yaml

#. Upgrade firmware::

     sudo ansible-playbook -e "myhosts=${location}-<node>" lib/upgrade_dell_firmware.yaml

#. Reboot::

     sudo ansible-playbook -e "myhosts=${location}-<node>" lib/reboot.yaml

Workaround for problematic r740/r740xd BIOS update
--------------------------------------------------

BIOS update for PowerEdge r740/r740xd might fail with a message "BIOS File is Corrupt", and
you have to press F1 to boot and then reflash the BIOS. A robust workaround is to flash the
BIOS via det iDRAC. First, flash firmware (only) normally: ::

     dsu -n -q --component-type=FRMW'

Download the latest BIOS file for the Windows platform from the Dell website to a login node
and upload it to the iDRAC, scheduling a BIOS upgrade at next boot::

     /opt/dell/srvadmin/bin/idracadm7 -r [bmc_address] -u [username] -p [password] update -f /tmp/BIOS_NVGR9_WN64_2.10.0.EXE

Then reboot.

Supermicro
----------

Supermicro does not recommend flashing firmware unless it is necessary. Also, there is no
automated way to do it. If needed, though, download the necessary firmware from the
vendor's website and upload the BIOS or firmware files via the bmc's update feature. When
finished the server must do a full reset, so it is absolutely best to flash the firmware
when the server is down (for example being in the grub boot menu).

.. WARNING::
   If flashing the BIOS the settings will be lost! Be sure to adjust settings after flashing,
   otherwise the server won't boot.

Testing
=======

After patching, we should test the following:

* install new instance
* ssh to new instance
* create volume and attach to instance
* detach volume
* destroy volume
* destroy instance

Only in test01 and test02
-------------------------

Reinstall a compute node and repeat the tests above.
