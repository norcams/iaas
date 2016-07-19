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

Public network.

========= ======= ================= ======
 region    env     IPv4              IPv6
========= ======= ================= ======
 bgo      prod     158.39.77.0/24    2001:700:2:8300::/56
 osl      prod     158.37.63.0/24    2001:700:2:8200::/56
 trd      prod     158.39.48.0/24    2001:700:2:8400::/56
 dev01    dev      129.177.31.96/27  TBD
 dev02    dev      158.38.144.0/24   TBD
 dev03    dev      x.y/z             TBD
 vagrant  dev      (10.0.0.0/24)     TBD
========= ======= ================= ======

.. NOTE:: The networks enclosed in parentheses are not reachable outside of
          their locally managed routing domains.

Private
^^^^^^^

========== ===============
 protocol     prefix
========== ===============
 IPv4       10.0.0.0/9
 IPv6       TBD
========== ===============

Region-specific private network. All instances in the same region are
reachable if security policy is configured.

========= ======= ============== ======
 region    env     IPv4           IPv6
========= ======= ============== ======
 bgo       prod    10.1.0.0/20    TBD
 osl       prod    10.2.0.0/20    TBD
 trd       prod    10.3.0.0/20    TBD
 dev01     dev     10.17.0.0/20   TBD
 dev02     dev     10.18.0.0/20   TBD
 dev03     dev     10.19.0.0/20   TBD
 vagrant   dev     10.16.0.0/20   TBD
========= ======= ============== ======

Internal
^^^^^^^^

Future cross-region, GRE+IPsec encrypted network.

========= ======= ============== ======
 region    env     IPv4           IPv6
========= ======= ============== ======
 bgo      prod     10.x/y         TBD
 trd      prod     10.x/y         TBD
 osl      prod     10.x/y         TBD
 dev01    dev      10.x/y         TBD
 dev02    dev      10.x/y         TBD
 dev03    dev      10.x/y         TBD
========= ======= ============== ======


Infrastructure and management
-----------------------------

This describes adressing of the IaaS system and backend services.

service addresses
^^^^^^^^^^^^^^^^^

These addresses are used for public and internal service endpoints.

========= ========= ====== ================ ======
 region    type      env    IPv4             IPv6
========= ========= ====== ================ ======
 bgo       private   prod   172.19.0.0/21    TBD
 osl       private   prod   172.19.32.0/21   TBD
 trd       private   prod   172.19.64.0/21   TBD
 dev01     private   dev    172.31.16.0/24   TBD
 dev02     private   dev    172.31.17.0/24   TBD
 dev03     private   dev    172.31.18.0/24   TBD
 all       public    dev    As needed [1]_   TBD
 all       public    prod   As needed [1]_   TBD
========= ========= ====== ================ ======

.. [1] Pulibc IPv4 service addresses are limited and assigned as needed from
   the end of the `public`_ instance range in each env.

mgmt network
^^^^^^^^^^^^

Interactive ssh access, os level maintenance services

====== ===============
 env    IPv4 prefix
====== ===============
 prod   172.16.0.0/16
 dev    172.31.0.0/21
====== ===============

========= ======= =================== ====== ======
 region    env     IPv4                IPv6   vlan
========= ======= =================== ====== ======
 bgo      prod     172.16.0.0/21       TBD
 osl      prod     172.16.32.0/21      TBD
 trd      prod     10.171.91.0/24      TBD    1077
 vagrant  dev      172.31.0.0/24       TBD
 dev01    dev      172.31.1.0/24       TBD
 dev02    dev      172.31.2.0/24       TBD    1078
 local1   dev      172.31.200.0/24     TBD    10
========= ======= =================== ====== ======

oob network
^^^^^^^^^^^

Out of band management, `IPMI BMC devices`_.

====== ================
 env    IPv4 prefix
====== ================
 prod   172.17.0.0/16
 dev    172.31.8.0/21
====== ================

========= ======= =================== ====== ======
 region    env     IPv4                IPv6   vlan
========= ======= =================== ====== ======
 bgo      prod     172.17.0.0/21       N/A
 osl      prod     129.240.224.65/27   N/A    old
 osl      prod     172.17.32.0/21      N/A
 trd      prod     10.171.86.1/24      N/A    986
 vagrant  dev      172.31.8.0/24       N/A
 dev01    dev      172.31.9.0/24       N/A
 dev02    dev      172.31.10.0/24      N/A    1079
========= ======= =================== ====== ======

.. _IPMI BMC devices: https://en.wikipedia.org/wiki/Intelligent_Platform_Management_Interface#Baseboard_management_controller

transport network
^^^^^^^^^^^^^^^^^

Internal routed link network used for routing all service and storage traffic.

Network prefixes

========= ================
 env       IPv4 prefix
========= ================
 `prod`_   172.18.0.0/16
 `dev`_    172.31.32.0/20
========= ================

.. _prod: http://www.davidc.net/sites/default/subnets/subnets.html?network=172.18.0.0&mask=16&division=29.723d9c40
.. _dev: http://www.davidc.net/sites/default/subnets/subnets.html?network=172.31.32.0&mask=20&division=29.723d9c40

Prefix reservations per link type and location

====== =========== ======== ================== =============
 env    link        region   IPv4 prefix        IPv6 prefix
====== =========== ======== ================== =============
 prod   leaf-node   bgo      172.18.0.0/19      TBD
 prod   leaf-node   osl      172.18.32.0/19     TBD
 prod   leaf-node   trd      172.18.64.0/19     TBD
 prod   gw-gw       bgo      172.18.224.0/22    TBD
 prod   gw-gw       osl      172.18.228.0/22    TBD
 prod   gw-gw       trd      172.18.232.0/22    TBD
 dev    leaf-node   vagrant  172.31.32.0/23     TBD
 dev    leaf-node   dev01    172.31.34.0/23     TBD
 dev    leaf-node   dev02    172.31.36.0/23     TBD
 dev    gw-gw       vagrant  172.31.46.0/26
 dev    gw-gw       dev01    172.31.46.64/26    TBD
 dev    gw-gw       dev02    172.31.46.128/26   TBD
====== =========== ======== ================== =============

IP networks in use

========= ======= ============ ================= ====== ====== ========
 region    env     Name         IPv4              IPv6   VLAN   BGP AS
========= ======= ============ ================= ====== ====== ========
 bgo       prod    transport1   172.18.0.0/21     TBD    100    65501
 bgo       prod    transport2   172.18.8.0/21     TBD    200    65501
 osl       prod    transport1   172.18.32.0/21    TBD    100    65502
 osl       prod    transport2   172.18.40.0/21    TBD    200    65502
 osl       prod    link1        172.18.228.0/30   TBD           65502
 trd       prod    transport1   172.18.64.0/21    TBD    100    65503
 trd       prod    transport2   172.18.72.0/21    TBD    200    65503
 vagrant   dev     transport1   172.31.32.0/24    TBD           65500
 vagrant   dev     transport2   172.31.33.0/24    TBD           65500
 dev01     dev     transport1   172.31.34.0/24    TBD           65535
 dev01     dev     transport2   172.31.35.1/24    TBD           65535
 dev02     dev     transport1   172.31.36.0/24    TBD    1074   65534
 dev02     dev     transport2   172.31.37.0/24    TBD    1074   65534
 local1    dev     transport    172.31.100.0/24   TBD    100    -
========= ======= ============ ================= ====== ====== ========

As specified above, each region-specific transport network block is again split
up in smaller prefix reservations to allow for up to 4 separated L2 switching
domains, one per interface on the physical nodes.

.. _bgo prod: http://www.davidc.net/sites/default/subnets/subnets.html?network=172.18.0.0&mask=19&division=7.31


Old data (to be removed)
----------------------------------------

We have 3 different subnets:

::

    x.x.x.x/27 oob
    x.x.x.x/27 mgmt
    x.x.x.x/24 cloud-public-addresses

mgmt ip allocation
^^^^^^^^^^^^^^^^^^

::

    x.x.x.1  gw
    x.x.x.2  gw
    x.x.x.3  gw
    x.x.x.4  login-1
    x.x.x.5  foreman-1
    x.x.x.6  empty
    x.x.x.7  leaf-1
    x.x.x.8  leaf-2
    x.x.x.9  leaf-3
    x.x.x.10 leaf-4
    x.x.x.11 controller-1
    x.x.x.12 controller-2
    x.x.x.13 controller-3
    x.x.x.14 compute-1
    x.x.x.15 compute-2
    x.x.x.16 compute-3
    x.x.x.17 osd-1
    x.x.x.18 osd-2
    x.x.x.19 osd-3
    x.x.x.20 osd-4
    x.x.x.21 osd-5

cloud address ip allocation
^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

    ### x.x.x.x/24 reservert for uh-sky
    # x.x.x.0/29 reservert nett-loopback
    x.x.x.0/32    - ledig
    172.16.0.1/32    fd00:0::1/128    leaf1
    172.16.0.2/32    fd00:0::2/128    leaf2
    x.x.x.3/32    leaf3
    x.x.x.4/32    leaf4
    x.x.x.5/32    - ledig
    x.x.x.6/32    - ledig
    x.x.x.7/32    - ledig
    # x.x.x.8/29  - ledig
    # x.x.x.16/28 - ledig
    # x.x.x.32/27 reservert nett-p2p
    172.16.1.0/24    fd00:1::0/64   leaf1 - leaf2
    x.x.x.36/30   leaf3 - leaf4
    x.x.x.40/30   leaf2 - leaf3
    x.x.x.44/30   - ledig
    x.x.x.48/30   - ledig
    x.x.x.52/30   - ledig
    x.x.x.56/30   - ledig
    x.x.x.60/30   - ledig
    # x.x.x.64/26 - ledig
    # x.x.x.128/25 reservert host-nett
    172.16.100.0/24    fd00:100::0/64    host-nett for all fysiske noder
        172.16.100.1 leaf1
        172.16.100.2 leaf2
        172.16.100.3 leaf3
        172.16.100.4 leaf4
        172.16.100.5 controller1
        172.16.100.6 controller2
        172.16.100.7 controller3
        172.16.100.8 compute1
        172.16.100.9 compute2
        172.16.100.10 compute3
        172.16.100.11 storage1
        172.16.100.12 storage2
        172.16.100.13 storage3
        172.16.100.14 storage4
        172.16.100.15 storage5
    # below is historic
    x.x.x.128/29 controller 1
    x.x.x.136/29 controller 2
    x.x.x.144/29 controller 3
    x.x.x.152/29 compute 1
    x.x.x.160/29 compute 2
    x.x.x.168/29 compute 3
    x.x.x.176/29 storage 1
    x.x.x.184/29 storage 2
    x.x.x.192/29 storage 3
    x.x.x.200/29 storage 4
    x.x.x.208/29 storage 5
    x.x.x.216/29 - ledig
    x.x.x.224/29 - ledig
    x.x.x.232/29 - ledig
    x.x.x.240/29 - ledig
    x.x.x.248/29 - ledig

All boxes, including network equipment, have a mgmt interface and an oob interface
on two separate networks in addition to the cloud public network.