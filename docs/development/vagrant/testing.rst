.. |date| date::

==================
Testing in Vagrant
==================

Last changed: |date|


Connecting to Horizon
=====================

.. _Setting up the Vagrant environment: http://iaas.readthedocs.org/en/latest/development/vagrant/libvirt.html#setting-up-the-vagrant-environment

Horizon is the web GUI component in OpenStack. If you've followed the
`Setting up the Vagrant environment`_ guide earlier, you should now be
able to connect a browser to the Horizon GUI::

  https://172.31.24.22/

If the VMs are running on a remote host, the best approach will be to
use an SSH tunnel. Create an SSH tunnel with::

  ssh -L 8443:172.31.24.22:443 <username>@<hostname>

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

.. _norcams/himlar: https://github.com/norcams/himlar

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

   .. NOTE::
      This can also be accomplished by using Glance directly::

        glance image-create --name "CirrOS test image" \
            --disk-format qcow2 --container-format bare \
            --visibility public --file /tmp/cirros.img

#. List images::

     openstack image list

   Optionally, list images using the Nova API::

     nova image-list


Create a network security group
-------------------------------

This can be accomplished simply by running::

  /opt/himlar/tests/03-neutron-create_security_group_and_rules.sh

But for the sake of learning, you may want to to this manually as
shown below:

#. Source the file that defines the administrator environment::

     source ~/keystonerc_admin

#. Create a network security group called "test_sec_group"::

     openstack security group create test_sec_group

#. Add a rule which allows incoming SSH::

     openstack security group rule create --proto tcp --dst-port 22 test_sec_group

#. Add a rule which allows incoming ICMP::

     openstack security group rule create --proto icmp test_sec_group

#. Show the newly created security group::

     openstack security group show test_sec_group --max-width 70

.. NOTE::
   This could have been done using the Neutron API instead of the
   generic openstack command::

     neutron security-group-create test_sec_group
     neutron security-group-rule-create --direction ingress --protocol tcp \
         --port_range_min 22 --port_range_max 22 test_sec_group
     neutron security-group-rule-create --protocol icmp --direction ingress test_sec_group
     neutron security-group-show test_sec_group
