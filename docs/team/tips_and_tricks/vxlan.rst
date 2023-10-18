===========================================
Setting up VXLAN tunneling using Openvswith
===========================================

This documents how to install and set up a VXLAN tunnel between two NREC instances running
el9 (e.g. almalinux 9).

Prerequisites:

1. Two running instances with at least UDP port 4789 open for each other

2. The IP address for each host, either IPv4 or IPv6

3. Logged in as root

Start by installing Openvswitch and iperf3 on each instance (from now
on called vxlan-host-a and vxlan-host-b).

.. code:: bash

    dnf install -y epel-release
    dnf install -y https://www.rdoproject.org/repos/rdo-release.el9.rpm
    dnf install -y openvswitch libibverbs
    dnf install -y iperf3
    systemctl enable --now openvswitch

Create a bridge called br-tun:

.. code:: bash

    ovs-vsctl add-br br-tun

On each host, create a VXLAN interface attached to the bridge, pointing to the IP address of
the other instance.

.. code:: bash

    ovs-vsctl add-port br-tun vxlan0 -- set interface vxlan0 type=vxlan options:remote_ip=[IP address to connect to]

Then set an IP address on the bridge interface, on vxlan-host-a:

.. code:: bash

    ip addr add 192.168.0.1/24 dev br-tun

on vxlan-host-b:

.. code:: bash

    ip addr add 192.168.0.2/24 dev br-tun

Now set up the link on both vxlan-host-a and vxlan-host-b:

.. code:: bash

    ip link set up dev br-tun

.. IMPORTANT::
   VXLAN adds significant overhead on the packets, and you must adjust
   the MTU accordingly.  For IPv4 only traffic an MTU size of 1450 can
   be used, but IPv6 adds another 20 bytes on top of that, so MTU size
   of 1430 is necessary.


Set MTU on the br-tun interface (for NREC, use **1450**. If using
jumbo frames: **8950**):

.. code:: bash

    ip link set mtu 1450 dev br-tun

Check for connectivity:

.. code:: bash

  [root@vxlan-host-a ~]# ping -c 1 192.168.0.2
  PING 192.168.0.2 (192.168.0.2) 56(84) bytes of data.
  64 bytes from 192.168.0.2: icmp_seq=1 ttl=64 time=5.02 ms
  
  --- 192.168.0.2 ping statistics ---
  1 packets transmitted, 1 received, 0% packet loss, time 0ms
  rtt min/avg/max/mdev = 5.016/5.016/5.016/0.000 ms

Check bandwidth. On vxlan-host-b:

.. code:: bash

  [root@vxlan-host-b ~]# iperf3 -s

on vxlan-host-a:

.. code:: bash

  [root@vxlan-host-a ~]# iperf3 -c 192.168.0.2
  Connecting to host 192.168.0.2, port 5201
  [  5] local 192.168.0.1 port 58242 connected to 192.168.0.2 port 5201
  [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
  [  5]   0.00-1.00   sec   135 MBytes  1.14 Gbits/sec    2    456 KBytes
  [  5]   1.00-2.00   sec   128 MBytes  1.08 Gbits/sec    0    558 KBytes
  [  5]   2.00-3.00   sec   125 MBytes  1.05 Gbits/sec    0    618 KBytes
  [  5]   3.00-4.00   sec   137 MBytes  1.15 Gbits/sec    0    665 KBytes
  [  5]   4.00-5.00   sec   136 MBytes  1.14 Gbits/sec    0    706 KBytes
  [  5]   5.00-6.00   sec   138 MBytes  1.15 Gbits/sec    0    732 KBytes
  [  5]   6.00-7.00   sec   138 MBytes  1.15 Gbits/sec    0    743 KBytes
  [  5]   7.00-8.00   sec   131 MBytes  1.10 Gbits/sec    0    755 KBytes
  [  5]   8.00-9.00   sec   138 MBytes  1.15 Gbits/sec    0    760 KBytes
  [  5]   9.00-10.00  sec   139 MBytes  1.16 Gbits/sec    0    763 KBytes
  - - - - - - - - - - - - - - - - - - - - - - - - -
  [ ID] Interval           Transfer     Bitrate         Retr
  [  5]   0.00-10.00  sec  1.31 GBytes  1.13 Gbits/sec    2             sender
  [  5]   0.00-10.04  sec  1.31 GBytes  1.12 Gbits/sec                  receiver

  iperf Done.
