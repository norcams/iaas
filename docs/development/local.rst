.. |date| date::

======================
Development in Vagrant
======================

.. contents::
.. section-numbering::

*Last changed: |date| *

Requirements
============

In order to deploy the virtual machines in Vagrant, the host running
the VMs must med the following requirements:

====================  =======================================
**Operating system**  libvirt capable (only tested Fedora 23)
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

#. Start the libvirtd service, and make sure that it is started at
   boot::

     systemctl start libvirtd.service
     systemctl enable libvirtd.service

#. Add the user that will be running Vagrant to the **wheel** group::

     usermod -G wheel -a <username>

#. Clone the latest version of the `norcams/himlar`_ git repository
   from Github::

     git clone git@github.com:norcams/himlar.git

   or with https::

     git clone https://github.com/norcams/himlar.git

#. Bring the vagrant hosts up::

     cd himlar
     vagrant up


Connecting to Horizon
=====================

Horizon is the web GUI component in OpenStack. If you've followed the
`Setting up the Vagrant environment`_ guide above, you should now be
able to connect a browser to the Horizon GUI::

  https://172.31.24.20/

If the VMs are running on a remote host, the best approach will be to
use an SSH tunnel. Create an SSH tunnel with::

  ssh -L 8443:172.31.24.20:443 <username>@<hostname>

After creating the SSH tunnel, point your browser to::

  https://localhost:8443/


