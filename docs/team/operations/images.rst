==============================
Images lifecycle documentation
==============================

This section is an attempt to document various lifecycle issues regarding
images, from builds to retirement procedures.


Imagebuilder (How a NREC endorsed (GOLD) image is built
=======================================================

To facilitate our GOLD images offering, we are using a homegrown system
called **imagebuilder** based on *packer* (https://www.packer.io/). This package
contains a set of `python`-scripts which may be used to pull down upstream cloud
images, start an instance from this and adapt that instance using custom scripts
and finally create an image which is the base for the GOLD images offered to end
users.

Home page (Github page) : https://github.com/norcams/imagebuilder


Build routine
-------------

Through the profile class *application/builder* Puppet creates cron
specifications and build scripts. The cron entries is set up to run once a week
(once per distribtion offered) on the `builder` nodes. The end result (NREC
adapted images) are found on the nodes ready to download if required. On the
`proxy` nodes there should be a monthly cron job uploading the latest images
using *himlarcli*.

The procedure goes like this:

1. Puppet creates cron jobs and scripts from the hash
   **profile::application::builder::images** on `builder` nodes
#. The jobs are set up to run every wednesday at different times
#. Each distribution maintained have its own build script located here:

   /home/imagebuilder/build_scripts

#. The script basically perform these steps:

     I. set up the environment
     #. download an upstream cloud image
     #. upload image to *Glance*
     #. start an instance based on this image (`packer`)
     #. run all custom scripts listed in the template (`packer`)
     #. use the final instance state to create a new image (`packer`)
     #. remove all temporary security rules, instances and images (`packer`)
     #. convert to *qcow2*, store into local image storage and purge all but the
        latest two images built

5. On the `proxy` nodes there is a cron job running once a month:

     I. ``/opt/himlarcli/bin/image_update.sh``
     #. this script use the himlarcli command `image.py` to upload ("update")
        images defined in the specified image configuration set

        *default.yaml* contains all standard images offered. Other sets may also
        be added

     #. the new images get the prefix **GOLD** added
     #. the previous GOLD version gets its prefix swapped to **Outdated**


Templates
"""""""""

`Packer` require a "template" which describe what should be performed on the
instance when creating the new images. It list all custom scripts and other
commands to execute. This Packer template is created by Puppet using its own
Puppet template (HIMLAR: ``profile/templates/application/builder/template.rb``).
The templates used is selected based on environment variables, and are located
on the builder nodes here::

  /etc/imagebuilder

The templates are created (by the *application/builder/template* class) based
on the **profile::application::builder::templates** hash. The `default` template
contains a standard set of scripts run on all builds, and then optional
additional templates may be defined, with a set of extra custom scripts run just
for builds utilizing this template.

The template to use is defined by the `IB_TEMPLATE_DIR` environment variable.


New template variants
`````````````````````

For new build types, which require their own, specialized, adaptions (like their
own script) it is an option to create a new template:

  - if required: add new custom scripti(s) to **imagebuilder** (build a new RPM package, see
    below)
  - define a new entry in the template hash (**profile::application::builder::templates**)
  - enter the script(s) to run in the *custom_scripts* entry
  - set the *IB_TEMPLATE_DIR* environment variable in the image
    specification hash (**profile::application::builder::images**)


Environment variables
"""""""""""""""""""""

IMAGEBUILDER_REPORT (default: `True`)::

  Write a report of the build (in addition to the standard Packer log file)
  This report is the base for sensu monitoring, and should usually be set

IB_TEMPLATE_DIR (default: `default`)::

  Which template to use for Packer. This template defines scripts and other
  routines to use for preparing the GOLD image


Building imagebuilder
---------------------

IMAGEBUILDER: an RPM based application which handles everything required to
build a customized image. It downloads an upstream image, set up an instance
based on this image and executes one or more procedures before creating a new,
customized image.

The package conatins a set of scripts which is used to adapt the different
distributions to NREC. Which of these scripts is to be executed is defined
inside templates. The templates are all created using *puppet* on the `builder`
nodes, but the scripts themselves are packaged together with the builder code
inside the RPM.

This section describes how to update, alter and/or add code or scripts to the
package.


Update code (base python code or provisioning scripts)
""""""""""""""""""""""""""""""""""""""""""""""""""""""

Github: https://github.com/norcams/imagebuilder

The most common task is to update or add a customization script. These are
located in the **scripts** directory. Just change, add or remove as needed, and
then push upstream. A push will never initiate a new RPM, so there is little
danger doing this.

.. Note::
   A new script in the scripts directory alone will not be enough to get it
   activated on new builds! The script must also be entered into the template as
   described above!

.. Note::
   To test a fix to one of the scripts just change it directly on one of the
   builder nodes (preferably in one of the test environments) and manually initiate
   one of the cron jobs as user imagebuilder. Puppet runs will never revert
   code.
   To revert just run "yum reinstall imagebuilder".

.. Important::
   Remember the scripts are not run as the root user under Packer! Even if it
   works as expected during manual tests, this might not be the case when building
   properly. Also consider that the build process is using a new installation where
   not everything might be set up yet.

To fix or change the builder code itself, it's mostly the `Python` code in the
**image_builder** directory which should be altered.


Build RPM package
"""""""""""""""""

We use *fpm* (https://fpm.readthedocs.io/en/latest/) as the tool for creating
RPM packages of *imagebuilder*. To make it easy to use this tool, the
**package-imagebuilder** project is created. What this provides is mainly a
`Makefile` and the facility to create an RPM out of *imagebuilder* by just
providing a simple ``Make`` command.

1. ``git pull https://github.com/norcams/package-imagebuilder.git``
#. ``cd package-imagebuilder``
#. (optional) ``make clean``  <-- use if this is not the first attempt
#. (conditional) ``vi Makefile`` <-- only once for each package released

   a. change *VERSION* and *PACKAGE_VERSION* as apropriate

      This will become the version of the RPM package and must be higher than the
      current released version og imagebuilder.

   #. ``git commit -am "Bumped package version"``
   #. ``git push``
#. ``make``

There should now be an RPM package in the current directory, named
**imagebuilder-X-Y.el7.x86_64.rpm**, where `X=VERSION` and `Y=PACKAGE_VERSION`.

.. Important::
   This build/Make system is updated and currently adapted to ``Centos/RHEL 7``.
   It will probably fail and must be adjusted if used on other
   distributions/versions!


**Testing RPM package**

The package may be uploaded to a web server and installed from there using `yum`
and a remote URL, or the packaged transfered to one of the build nodes and
installed with `yum` on the local file. Check scripts or codes to make sure
latest changes are in place, and then manually initiate a build to confirm
nothing brake and the changes have the desired effect.

When finished testing revert the package to the previous installed one::

  yum reinstall imagebuilder


Add to repository
"""""""""""""""""

.. Note::
   Before releasing this new version make sure it is tested and that the version is
   higher than the current version in the repository!

The *imagebuilder* RPM package just built should be released through the
``yumrepo`` repository (which is mirrored and snapshot through the **uh-iaas**
name). Read the  `Repository server < `here <https://report.nrec.no/api/ui/>`_
documentation for details.

.. Important::
   Remember to run ``createrepo`` as described!

The package is then available instantly as
https://iaas-repo.uio.no/uh-iaas/yumrepo/<packagename> and next day through the
normal snapshot interface (i.e. using *test* and *prod* URLs when `repo-admin`
configuration has been updated. Consult the unreadable and terrible repository
documentation listed above.


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


