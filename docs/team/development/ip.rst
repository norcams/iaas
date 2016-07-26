Host IP overview
================


Address plan for individual hosts/nodes. Also look at the
`IP addressing plan <../installation/ip.html>`_ for inforamtion about
location specific network.

Network hosts
-------------

========= ===== ===== ========
 node      inf   net   addr
========= ===== ===== ========
leaf-01    mgmt       x.x.x.4
leaf-02    mgmt       x.x.x.5
leaf-03    mgmt       x.x.x.6
leaf-04    mgmt       x.x.x.7
========= ===== ===== ========

Management hosts
----------------

========= ===== ===== ========
 node      inf   net   addr
========= ===== ===== ========
login-01  eth0  mgmt  x.x.x.10
admin-01  eth0  mgmt  x.x.x.11
proxy-01  eth0  mgmt  x.x.x.12
logger-01 eth0  mgmt  x.x.x.13
========= ===== ===== ========

Openstack nodes
---------------

Management net (mgmt) should have the same last octet as the
transport net (trans).

============== ===== ===== ========
 node           inf   net   addr
============== ===== ===== ========
master-01      eth1  trans x.x.x.20
mq-01          eth1  trans x.x.x.31
mq-02          eth1  trans x.x.x.32
mq-03          eth1  trans x.x.x.33
image-01       eth1  trans x.x.x.36
image-02       eth1  trans x.x.x.37
image-03       eth1  trans x.x.x.38
db-01          eth1  trans x.x.x.41
db-02          eth1  trans x.x.x.42
db-03          eth1  trans x.x.x.43
dashboard-01   eth1  trans x.x.x.51
dashboard-02   eth1  trans x.x.x.52
dashboard-03   eth1  trans x.x.x.53
access-01      eth1  trans x.x.x.56
access-02      eth1  trans x.x.x.57
access-03      eth1  trans x.x.x.58
console-01     eth1  trans x.x.x.61
console-02     eth1  trans x.x.x.62
console-03     eth1  trans x.x.x.63
cephmon-01     eth1  trans x.x.x.91
cephmon-02     eth1  trans x.x.x.92
cephmon-03     eth1  trans x.x.x.93
============== ===== ===== ========

Openstack hosts
---------------

============== ===== ===== =========
 node           inf   net   addr
============== ===== ===== =========
controller-01  eth1  trans x.x.x.100
controller-01  eth1  trans x.x.x.101
controller-01  eth1  trans x.x.x.102
compute-01*    eth1  trans x.x.x.103
compute-01*    eth1  trans x.x.x.104
compute-02*    eth1  trans x.x.x.105
storage-03*    eth1  trans x.x.x.106
storage-02*    eth1  trans x.x.x.107
storage-03*    eth1  trans x.x.x.108
storage-04*    eth1  trans x.x.x.109
storage-05*    eth1  trans x.x.x.110
============== ===== ===== =========
