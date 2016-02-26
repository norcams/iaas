Routed, virtual network interfaces for VMs on controllers
=========================================================

This describes how to setup a routed network interface for a VM running on a
controller host. This is an adaptation of the general calico way of setting up
networks from neutron data and some information from 
https://jamielinux.com/docs/libvirt-networking-handbook/custom-routed-network.html

Requirements
------------

- BIRD running on the controller host pointed at a route reflector instance
- A VM running in libvirt on the controller host with eth0 connected to the br0
  host bridge (mgmt network).

Prepare the outgoing default gateway interface
----------------------------------------------

Traffic originating from the VM need to have a gateway to send traffic to. This
will be a dummy interface with the same IP on each of the controller hosts. In
this example we'll generate a random MAC address in the format libvirt expects
and use that to create a dummy dev01 service network IP interface

.. code:: bash

   modprobe dummy
   mac=$(hexdump -vn3 -e '/3 "52:54:00"' -e '/1 ":%02x"' -e '"\n"' /dev/urandom)
   ip link add virgw-service address $mac type dummy
   ip addr add 172.31.16.1/24 dev virgw-service
   ip link set dev virgw-service up

This will bring up a virtual gateway interface that will be able to receive
traffic from inside the VM instances on this controller host and deliver it to
the kernel to be routed. However, we only want this interface to be used for
outgoing traffic. But when we "up" the interface in the last step above an
entry for the 172.31.16.0/24 network will be made in the kernel routing table:

.. code:: bash

   [root@dev01-controller-03 ~]# ip route | grep virgw-service
   172.31.16.0/24 dev virgw-service  proto kernel  scope link  src 172.31.16.1

Because we don't want any non-instance traffic to be routed to this interface
we remove that route

.. code:: bash

   ip route del 172.31.16.0/24

We've now prepared the controller host to act as a dummy gateway for the VM
instances.

Add a tunnel interface connecting the controller with the VM
------------------------------------------------------------

First we make a tap interface on the controller host and give it a recognizable
name. The settings for the device are derived from what calico does on the
compute nodes:

.. code:: bash

   ip tuntap add dev tap-service1 mode tap one_queue vnet_hdr
   ip tuntap
   ip tuntap help

Next, we need to define this tap device as part of the libvirt domain config
for the VM we want to add a service interface to. Make sure the domain is not
running first.

.. code:: bash

   virsh shutdown <vm_instance_name>
   virsh edit <vm_instance_name>

Insert an xml block describing the new network interface with a new random mac
address (replace the xx:xx:xx or use the hexdump generator again)

.. code:: xml

   <interface type='ethernet'>
     <mac address='52:54:00:xx:xx:xx'/>
     <script path=''/>
     <target dev='tap-dev02db01'/>
     <model type='virtio'/>
     <address type='pci' domain='0x0000' bus='0x00' slot='0x06' function='0x0'/>
   </interface>





Make configuration changes to libvirt to allow this interface type
------------------------------------------------------------------

This is already documented in step 1) of the Calico compute node documentation
at http://docs.projectcalico.org/en/stable/redhat-opens-install.html?highlight=cgroup_device_acl#compute-node-install


