.. |date| date::

======================
Development in Vagrant
======================

.. contents::
.. section-numbering::

*Last changed: |date|

Requirements
============

In order to deploy the virtual machines in Vagrant, the host running
the VMs must med the following requirements:

====================  =======================================
**Operating system**  libvirt capable (only tested Fedora 23)
**Memory**            FIXME. (8GB recommended)
**Disk**              FIXME.
====================  =======================================


Setting up the Vagrant environment
==================================

.. _RPMFusion: http://rpmfusion.org/
.. _norcams/himlar: https://github.com/norcams/himlar

In order to deploy the Vagrant environment, follow this guide.

#. Make sure that the requirements_ are met

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

     # dnf -y install vagrant vagrant-libvirt libvirt-daemon-kvm

#. Start the libvirtd service, and make sure that it is started at
   boot::

     # systemctl start libvirtd.service
     # systemctl enable libvirtd.service

#. Clone the latest version of the `norcams/himlar`_ git repository
   from Github::

     $ git clone git@github.com:norcams/himlar.git

#. Bring the vagrant hosts up::

     $ cd himlar
     $ vagrant up

