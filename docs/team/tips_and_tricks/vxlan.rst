===========================================
Setting up VXLAN tunneling using Openvswith
===========================================

This documents how to install and set up a VXLAN tunnel between two NREC instances running
CentOS 8.

Prerequisites:

1. Two running instances with at least UDP port 4789 open for each other

2. The IP address for each host, either IPv4 or IPv6

3. Logged in as root

Start by installing Openvswitch on each instance (from now on called Host A and Host B).

.. code:: bash
    yum install -y epel-release centos-release-openstack-train
    yum install -y openvswitch libibverbs
    systemctl enable --now openvswitch

Create a bridge called br-tun:
.. code:: bash
    ovs-vsctl add-br br-tun

On each host, create a VXLAN interface attached to the bridge, pointing to the IP address of
the other instance.

.. code:: bash
    ovs-vsctl add-port br-tun vxlan0 -- set interface vxlan0 type=vxlan options:remote_ip=[IP address to connect to]

Then set an IP address on the bridge interface, on Host A:
.. code:: bash
    ip addr add 192.168.0.1/24 dev br-tun

on Host B:
.. code:: bash
    ip addr add 192.168.0.2/24 dev br-tun

Now set up the link on both Host A and Host B and check for connectivity:
.. code:: bash
    ip link set up dev br-tun

.. code:: bash
[root@Host A ~]# ping -c 1 192.168.100.2
PING 192.168.100.2 (192.168.100.2) 56(84) bytes of data.
64 bytes from 192.168.100.2: icmp_seq=1 ttl=64 time=5.02 ms

--- 192.168.100.2 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 5.016/5.016/5.016/0.000 ms
