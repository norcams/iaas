========
Patching
========

Last changed: 2017-04-18

Before we start
===============

Update ansible inventory for both `OSL` and `BGO` :file:`$himlarcli/ansible_hosts.py`

Normal OS patching
==================

**This should be done in a notified timeslot.**

For each for the production regions, `BGO` and `OSL`, do the following:

Upgrade virutal nodes::

  sudo ansible-playbook --become -e "hosts=<loc>-nodes" lib/yumupdate.yaml

Upgrade controller nodes::

  sudo ansible-playbook --become -e "hosts=<loc>-controller" lib/yumupdate.yaml

Check if all nodes are updated::

  sudo ansible-playbook --become -e "hosts=<loc>-nodes:<loc>-controller" lib/checkupdate.yaml


**Reboot each controller one at the time and start all nodes.**

Make sure cephmon is running without error before starting on the next controller.
Start node on controller::

  virsh start <node>

Check ceph status on cephmon::

  ceph status

None distruptive patching
=========================

These step could be done without notification and can be done later then normal
patching.

Storage
-------

Upgrade storage::

  sudo ansible-playbook --become -e "hosts=<loc>-storage" lib/yumupdate.yaml

Check if the storage nodes are upgraded::

  sudo ansible-playbook --become -e "hosts=<loc>-storage" lib/checkupdate.yaml

Reboot one storage node at the time and check ceph status before next nodes::

  ceph status

Leaf
----

Only reboot one node at a time, and never if one node is a single point of
failure.

Upgrade node::

  apt-get update
  apt-get dist-upgrade

Reboot node.
