==============================
Images lifecycle documentation
==============================

This section is an attempt to document various lifecycle issues regarding
images, from builds to retirement procedures.


Imagebuilder (How a NREC endorsed (GOLD) image is built
=======================================================


Retirement/Deprecation
======================

New builds are uploaded and activated with a name prefix of `GOLD`, at the same
time the previous GOLD version is deprecated, getting a prefix of `Outdated`.
This is done automatically for all current distributions that we support. When a
version/distribution is retired (that is: no longer supported or offered by
NREC), some steps must (for now) be manually followed to fully remove the image and
all accompanying traces.

Steps to fully remove a retired image
-------------------------------------

1. Deprecate image in `Himlarcli` (All files relative to *himlarcli* repository):

  a. Remove entry from the image definition file:

     Usually by editing the file **config/images/default.yaml**
  #. Enter the image into the retired list:

     Edit the file **config/images/retired.yaml**
  #. Push changes:

     ``git push``
  #. On all *proxy* nodes:

     - ``cd /opt/himlarcli``
     - ``git pull``
     - ``. bin/activate``
     - ``./image.py retire -i retired.yaml``

2. Remove build entries:

  a. Edit *hieradata/common/roles/builder.yaml*:

    I. Remove build defintion entry from **profile::application::builder::images**
    #. Remove monitoring entry from **profile::monitoring::sensu::agent::expanded_checks**

  b. Push changes:

     ``git push`` (adapt to your environment!)
  #. Deploy (preferably by means of the Ansible jobb ``bin/deploy.sh``)

     Remember all environments!

3. Purge old data from builder nodes. On all:

  a. Delete all versions of image (incl. *latest*) from
     **/opt/images/public_builds**
  #. Purge all logs and reports from **/var/log/imagebuilder**


