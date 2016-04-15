Routed, virtual network interfaces for guest VMs on controllers
===============================================================

This describes how to setup a routed network interface for a guest VM running
on a controller host. This is an adaptation of the general calico way of
setting up networks from neutron data and some information from 
https://jamielinux.com/docs/libvirt-networking-handbook/custom-routed-network.html

Requirements
------------

- BIRD running on the controller host pointed at one or more route reflector
  instances and a bird.conf similar to the one on the compute nodes
- A VM running in libvirt on the controller host with eth0 connected to the br0
  host bridge (mgmt network).

Prepare the outgoing default gateway interface
----------------------------------------------

Traffic originating from inside the guest need to have a gateway to send
packets to. This will be a dummy interface with the same IP on each of the
controller hosts. In this example we'll generate a random MAC address in the
format libvirt expects and use that to create a dummy dev01 service network IP
interface om the host that we will later route to from within the guest.

.. code:: bash

   modprobe dummy
   mac=$(hexdump -vn3 -e '/3 "52:54:00"' -e '/1 ":%02x"' -e '"\n"' /dev/urandom)
   ip link add virgw-service address $mac type dummy
   ip addr add 172.31.16.1/24 dev virgw-service
   ip link set dev virgw-service up

This will bring up a virtual gateway interface that will be able to receive
traffic from inside the guest instances on this controller host and deliver it to
the kernel to be routed. However, we only want this interface to be used for
outgoing traffic FROM the guests. But there is a problem - when we "up" the
interface in the last step above an entry for the 172.31.16.0/24 network will
be made in the kernel routing table:

.. code:: bash

   [root@dev01-controller-03 ~]# ip route | grep virgw-service
   172.31.16.0/24 dev virgw-service  proto kernel  scope link  src 172.31.16.1

This leads to all and any traffic to that network being routed back over the
virgw-service interface, we don't want that. To fix this (and this is what
Calico does, too) we remove the route that was created

.. code:: bash

   ip route del 172.31.16.0/24

We've now prepared the virgw-service interface on the controller host to act as
a dummy gateway for the service network on guest instances.

Add a tunnel interface connecting the host with a guest VM
----------------------------------------------------------

First we make a tap interface on the controller host and give it a recognizable
name - it seems like only a single dash is allowed in the name? The settings
for the device are derived from what calico does on the compute nodes:

.. code:: bash

   ip tuntap add dev tap-dev01db02 mode tap one_queue vnet_hdr
   ip tuntap
   ip tuntap help

Next, we need to define this tap device in the libvirt domain config for the
guest VM. Make sure the domain is not running first.

.. code:: bash

   virsh shutdown dev01-db-02

Generate an xml block describing the new guest network interface with a new
random mac address - target device should be the tap device we just created on
the host

.. code:: xml

   <interface type='ethernet'>
     <mac address='52:54:00:xx:xx:xx'/>
     <script path='/bin/true'/>
     <target dev='tap-dev01db02'/>
     <model type='virtio'/>
     <address type='pci' domain='0x0000' bus='0x00' slot='0x06' function='0x0'/>
   </interface>

Copy and paste this xml block below the current interface definition in the
domain xml:

.. code:: bash

   virsh edit dev01-db-01


Make configuration changes to libvirt to allow this interface type
------------------------------------------------------------------

This is already documented in step 1) of the Calico compute node documentation
at http://docs.projectcalico.org/en/stable/redhat-opens-install.html?highlight=cgroup_device_acl#compute-node-install

Boot the guest and set up the interface
---------------------------------------

On the controller host you should now be able to boot the guest with the new
interface added. We also need to create the host route to the new service IP
that now will be available and bring up the tap device.

.. code:: bash

   virsh start dev01-db-02
   ip link set dev tap-dev01db02 up
   ip route add 172.31.16.18/32 dev tap-dev01db02

Log in to the VM from the mgmt network and set up the new interface manually,
then verify that it works:

.. code:: bash

   sudo ssh iaas@dev01-db-02
   sudo -i
   ip addr
   ip addr add 172.31.16.18/24 dev eth1
   ip link
   ip link set dev eth1 up
   # switch default gw
   ip route del default
   ip route add default via 172.31.16.1

To make configuring services that use the new interface easier - use the new
service IP interface as the default gw for the guest.

You should now be able to ping the outside dummy gateway using the new interface

.. code:: bash

   ping -I eth1 172.31.16.1

On the controller host, verify that bird knows about the host route, e.g

.. code:: bash

   [root@dev01-controller-03 ~]# birdcl show route
   BIRD 1.4.5 ready.
   0.0.0.0/0          via 172.31.1.1 on br0 [kernel1 21:38:10] * (10)
   172.31.16.18/32    dev tap-dev01db02 [kernel1 21:41:33] * (10)
   172.31.34.0/24     dev eth1.912 [direct1 21:38:10] * (240)
   172.31.35.0/24     dev eth1.913 [direct1 21:38:10] * (240)

In order for a VM to reach an address on it's same subnet, proxy-arp has to be
enabled on the tap interface. Then the host computer with the router will offer it's
own mac address from the tap interface and then route the traffic.

   [root@dev01-controller-03 ~]# echo 1 > /proc/sys/net/ipv4/conf/tap-dev01db02/proxy_arp

