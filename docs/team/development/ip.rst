==============
Host overview
==============

Address plan for individual hosts/nodes. Also look at the
`IP addressing plan <../installation/ip.html>`_ for information about
location specific network.

Network hosts
-------------

============= ===== ===== ========
 node          inf   net   addr
============= ===== ===== ========
leaf-01        mgmt       x.x.x.1
leaf-02        mgmt       x.x.x.2
leaf-03        mgmt       x.x.x.3
leaf-04        mgmt       x.x.x.4
mgmt-01             priv  x.x.x.1
controller-00  mgmt       x.x.x.99
============= ===== ===== ========

Management hosts
----------------

Compute resource (controller) and profile (resources) for virtual nodes are
defined under :file:`config/nodes/` in `himlarcli <../operations/himlarcli/index.html>`_.

=========== ===== ===== ========
 node        inf   net   addr
=========== ===== ===== ========
login-01    eth0  mgmt  x.x.x.10
admin-01    eth0  mgmt  x.x.x.11
proxy-01    eth0  mgmt  x.x.x.12
logger-01   eth0  mgmt  x.x.x.13
monitor-01  eth0  mgmt  x.x.x.14
builder-01  eth0  mgmt  x.x.x.15
ns-01       eth0  mgmt  x.x.x.16
resolver-01 eth0  mgmt  x.x.x.17
resolver-02 eth0  mgmt  x.x.x.18
=========== ===== ===== ========


OOB hosts
---------

**FOR NOW ONLY APPLIES TO OSL**

Most hosts have their oob interface (iDrac, ILO, etc) set up with the last
octet the same as their trp counterpart. They are also registered in DNS with an
-lc ending to the normal host name.

Two exceptions to those rules is listed here:

=============  =========  === ======= =================================
 node             inf     net  addr    note
=============  =========  === ======= =================================
controller-04  em3.3378   oob   ---   No address assigned/necessary
admin-01       eth1       oob x.x.x.9 Interface attached to br2 on host
=============  =========  === ======= =================================

*em3.3378* on controller-04 is connected to a bridge interface (*br2*), which
sole purpose is to bridge the `OOB` network to `admin-01`.

This is to allow admin-01 to control the power interface on all physical nodes
(in the same vein as it can control the virtual power interface on all VM's).

.. NOTE::
   This only applies to the production environments (BGO and OSL) where we have
   control of the management switches.


Openstack nodes
---------------

Management net (mgmt) should have the same last octet as the transport net (trp).

================= ===== ===== ========
 node              inf   net   addr
================= ===== ===== ========
status-01         eth1  trp   x.x.x.21
report-01         eth1  trp   x.x.x.22
nat-linux-01      eth1  trp   x.x.x.26
nat-linux-02      eth1  trp   x.x.x.27
mq-01             eth1  trp   x.x.x.31
mq-02             eth1  trp   x.x.x.32
mq-03             eth1  trp   x.x.x.33
dns-01            eth1  trp   x.x.x.34
dns-02            eth1  trp   x.x.x.35
image-01          eth1  trp   x.x.x.36
image-02          eth1  trp   x.x.x.37
image-03          eth1  trp   x.x.x.38
dns-03            eth1  trp   x.x.x.39
db-01             eth1  trp   x.x.x.41
db-02             eth1  trp   x.x.x.42
db-03             eth1  trp   x.x.x.43
volume-01         eth1  trp   x.x.x.46
volume-02         eth1  trp   x.x.x.47
volume-03         eth1  trp   x.x.x.48
dashboard-01      eth1  trp   x.x.x.51
dashboard-02      eth1  trp   x.x.x.52
dashboard-03      eth1  trp   x.x.x.53
dashboard-mgmt-01 eth1  trp   x.x.x.54
access-01         eth1  trp   x.x.x.56
access-02         eth1  trp   x.x.x.57
access-03         eth1  trp   x.x.x.58
console-01        eth1  trp   x.x.x.61
console-02        eth1  trp   x.x.x.62
console-03        eth1  trp   x.x.x.63
coordinator-01    eth1  trp   x.x.x.64
novactrl-01       eth1  trp   x.x.x.66
novactrl-02       eth1  trp   x.x.x.67
novactrl-03       eth1  trp   x.x.x.68
network-01        eth1  trp   x.x.x.71
network-02        eth1  trp   x.x.x.72
network-03        eth1  trp   x.x.x.73
telemetry-01      eth1  trp   x.x.x.76
telemetry-02      eth1  trp   x.x.x.77
telemetry-03      eth1  trp   x.x.x.78
identity-01       eth1  trp   x.x.x.81
identity-02       eth1  trp   x.x.x.82
identity-03       eth1  trp   x.x.x.83
rgw-01            eth1  trp   x.x.x.84
rgw-02            eth1  trp   x.x.x.85
api-01            eth1  trp   x.x.x.86
api-02            eth1  trp   x.x.x.87
api-03            eth1  trp   x.x.x.88
cephmon-object-01 eth1  trp   x.x.x.89
cephmon-object-02 eth1  trp   x.x.x.90
cephmon-01        eth1  trp   x.x.x.91
cephmon-02        eth1  trp   x.x.x.92
cephmon-03        eth1  trp   x.x.x.93
cephmon-object-03 eth1  trp   x.x.x.94
rgw-03            eth1  trp   x.x.x.95
metric-01         eth1  trp   x.x.x.96
metric-02         eth1  trp   x.x.x.97
metric-03         eth1  trp   x.x.x.98
================= ===== ===== ========

Openstack hosts
---------------

============== ===== ===== =========
 node           inf   net   addr
============== ===== ===== =========
controller-01  eth1  trp   x.x.x.100
controller-02  eth1  trp   x.x.x.101
controller-03  eth1  trp   x.x.x.102
controller-04  eth1  trp   x.x.x.114
compute-01*    eth1  trp   x.x.x.103
compute-02*    eth1  trp   x.x.x.104
compute-03*    eth1  trp   x.x.x.105
compute-04*    eth1  trp   x.x.x.111
compute-05*    eth1  trp   x.x.x.112
compute-06*    eth1  trp   x.x.x.113
compute-07*    eth1  trp   x.x.x.115
compute-08*    eth1  trp   x.x.x.116
storage-01*    eth1  trp   x.x.x.106
storage-02*    eth1  trp   x.x.x.107
storage-03*    eth1  trp   x.x.x.108
storage-04*    eth1  trp   x.x.x.109
storage-05*    eth1  trp   x.x.x.110
============== ===== ===== =========
