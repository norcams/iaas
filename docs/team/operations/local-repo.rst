=================
Repository server
=================


Introduction
============


For local caching of external repositories and to facilitate a repository of
packages created by the UH-IaaS team etc, a server system is installed.
Because the production environment has to be carefully managed, some issues are
raised which is attempted resolved by this setup:

* Production servers must only run well known versions and combinations of
  software (which is supposed to be tested and approved before deployment)
* Possible to check state of code at any date in the past for debugging
* Possible to test new code without disturbing production environment
* Ability to maintain our own software in the same manner as any external
  RPM repository
* Means to distribute all kind of data files without versioning


To acomplish all of this wehave implemented both a system for versioned/snapshoted
mirrors of any 'external' repo (whatever the location), a local ordinary RPM
repository and a generic distribution point.

* **Hostname**: ``iaas-repo.uio.no``
* **Alias** (used in code): ``download.iaas.uio.no``
* **Access**: as for normal infrastructure nodes (*iaas*-user from one of the
  login nodes)
* **Repo root directory**: ``/var/www/html/uh-iaas``
* **Available protocols**: ``https``


.. Note::
   The implementor accepts the fact that the naming scheme
   for these directories are misleading! Please read the description
   before assuming anything related to the role of the directory!


Diagram of setup
----------------


.. image:: images/repo.png


Directory description
---------------------

* **repo**: Mirror hiearchy. This is where all defined repositories are mirrored
  to. Content are normally mirrored nightly.
* **snapshots**: Nightly snapshot of all mirrors under ``repo``. Each snapshot is
  named by the date and time of creation.
* **prod**: For each repository a pointer (symbolic link) to a snapshot of the
  same.
* **test**: As for ``prod``, but separate link.
* **yumrepo**: Locally maintained RPM repository. Mirrored under ``repo`` as any
  external repository is.
* **rpm**: Generic file distribution. No metadata, versioning, mirroring or
  snapshoting.



Common attributes and requirements
==================================

Packages built locally by the project are made available for use (default for the world!)
by storing it in one of the prepared directories depending on whether the package is to
be part of a yum repository or as a stand-alone package or file.

The *iaas* group owns all files and directories under the repository root
directory, the hierarchy is configured with the `set group ID` bit. Accordingly
all relevant repo operations can (and should) be done as the *iaas* user.

**NOTE**

Make sure new packages and files have the correct SELinux label::

  sudo restorecon <file>

or::

  sudo restorecon -R <directory>



Detailed descriptions
=====================


YUM repository
--------------

**Directory name**: ``yumrepo``

Packages which should be maintained by ordinary package maintainment procedures,
are located in the YUM repository located in ``yumrepo``. These files/packages
are then considered and consumed exactly as any other, external, repository used by the
project/code.


**IMPORTANT**

After all file operations update the repository meta data::

  /usr/bin/createrepo <repo root directory>/yumrepo


**URL**: `<https://download.iaas.uio.no/uh-iaas/yumrepo>`_



Standalone file archive
-----------------------

**Directory name**: ``rpm``

Files (RPM packages or other types) which are needed by the project but which should or cannot
use the local YUM repository, can be distributed from the generic archive
located under the ``rpm`` subdirectory. No additional operations required, other
than the ensuring correct SELinux label as described above.

**URL**: `<https://download.iaas.uio.no/uh-iaas/rpm>`_



Local mirror and snapshot service
=================================


To facility tight control of the code and files used in our environment, and to
ensure the availability in case of network or external system outages etc, a
local mirror and snapshot service is implemented.

Content and description of included subdirectories:

========== =============== ============================================================================================== ===============================================
Short name Long name        Description                                                                                    URL
=========  =============== ============================================================================================== ===============================================
repo       Repository      Latest sync from external sources                                                              https://download.iaas.uio.no/uh-iaas/repo
snapshots  Snapshots       Regular (usually daily) snapshots of data in repo                                              https://download.iaas.uio.no/uh-iaas/snapshots
test       Test repo       Pointer to a specific snapshot in time, usually newer than `prod`                              https://download.iaas.uio.no/uh-iaas/test 
prod       Production repo Pointer to a specific snapshot in time with well-tested data, used in production environments  https://download.iaas.uio.no/uh-iaas/prod
========== =============== ============================================================================================== ===============================================

Usage is normally as follows:

:repo: for development or other use of most up-to-date code
:test: test code which is aimed for next production release
:prod: production code
:snapshots: can be used to test against code from any specific date in the past



Mirror
------ 

**Directory**: ``repo``

Each mirrored repository is located directly beneath the `repo` folder. Which
"external" (which might actually be located locally) repository is to be
mirrored, is defined by data in the internal **repo-admin** git repo (see below
for access details). All repositories listed in the file *repo.config* is
attempted accessed and sync'ed. The type of repository - as defined in the
configuration file for the apropriate listing - determines what actions are
taken on the data. As this is mainly YUM repositories, the appropriate metadata
commands are executed to create a proper local repository. Any YUM repo defined
in the configuration must have a corresponding repo-definition in a suitable
file in the ``yum.repos.d`` subdirectory (in the git repo!).

The mirroring is done once every night by a root cron job.

To access the most current data in the mirror, us this URL::

    https://download.iaas.uio.no/uh-iaas/repo/


Snapshots
---------

**Directory**: ``snapshots``

Every night a cron job runs to create snapshots of all mirrored repositories (of
all kinds). A snapshot subdirectory is created named by the current date and time.
Under this all repos can be accessed. This way any data can be retrieved from
any data in the past on which a snapshot has been taken.

*current*: In the ``snapshots`` directory there is always a special "snapshot*
named ``current``. This entry is at any time linked to the most current
snapshot.

To access the snapshot library::

    https://download.iaas.uio.no/uh-iaas/prod/


.. Note::
   The snapshot data are created using a system of hardlinks. This way unaltered
   data is not duplicated, which conserves space considerably.


Test and prod
-------------

**Directories**: ``test``, ``prod``


All mirrored repos used by UH IaaS can be accessed through a static and well
known historic version using the *test* and *prod* interfaces. By configuring
the apropriate files in the internal **repo-admin** git repo, each repo might
have a ``test`` and ``prod`` pointer linking to a specific snapshot of this
repository. NB: each and every mirrored repo can be set up to link to separate
snapshots!

.. Important::
   This is the access point to use in the production and test environments!



Configuration
-------------

Configuration for the repositories is stored in the internal git repo::

    git@git.iaas.uio.no:repo-admin

The `iaas` user has *READ* permissions and should be used to pull the
configuration to the repository server.


Files
`````

:config:      Generic configuartion (for now the location of the repo root only)
:repo.config: Definition of the external repositories to mirror
:test.config: Which snapshots and local repositories to point to in `test`
:prod.config: Which snapshots and local repositories to point to in `prod`


Considerations
``````````````

- ``test`` should never point to a snapshot older than what the corresponding 
  ``prod`` are linkng to
- Pointers in ``prod`` **must also** exist in ``test``, the rationale
  being that this somewhat ensures that `prod` has already been tested.
  Links in the `prod` configuration which does not also exist in the `test`
  configuration will *not* be activated (removed if the exists)!
- If there are more than one link listed to the same repo the most current
  is always the one activated.
- Existing links not listed in the current configuration will be removed!


Update procedure
````````````````

1. Clone or pull the git repo locally
#. Edit files
#. Commit and push to central git repo
#. Log on to *osl-login-01*
#. Run the ansible job ``update_repo.yaml``::

     sudo ansible-playbook -e "hosts=download" lib/update_repo.yaml

   This action pull the latest config and update the pointers in `test` and
   `prod`.


Publicizing procedure
---------------------

Normal (automatic)
``````````````````

**rpm**:
  Files placed inside this location is instantly accessible, provided correct
  SELinux labeling. No snapshoting provided!


**yumrepo**:
  Files placed inside this location is instantly accessible, provided correct
  SELinux labeling. No snapshoting provided through this interface! For this use
  the REPO interface instead.


**repo**:
  Any repositories which are mirrored (including YUMREPO) have new files
  accessible here after the mirror job is run during night time. The version
  available is always the most recent!


**snapshots**:
  Every night after mirror job completion a snapshot of the current mirrors are
  taken. Any of these snapshots are available through this interface below a
  directory named by the timestamp [YYYY-MM-DD-hhmm]. The most current snapshot
  is additionally presented as "current".


**test** and **prod**:
  These interfaces should be seen as static representation of data from specific
  date/times. Each mirrored repository (if configured to be listed here) is
  listed with a link to a specific snapshot of the repo in question. The PROD
  repository is what is used in the production environment and should never be
  more recent than TEST (this is actually prohibited by the setup routine for
  these pointers). Data is available concurently with the snapshots it is linked
  to.


Manual routine for instant publicizing
``````````````````````````````````````

**rpm**:
  Nothing required!

**yumrepo**:
  New files are available through the ordinary interfaces after mirroring and
  snapshoting. This is usually done nightly, but the routines might be run
  manually if necessary:
  
  1. /opt/kelda/repoadmin.sh -e prod sync && /usr/sbin/restorecon -R /var/www/html/uh-iaas/
  2. /opt/kelda/repoadmin.sh -e prod snapshot
  
  All commands must be done with root privileges, which for the iaas user means through `sudo`.


Caveats
-------

* Any changes in the local YUM repository (``yumrepo``) is not
  accessible through the mirror interface (``repo``) until after the next upcoming
  mirror job (usually during the next night, check crontab on the mirror server
  for details). After this the data should be accessible under the ``repo`` link.
  
* New data mirrored is available under the ``snapshot`` link only after the next
  snapshot run (check crontab for details). This is normally scheduled for some
  time after the nightly mirror job.

* Data stored in any of the two local repositories are instantly accessible when
  accessed using the direct URL's as listed above.

