==============
Host overview
==============

Address plan for individual hosts/nodes. Also look at the
`IP addressing plan <../installation/ip.html>`_ for inforamtion about
location specific network.

Network hosts
-------------

========= ===== ===== ========
 node      inf   net   addr
========= ===== ===== ========
leaf-01    mgmt       x.x.x.1
leaf-02    mgmt       x.x.x.2
leaf-03    mgmt       x.x.x.3
leaf-04    mgmt       x.x.x.4
mgmt-01    mgmt       x.x.x.9
========= ===== ===== ========

Management hosts
----------------

=========== ===== ===== ======== =============== =========
 node        inf   net   addr     host            profile
=========== ===== ===== ======== =============== =========
login-01    eth0  mgmt  x.x.x.10 NA
admin-01    eth0  mgmt  x.x.x.11 controller-01   L
proxy-01    eth0  mgmt  x.x.x.12 controller-01   S
logger-01   eth0  mgmt  x.x.x.13 controller-01   L
monitor-01  eth0  mgmt  x.x.x.14 controller-01   M
=========== ===== ===== ======== =============== =========

Openstack nodes
---------------

Management net (mgmt) should have the same last octet as the
trpport net (trp).

============== ===== ===== ======== ================ =========
 node           inf   net   addr     host             profile
============== ===== ===== ======== ================ =========
status-01      eth1  trp   x.x.x.21 controller-02     S
mq-01          eth1  trp   x.x.x.31 controller-01     S
mq-02          eth1  trp   x.x.x.32 NA
mq-03          eth1  trp   x.x.x.33 NA
image-01       eth1  trp   x.x.x.36 controller-02     M
image-02       eth1  trp   x.x.x.37 NA
image-03       eth1  trp   x.x.x.38 NA
db-01          eth1  trp   x.x.x.41 controller-01     S
db-02          eth1  trp   x.x.x.42 controller-02     S
db-03          eth1  trp   x.x.x.43 NA
volume-01      eth1  trp   x.x.x.46 controller-03     M
volume-02      eth1  trp   x.x.x.47 NA
volume-03      eth1  trp   x.x.x.48 NA
dashboard-01   eth1  trp   x.x.x.51 controller-02     M
dashboard-02   eth1  trp   x.x.x.52 NA
dashboard-03   eth1  trp   x.x.x.53 NA
access-01      eth1  trp   x.x.x.56 controller-03     S
access-02      eth1  trp   x.x.x.57 NA
access-03      eth1  trp   x.x.x.58 NA
console-01     eth1  trp   x.x.x.61 controller-03     M
console-02     eth1  trp   x.x.x.62 NA
console-03     eth1  trp   x.x.x.63 NA
novactrl-01    eth1  trp   x.x.x.66 controller-02     M
novactrl-02    eth1  trp   x.x.x.67 NA
novactrl-03    eth1  trp   x.x.x.68 NA
network-01     eth1  trp   x.x.x.71 controller-03     M
network-02     eth1  trp   x.x.x.72 NA
network-03     eth1  trp   x.x.x.73 NA
identity-01    eth1  trp   x.x.x.81 controller-03     M
identity-02    eth1  trp   x.x.x.82 NA
identity-03    eth1  trp   x.x.x.83 NA
api-01         eth1  trp   x.x.x.86 controller-01     M
api-02         eth1  trp   x.x.x.87 NA
api-03         eth1  trp   x.x.x.88 NA
cephmon-01     eth1  trp   x.x.x.91 controller-01     S
cephmon-02     eth1  trp   x.x.x.92 controller-02     S
cephmon-03     eth1  trp   x.x.x.93 controller-03     S
============== ===== ===== ======== ================ =========

Openstack hosts
---------------

============== ===== ===== =========
 node           inf   net   addr
============== ===== ===== =========
controller-01  eth1  trp   x.x.x.100
controller-02  eth1  trp   x.x.x.101
controller-03  eth1  trp   x.x.x.102
compute-01*    eth1  trp   x.x.x.103
compute-02*    eth1  trp   x.x.x.104
compute-03*    eth1  trp   x.x.x.105
storage-01*    eth1  trp   x.x.x.106
storage-02*    eth1  trp   x.x.x.107
storage-03*    eth1  trp   x.x.x.108
storage-04*    eth1  trp   x.x.x.109
storage-05*    eth1  trp   x.x.x.110
============== ===== ===== =========
