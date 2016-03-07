.. |date| date::

======================
Development in Vagrant
======================

Last changed: |date|

.. contents::
.. section-numbering::


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

Note that authentication through Feide Connect (aka "Dataporten") uses
redirection and is not possible when connecting through an SSH tunnel.


Setting up local user and tenant
================================

Logging into the VMs is fairly simple. In order to set up a demo user
and tenant, log into the master VM::

  vagrant ssh master

Become root::

  sudo -i


API authentication configuration
--------------------------------

The `norcams/himlar`_ repo is available from within the vagrant VM as
``/opt/himlar``. Run the **00-credentials_setup.sh** script::

  /opt/himlar/tests/00-credentials_setup.sh

This will create 3 files in your home directory:

====================  ==================================================
**openstack.config**  Defines the demo username etc. Used by other tests
**keystonerc_admin**  Sets environment variables for administrator
**keystonerc_demo**   Sets environment variables for demo user
====================  ==================================================

In order to "become" the OpenStack administrator, you then only need
to source the **~/keystonerc_admin** file::

  . ~/keystonerc_admin

To switch to the demo user, source the **~/keystonerc_demo** file::

  . ~/keystonerc_demo


Create demo user and project (tenant)
-------------------------------------

This can be accomplished simply by running::

  /opt/himlar/tests/01-keystone-create_demo_user.sh

But for the sake of learning, you may want to to this manually as
shown below:

#. Source the file that defines the administrator environment::

     source ~/keystonerc_admin

#. Create a demo tenant (project)::

     openstack project create --or-show demoproject

#. Create a demo user and set the password::

     openstack user create --or-show --password himlar0pen demo

#. Associate the demo user with the demo tenant::

     openstack user set --project demoproject demo

#. Show the demo user::

     openstack user show demo


Upload an image to Glance
-------------------------

This can be accomplished simply by running::

  /opt/himlar/tests/02-glance-import_cirros_image.sh

But for the sake of learning, you may want to to this manually as
shown below:

#. Source the file that defines the administrator environment::

     source ~/keystonerc_admin

#. Download CirrOS image::

     curl -o /tmp/cirros.img http://download.cirros-cloud.net/0.3.4/cirros-0.3.4-x86_64-disk.img

#. Upload and create the image in Glance::

     openstack image create "CirrOS test image" --disk-format qcow2 --public --file /tmp/cirros.img

   This can also be accomplished by using Glance directly::

     glance image-create --name "CirrOS test image" --disk-format qcow2 --container-format bare --visibility public --file /tmp/cirros.img

#. List images::

     openstack image list

   Optionally, list images Nova API::

     nova image-list
