Patching
========

This is a log of command from the manual patching done in `bgo`.

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
