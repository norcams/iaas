==================
IP addressing plan
==================

.. contents::

Instance workloads
------------------

This describes from what IP network and prefix an instance workload will
receive its address. Normally this will happen at boot time through DHCP.

Public
^^^^^^

Public IPv4 network.

========= ========= ====================
 region    env       IPv4
========= ========= ====================
 bgo      uib conn   158.37.64.0/24
 bgo      prod       158.37.65.0/24
 bgo      prod       158.39.77.0/24
 bgo      prod       158.39.74.0/24
 bgo      prod       158.39.201.0/24
 bgo      lhc        109.105.127.128/26
 osl      prod       158.37.63.0/24
 osl      prod       158.37.66.0/24
 osl/bgo  reserved   158.37.67.0/24
 osl      prod       158.39.75.0/24
 osl      prod       158.39.48.0/24
 osl      prod       158.39.200.0/24
 test01   test       129.177.31.64/27
 test01   test       129.177.31.96/27
 test02   test       (10.100.200.0/24)
 vagrant  dev        (192.168.0.0/24)
 local1   dev        (192.168.12.0/24)
 local2   dev        (192.168.13.0/24)
 local3   dev        (192.168.12.0/24)
========= ========= ====================

Public IPv6 network.

========= ======= ================== ======
 region    env     Private IPv4       IPv6
========= ======= ================== ======
 bgo      prod                        2001:700:2:8300::/56
 bgo      lhc                         2001:948:62:3::/64
 bgo      lhc       10.109.0.0/22     2001:948:62:4::/64
 osl      prod                        2001:700:2:8200::/56
 test01   test     (10.0.250.0/24)    (2001:700:200:915::/64)
 test02   test                        (fd32::/64)
 local1   dev                         TBD
 local2   dev                         TBD
 local3   dev                         TBD
 vagrant  dev                         (fc00:700:100:200::/64)
 dev      dev                         TBD
========= ======= ================== ======

.. NOTE:: The networks enclosed in parentheses are not reachable outside of
          their locally managed routing domains.

Infrastructure and management
-----------------------------

This describes addressing of the IaaS system and backend services.

transport network
^^^^^^^^^^^^^^^^^

Internal routed link network used for routing all service and storage traffic.

Network prefixes

========= ================
 env       IPv4 prefix
========= ================
 prod      `172.18.0.0/16`_
 test      `172.30.0.0/16`_
 dev       `172.31.8.0/21`_
========= ================

.. _172.18.0.0/16: http://www.davidc.net/sites/default/subnets/subnets.html?network=172.18.0.0&mask=16&division=29.723d9c40
.. _172.30.0.0/16: http://www.davidc.net/sites/default/subnets/subnets.html?network=172.30.0.0&mask=16&division=29.723d9c40
.. _172.31.8.0/21: http://www.davidc.net/sites/default/subnets/subnets.html?network=172.31.8.0&mask=21&division=29.723d9c40

IP networks in use

========= ======= ============ ================= =========== ========= ========
 region    env     Name         IPv4              IPv6        VLAN      BGP AS
========= ======= ============ ================= =========== ========= ========
 bgo       prod    trp          172.18.0.0/21     fd00::/64   100       65501
 bgo       prod    ceph         172.20.0.0/21     NA          110/130   NA
 bgo       prod    live         172.22.0.0/21     NA          120       NA
 bgo       prod    link1        172.18.228.0/30   TBD                   65502
 osl       prod    trp          172.18.32.0/21    fd32::/64   100       65502
 osl       prod    ceph         172.20.32.0/21    NA          110/130   NA
 osl       prod    live         172.22.32.0/21    NA          120       NA
 osl       prod    link1        172.18.228.0/30   TBD                   65502
 test01    test    trp          172.30.0.0/21     fd00::/64   100       65535
 test01    test    ceph         172.29.0.0/21     NA          110/130   NA
 test01    test    live         172.31.0.0/21     NA          120       NA
 test02    test    trp          172.30.32.0/24    TBD                   65536
 vagrant   dev     trp          172.31.8.0/24     TBD                   65500
 local1    dev     trp          172.31.12.0/24    TBD         100
 local2    dev     trp          172.31.13.0/24    TBD         101
========= ======= ============ ================= =========== ========= ========

Prefix reservations per link type and location

====== =========== ======== ================== =============
 env    link        region   IPv4 prefix        IPv6 prefix
====== =========== ======== ================== =============
 prod   leaf-node   bgo      `172.18.0.0/19`_   TBD
 prod   leaf-node   osl      `172.18.32.0/19`_  TBD
 prod   leaf-node   TBD      `172.18.64.0/19`_  TBD
====== =========== ======== ================== =============

As specified above, each region-specific transport network block is again split
up in smaller prefix reservations to allow for up to 4 separated L2 switching
domains.

.. _172.18.0.0/19:  http://www.davidc.net/sites/default/subnets/subnets.html?network=172.18.0.0&mask=19&division=7.31
.. _172.18.32.0/19: http://www.davidc.net/sites/default/subnets/subnets.html?network=172.18.32.0&mask=19&division=7.31
.. _172.18.64.0/19: http://www.davidc.net/sites/default/subnets/subnets.html?network=172.18.32.0&mask=19&division=7.31

mgmt network
^^^^^^^^^^^^

Interactive ssh access, os level maintenance services

========= ==================
 env       IPv4 prefix
========= ==================
 prod      `172.16.0.0/16`_
 test      `172.28.0.0/17`_
 dev       `172.31.0.0/21`_
========= ==================

.. _172.16.0.0/16: http://www.davidc.net/sites/default/subnets/subnets.html?network=172.16.0.0&mask=16&division=29.723d9c40
.. _172.28.0.0/17: http://www.davidc.net/sites/default/subnets/subnets.html?network=172.28.0.0&mask=17&division=29.723d9c40
.. _172.31.0.0/21: http://www.davidc.net/sites/default/subnets/subnets.html?network=172.31.0.0&mask=21&division=29.723d9c40

========= ======= =================== ====== ======
 region    env     IPv4                IPv6   vlan
========= ======= =================== ====== ======
 bgo      prod     172.16.0.0/21       TBD
 osl      prod     172.16.32.0/21      TBD
 test01   test     172.28.0.0/24       TBD
 test02   test     172.28.32.0/24      TBD
 vagrant  dev      172.31.0.0/24       TBD
 local1   dev      172.31.4.0/24       TBD    10
 local2   dev      172.31.5.0/24       TBD    11
========= ======= =================== ====== ======


oob network
^^^^^^^^^^^

Out of band management, `IPMI BMC devices`_.

====== ================
 env    IPv4 prefix
====== ================
 prod   `172.17.0.0/16`_
 test   `172.28.128.0/17`_
====== ================

.. _172.17.0.0/16: http://www.davidc.net/sites/default/subnets/subnets.html?network=172.17.0.0&mask=16&division=29.723d9c40
.. _172.28.128.0/17: http://www.davidc.net/sites/default/subnets/subnets.html?network=172.28.128.0&mask=17&division=29.723d9c40
.. _172.31.16.0/21: http://www.davidc.net/sites/default/subnets/subnets.html?network=172.31.16.0&mask=21&division=29.723d9c40

========= ======= =================== ====== ======
 region    env     IPv4                IPv6   vlan
========= ======= =================== ====== ======
 bgo      prod     172.17.0.0/21       N/A
 osl      prod     172.17.32.0/21      N/A
 test01   test     172.28.159.0/21     N/A
 test02   test     172.28.160.0/24     N/A
========= ======= =================== ====== ======

Management switches

========= ======= =================== ====== ======
 region    env     IPv4                IPv6   vlan
========= ======= =================== ====== ======
  osl       prod    10.17.32.0/24        N/A
  bgo       prod    10.17.0.0/24         N/A
========= ======= =================== ====== ======

.. _IPMI BMC devices: https://en.wikipedia.org/wiki/Intelligent_Platform_Management_Interface#Baseboard_management_controller


Test02 internal gateway network
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Internal network between virtual leaf node (test02-leaf-01) and the host
(test02-controller-00). Public traffic from instances is routed through this
network from their default gateway (leaf) via the controlelr host and then
NAT'ed out on its outside interface.

====== ================= ===== ====== ============ ======
                          Controller          Leaf
------ ----------------- ------------ -------------------
 Class       Network       IF  Adress     IF       Adress
====== ================= ===== ====== ============ ======
 IPv4  192.168.122.0/24   br2    1     bridge.100    2
 IPv6  fd96::/64          br2    1     bridge.100    2
====== ================= ===== ====== ============ ======


Reserved internal IP addressing
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

For external infrastructure which potentially may be connected to the
NREC infrastructure in some point in time, the following addressing space
is reserved:

=================== =============
 IPv4                Description
=================== =============
 172.24.0.0/16       uib-ds
=================== =============
