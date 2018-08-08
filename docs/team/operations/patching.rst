========
Patching
========

Last changed: 2018-07-30

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


Do **NOT** update :file:`calico22` without extra planed testing og repackaging.

Avoid updating management repos at the same time as normal patching.

Set `loc` variable according to the environment which is going to be patched::

  loc=bgo


Before we start
===============

**Before you start, make sure the repo is up to date with the snapshot you
wish to use.**

Update ansible inventory for both `OSL` and `BGO` :file:`$himlarcli/ansible_hosts.py`

Make sure all nodes will autostart with::

  sudo ansible-playbook --become -e "myhosts=${loc}-controller" lib/autostart_nodes.yaml


Normal OS patching
==================

For each for the production regions, `BGO` and `OSL`, do the following:

#. Upgrade virtual nodes, while excluding the **httpd**
   and **mariadb** packages. This is usually safe to do outside of a
   scheduled maintenance window::

     sudo ansible-playbook -e "myhosts=${loc}-nodes exclude=httpd*,MariaDB*" lib/yumupdate.yaml

#. While in a scheduled maintenance windows, upgrade virtual nodes::

     sudo ansible-playbook -e "myhosts=${loc}-nodes" lib/yumupdate.yaml

#. Upgrade controller nodes::

     sudo ansible-playbook -e "myhosts=${loc}-controller" lib/yumupdate.yaml

#. Check if all nodes are updated::

     sudo ansible-playbook -e "myhosts=${loc}-nodes:<loc>-controller" lib/checkupdate.yaml

   .. IMPORTANT::
     For each controller do the following. Make sure cephmon is running
     without error before starting on the next controller.

#. Check ceph status on cephmon::

     ceph status

#. Turn off the nodes on the controller before reboot::

     sudo ansible-playbook -e "myhosts=${loc}-controller-<id> action=stop" lib/manage_nodes.yaml

#. Reboot the controller::

     sudo ansible-playbook -e "myhosts=${loc}-controller-<id>" lib/reboot.yaml


None disruptive patching
========================

These step could be done without notification and can be done later then normal
patching.

Storage
-------

#. Before you begin, you can avoid automatic rebalancing of the ceph
   cluster during maintenance. Run this command on a cephmon or
   storage node::

     ceph osd set noout

#. Upgrade storage::

     sudo ansible-playbook --become -e "myhosts=${loc}-storage" lib/yumupdate.yaml

#. Check if the storage nodes are upgraded::

     sudo ansible-playbook --become -e "myhosts=${loc}-storage" lib/checkupdate.yaml

#. Reboot one storage node at the time and check ceph status before next nodes::

     ceph status

#. After all nodes are rebooted, ensure that automatic rebalancing is enabled:

     ceph osd unset noout

Leaf
----

Only reboot one node at a time, and never if one node is a single point of
failure.

Upgrade node::

  apt-get update
  apt-get dist-upgrade

Reboot node.

Testing
=======

.. WARNING::
  In `BGO` and `OSL` there have been some trouble after patching. First check
  :file:`novactrl-01` and reboot the node if it has errors or no scheduler or
  conductor log entries.

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
