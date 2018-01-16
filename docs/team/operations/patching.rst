========
Patching
========

Last changed: 2017-05-23

Update repo
============

These repos should be updated when doing a normal patching:

* centos-base
* centos-extras
* centos-updates
* centos-qemu-ev
* ceph-jewel
* ceph-luminous
* epel
* mariadb
* rdo-ocata
* rdo-newton

Do **NOT** update :file:`calico22` without extra planed testing og repackaging.

Avoid updating management repos at the same time as normal patching.

Before we start
===============

**Before you start, make sure the repo is up to date with the snapshot you
wish to use.**

Update ansible inventory for both `OSL` and `BGO` :file:`$himlarcli/ansible_hosts.py`

Make sure all nodes will autostart with::

    sudo ansible-playbook --become -e "hosts=<loc>-controller" lib/autostart_nodes.yaml

.. WARNING::
  See https://trello.com/c/7muUakUi/880-tjenester-starter-ikke-etter-reboot

  Quick fix on all nodes
  :file:`sudo ansible -b -u iaas <loc>-nodes -m command -a 'systemctl add-wants multi-user.target network.target'`

Normal OS patching
==================

.. WARNING::

  To avoid split brain in the galera cluster (only BGO/OSL) make sure the cluster
  size are 3 before starting. To check::

  $ root@<loc>-db-01: mysql
  $ mysql: SHOW STATUS LIKE 'wsrep_cluster_size';

For each for the production regions, `BGO` and `OSL`, do the following:

Upgrade virutal nodes::

  sudo ansible-playbook --become -e "hosts=<loc>-nodes" lib/yumupdate.yaml

Upgrade controller nodes::

  sudo ansible-playbook --become -e "hosts=<loc>-controller" lib/yumupdate.yaml

Check if all nodes are updated::

  sudo ansible-playbook --become -e "hosts=<loc>-nodes:<loc>-controller" lib/checkupdate.yaml


**Reboot each controller one at the time and verify all nodes.have started**
(might use `lib/reboot.yaml`)

Make sure cephmon is running without error before starting on the next controller.
Start node on controller if not automatically started:

  virsh start <node>

Check ceph status on cephmon::

  ceph status

None distruptive patching
=========================

These step could be done without notification and can be done later then normal
patching.

Storage
-------

Before you begin, you can avoid automatic rebalancing of the ceph cluster during
maintenance. Run this command on a cephmon or storage node::

  ceph osd set noout

Upgrade storage::

  sudo ansible-playbook --become -e "hosts=<loc>-storage" lib/yumupdate.yaml

Check if the storage nodes are upgraded::

  sudo ansible-playbook --become -e "hosts=<loc>-storage" lib/checkupdate.yaml

Reboot one storage node at the time and check ceph status before next nodes::

  ceph status

After all nodes are rebooted, ensure that automatic rebalancing is enabled:

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
