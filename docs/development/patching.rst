========
Patching
========

This is a log of command from the manual patching done in `bgo`.

deploy latest code:
===================
.. code-block:: bash
  cd ansible
  bin/bgo/deploy.sh

firewall:
=========

foreman-01:
-----------

Edit :file:`/opt/himlar/hieradata/common/common.yaml` and remove these lines::

  37: - '129.177.0.0/16'
  38: - '129.240.0.0/16'

dashboard-01:
-------------
Remove these rules for iptables::

  235 public openstack-dashboard and api accept tcp from 129.240.0.0/16
  235 public openstack-dashboard and api accept tcp from 129.177.0.0/16

access-01:
-------------
Remove these rules for iptables::

  190 dpapp-http accept tcp from 129.177.0.0/16
  190 dpapp-http accept tcp from 129.240.0.0/16

patching:
=========

login-01:
---------
.. code-block:: bash

  sudo ansible-playbook --become -e "hosts=bgo-nodes" lib/yumupdate.yaml

Unable to run this on bgo-controller and bgo-foreman-01 has failures.

controller-01
-------------
.. code-block:: bash

  yum update -y
  virsh shutdown bgo-master-01
  virsh shutdown bgo-cephmon-01
  virsh shutdown bgo-foreman-1.mgmt.iaas.intern
  virsh list  # this should be empty
  init 6
  virsh start bgo-master-01
  virsh start bgo-foreman-1.mgmt.iaas.intern
  virsh list # should show all three running

cephmon-01
-------------
.. code-block:: bash

  service ceph start
  ceph status # verify 3 mons running


controller-02
-------------
.. code-block:: bash

  yum update -y
  virsh list
  virsh shutdown bgo-db-01
  virsh shutdown bgo-access-01
  virsh shutdown bgo-logger-01
  virsh shutdown bgo-cephmon-02
  virsh list # this should be empty
  init 6
  virsh start bgo-db-01
  virsh start bgo-access-01
  virsh start bgo-logger-01
  virsh start bgo-cephmon-02
  virsh list # should show all four running

cephmon-02
----------
.. code-block:: bash

  service ceph start
  ceph status # verify 3 mons running

controller-03
-------------
.. code-block:: bash

  yum update -y
  virsh list
  virsh shutdown bgo-dashboard-01
  virsh shutdown bgo-proxy-01
  virsh shutdown bgo-cephmon-03
  virsh list # this should be empty
  init 6
  virsh start bgo-dashboard-01
  virsh start bgo-proxy-01
  virsh start bgo-cephmon-03
  virsh list # should show all four running

cephmon-03
----------
.. code-block:: bash

  service ceph start
  ceph status # verify 3 mons running

master-01
---------
.. code-block:: bash

  init 6


firewall:
=========

foreman-01:
-----------

Remove changes from :file:`/opt/himlar/hieradata/common/common.yaml`::

  cd /opt/himlar
  git checkout -f
