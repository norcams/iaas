.. |date| date::

====================
Vagrant with libvirt
====================

Last changed: |date|

.. contents::

Requirements
============

In order to deploy the virtual machines in Vagrant, the host running
the VMs must med the following requirements:

====================  =======================================
**Operating system**  libvirt capable (tested on RHEL/Fedora)
**Memory**            16 GB minimum, 32 GB recommended
**Disk space**        8 GB minimum on ``/var/lib/libvirt``
====================  =======================================


Setting up the Vagrant environment
==================================

.. _RPMFusion: http://rpmfusion.org/
.. _norcams/himlar: https://github.com/norcams/himlar

In order to deploy the Vagrant environment, follow this guide.

#. Make sure that the requirements_ are met

#. Ensure that CPU virtualization extensions are enabled on the
   host. You'll probably need to enter BIOS setup for this.

#. Create a file **/etc/polkit-1/rules.d/10-libvirt.rules** with the
   following contents::

     polkit.addRule(function(action, subject) {
       if ((action.id == "org.libvirt.unix.manage"
         || action.id == "org.libvirt.unix.monitor")
         && subject.isInGroup("wheel")) {
         return polkit.Result.YES;
       }
     });

#. Install Vagrant and libvirt. In this case, it is assumed that
   you're running Fedora and have the RPMFusion_ repositories
   available::

     dnf -y install vagrant vagrant-libvirt libvirt-daemon-kvm
     
   If you are running RedHat, you may also need to install::

     yum install libvirt-devel
     
#. Install Vagrant plugins for libvirt::

     vagrant plugin install vagrant-libvirt

#. Start the libvirtd service, and make sure that it is started at
   boot::

     systemctl start libvirtd.service
     systemctl enable libvirtd.service

#. Add the user that will be running Vagrant to the **wheel** group::

     usermod -G wheel -a <username>

Tips and tricks
===============

Add the following in your **~/.bashrc** or similar to always use the
same nodeset (example for nodeset "dns")::

  # Himlar
  export HIMLAR_NODESET=dns

Script to provision a node, and keep the output::

  #!/bin/bash
  
  host=$1
  
  [ -d /tmp/himlar ] || mkdir /tmp/himlar
  
  vagrant rsync $host | tee /tmp/himlar/$host
  vagrant provision $host | tee -a /tmp/himlar/$host

Script to take all nodes up, in the correct order (uses the
script **provision.sh** above)::

  #!/bin/bash
  
  declare -a nodes=( 'db'
                     'api'
                     'identity'
                     'mq'
                     'dashboard'
                     'ns'
                     'resolver-01'
                     'resolver-02'
                     'admin'
                     'image'
                     'network'
                     'compute'
                     'novactrl'
                     'volume'
                     'dns' )
  
  for node in "${nodes[@]}"; do
      vagrant up $node
      provision.sh $node
      provision.sh $node
  done
  
  for node in "${nodes[@]}"; do
      provision.sh $node
  done

