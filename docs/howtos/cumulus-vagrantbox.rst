Create Cumulus VX vagrant boxes for himlar dev
==============================================

This describes how to create (or update) the norcams/net vagrant box which is
based on the Cumulus VX test appliance.

Requirements
------------

- An account with access to the norcams organisation on Hashicorp Atlas system
  at https://atlas.hashicorp.com/norcams
- An account on cumulusnetworks.com to download the vagrant appliance from
  https://cumulusnetworks.com/cumulus-vx/download/
- A current vagrant installation with virtualbox and libvirt providers working

Prepare virtualbox and libvirt box files
----------------------------------------

Install the vagrant-mutate plugin:

.. code:: bash

   vagrant plugin install vagrant-mutate

Download and rename the cumulus vagrant box, then add and convert it:

.. code:: bash

   mv Downloads/CumulusVX*virtualbox.box /path/to/norcams-net-2.5.6-virtualbox.box
   vagrant box add norcams/net /path/to/norcams-net-2.5.6-virtualbox.box
   vagrant mutate norcams/net libvirt

Verify that the box is available for both providers:

.. code:: bash

   vagrant box list

Repackage the libvirt box (this command takes a while to complete ...):

.. code:: bash

   vagrant box repackage norcams/net libvirt 0
   mv package.box norcams-net-2.5.6-libvirt.box

You should now have two box files, one for libvirt and one for virtualbox.

.. code:: bash

   ls *.box
   norcams-net-2.5.6-libvirt.box
   norcams-net-2.5.6-virtualbox.box

Publish to Atlas
----------------

In order for vagrant autoupdate to work we need to publish both these files
on a webserver somewhere and point to their locations from a provider and
version configuration on Atlas.

- Publish both box files somewhere where they can be downloaded from a public
  URL.
- Log in at https://atlas.hashicorp.com/norcams
- Find the norcams/net box at https://atlas.hashicorp.com/norcams/boxes/net
- Add a new version, if needed
- Create providers for "virtualbox" and "libvirt". The URL should point at the
  location of the respective box file, e.g http://somewhere/files/norcams-net-2.5.6-virtualbox.box

