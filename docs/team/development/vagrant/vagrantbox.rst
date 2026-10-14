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

We host the boxes at https://download.iaas.uio.no/nrec/vagrant/

There is a folder with a metadata in json format for each vagrant box we host.
To add a new version of a box edit the file and add a new version with path
to the box file and SHA256 checksum. The boxes are hosted in on a seperat folder for each box.

We do not need to keep more that a few (2-3) version in the metadata file or on disk,
so remove old ones when you add a new, but never delete all the old ones just in case
the new one do not work!

Upgrade box
-----------

After the new box is uploaded you will need to update the box in your local
vagrant environment with::

  vagrant box update
