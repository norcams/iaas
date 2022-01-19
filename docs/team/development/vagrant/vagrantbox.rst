====================
Build new vagrantbox
====================

Last changed: 2022-01-19

We use bento to build our own vagrantboxes. The norcams templates can be found
in our fork of bento: https://github.com/norcams/bento


Build new box
=============

Make sure you have packer installed and in :file:`$PATH`
Edit the template if needed or there are a new OS version

Provider will be :file:`virtualbox-iso` or :file:`qemu` for libvirt

el7::

  cd packer_templates/centos
  packer build -only=<provider> centos-norcams-<version>-x86_64.json

This will create a new box for :file:`norcams/base`

el8::

  cd packer_templates/almalinux
  packer build -only=<provider> almalinux-norcams-<version>-x86_64.json

This will create a new box for :file:`norcams/el8`

Upload new box
--------------

We host the boxes at https://app.vagrantup.com/norcams/
If you do not have access ask Raymond

* Create a new version  x.y.z, x.y is upstream version and z is our box iteration.
* Create a new provider, virutalbox or libvirt and upload the box


Upgrade box
-----------

After the new box is uploaded you will need to update the box in your local
vagrant environment with::

  vagrant box update
