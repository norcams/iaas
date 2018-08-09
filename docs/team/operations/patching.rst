========
Patching
========

Last changed: 2018-08-09

Update repo
============

Repo list (test and/or prod) are updated during the planing phase of an
upgrade. But this is usually the repo we update:

* centos-base
* centos-extras
* centos-updates
* centos-qemu-ev
* ceph-jewel
* ceph-luminous
* epel
* mariadb
* rdo-ocata
* rdo-pike

.. IMPORTANT::
   Do **NOT** update :file:`calico22` without extra planned testing og
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

Make sure all nodes will autostart with::

  sudo ansible-playbook --become -e "myhosts=${location}-controller" lib/autostart_nodes.yaml


Normal OS patching
==================

For each for the production regions, `BGO` and `OSL`, do the following:

#. Upgrade virtual nodes, while excluding the **httpd**, **mariadb**
   and **mod_ssl** packages. This is usually safe to do outside of a
   scheduled maintenance window::

     sudo ansible-playbook -e "myhosts=${location}-nodes exclude=httpd*,MariaDB*,mod_ssl" lib/yumupdate.yaml

#. While in a scheduled maintenance window, upgrade virtual nodes::

     sudo ansible-playbook -e "myhosts=${location}-nodes" lib/yumupdate.yaml

#. Upgrade controller nodes::

     sudo ansible-playbook -e "myhosts=${location}-controller" lib/yumupdate.yaml

#. Check if all nodes are updated::

     sudo ansible-playbook -e "myhosts=${location}-nodes:${location}-controller" lib/checkupdate.yaml

For each controller do the following. Make sure cephmon is running
without error before starting on the next controller.

#. Check ceph status on cephmon::

     ceph status

#. Turn off the nodes on the controller before reboot::

     sudo ansible-playbook -e "myhosts=${location}-controller-<id> action=stop" lib/manage_nodes.yaml

#. Reboot the controller::

     sudo ansible-playbook -e "myhosts=${location}-controller-<id>" lib/reboot.yaml


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

#. Upgrade storage::

     sudo ansible-playbook --become -e "myhosts=${location}-storage" lib/yumupdate.yaml

#. Check if the storage nodes are upgraded::

     sudo ansible-playbook --become -e "myhosts=${location}-storage" lib/checkupdate.yaml

#. Reboot one storage node at the time and check ceph status before next nodes::

     ceph status

#. After all nodes are rebooted, ensure that automatic rebalancing is enabled:

     ceph osd unset noout

Compute
-------

None disruptive patching will only be possible for compute nodes
running in AZ ``<location>-default-1``. Compute nodes in
``<location>-legacy-1`` will need to be patched in a limited scheduled
maintenance window.

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
