====================
Build new vagrantbox
====================

Last changed: 2023-10-05

We use bento to build our own vagrantboxes. The norcams templates can be found
in our fork of bento: https://github.com/norcams/bento


Build new box
=============

See `this page <https://github.com/norcams/bento/blob/main/NORCAMS.md>`_ for details on how to build new boxes.

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
