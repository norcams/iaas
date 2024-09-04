=================
Repository server
=================


Introduction
============


For local caching of external repositories and to facilitate a repository of
packages created by the NREC team etc., a server system is installed.
Because the production environment has to be carefully managed, some issues are
raised which is attempted resolved by this setup:

* Production servers must only run well-known versions and combinations of
  software (which is supposed to be tested and approved before deployment)
* Possible to check state of code at any date in the past for debugging
* Possible to test new code without disturbing production environment
* Ability to maintain our software in the same manner as any external
  RPM repository
* Means to distribute all kind of data files without versioning


To accomplish all of this we have implemented both a system for versioned/snapshotted
mirrors of any 'external' repo (whatever the location), a local ordinary RPM
repository and a general distribution point.

* **Hostname**: ``iaas-repo.uio.no``
* **Alias** (used in code): ``download.iaas.uio.no``
* **Access**: as for normal infrastructure nodes (*iaas*-user from one of the
  login nodes)
* **Repo root directory**: ``/var/www/html/nrec``
* **Available protocols**: ``https``


.. Note::
   The implementor accepts the fact that the naming scheme
   for these directories is misleading! Please read the description
   before assuming anything related to the role of the directory!


Executive Summary
-----------------

**repo** is a locally hosted mirror of a set of external repositories. A
snapshot is taken of each repo every night, and these snapshots resides inside
the **snapshot** directory stamped by date. In the **test** and **prod**
directories every repository utilized by the UH-IaaS infrastructure has a
pointer to one of those snapshots. Those pointers are never moved without
consideration or testing, especially the links in the **prod** directory. The
upshot is thus: packages and files can be trusted not to be updated or altered
in an uncontrolled fashion, and is available locally at all times. It is
possible to set up further such repos, in case a certain installation requires
packages from a very specific date (other than in **test** and **prod**).

**nrec-internal**, **nonfree/yum-nonfree** and **aptrepo** should be assumed to be like any other ``external``
repositories, just that these `external` repositories are coincidentally managed by
the NREC team. Data configured into these are then available for consumption
in the same controlled manner as any other external repository which is mirrored
locally.

**rpm**, **nonfree**, **nrec-resources** and **ports** are
`unmanaged` repositories without the forementioned snapshotting and consistent
control. Data located here is available instantly, but outside of any version
control and without any kind of meta data.


Diagram of setup
----------------


.. image:: images/repo.png


Directory description
---------------------

* **repo**: Mirror hierarchy. This is where all defined repositories are mirrored.
  Content is mirrored nightly.
* **snapshots**: Nightly snapshot of all mirrors under ``repo``. Each snapshot is
  named by the date and time of creation.
* **prod**: For each repository a pointer (symbolic link) to a snapshot of the
  same.
* **test**: As for ``prod``, but separate links (usually for a more recent
  snapshot which is supposed to be used for production next).
* **nrec-internal** (prev. *yumrepo*): Locally maintained RPM repository. Mirrored under ``repo`` as any
  external repository is. Available for *el7* and *el8*.
* **aptrepo**: Locally maintained APT repository. Mirrored under ``repo`` as any
  external repository is (named *nrec-internal-apt*).
* **rpm**: Generic file distribution. No metadata, versioning, mirroring or
  snapshotting.
* **nonfree** Generic file distribution. No metadata, versioning, mirroring or
  snapshotting. Only accessible from login and proxy-nodes!
* **nrec-resources** Generic file distribution. No metadata, versioning, mirroring or
  snapshotting. Only accessible from NREC allocated IP ranges (incl. user
  instances)!
* **nonfree/yum-nonfree** Restricted locally maintained RPM repository. Mirrored under ``repo`` as any
  external repository is (under the name *nrec-nonfree*) Only accessible from login
  and proxy-nodes! Available for *el7* and *el8*.
* **gem**: Local Ruby Gem distribution. No metadata, versioning, mirroring or
  snapshotting.
* **ports**: For FreeBSD packages. No metadata, versioning, mirroring or
  snapshotting.

Common attributes and requirements
==================================

Packages built locally by the project are made available for use by storing it
in one of the prepared directories depending on whether the package is to be
part of a yum repository or as a stand-alone package or file, and whether it
should be exposed to the world or only internally.

The *iaas* group owns all files and directories under the repository root
directory; the hierarchy is configured with the `set group ID` bit. Accordingly,
all relevant repo operations can (and should) be done as the *iaas* user.

**NOTE**

Make sure new packages and files have the correct SELinux label::

  sudo restorecon <file>

or::

  sudo restorecon -R <directory>



Detailed descriptions
=====================

In addition to the mirror service of true external repositories, the service
contains and offers several proper local ones. Each of these serves different
purposes, and thus has to be handled and maintained using distinct procedures.
This section describes each and how to add and update packages and files.

YUM repository
--------------

**Directory name**: ``nrec-internal/el[78]`` (wolrd wide availability)
                    ``nonfreei/yum-nonfree/el[78]`` (internally available)

For local RPM packages which are maintained in the same way as any external RPM
packages from ordinary repositories, there are YUM repos located in ``nrec-internal``
and ``nonfree-nonfree``. The former have world wide availability while the
latter is only available locally. They are both versioned/snapshot'ed.
These files/packages are considered and consumed exactly like any other, external,
repository used by the project/code!


**IMPORTANT**

After all file operations update the repository meta data::

  sudo /usr/bin/createrepo <repo root directory>/[nrec-internal|nonfree/yum-nonfree]/el[78]


**URL**:
  `<https://download.iaas.uio.no/nrec/nrec-internal>`_
  `<https://download.iaas.uio.no/nrec/nonfree/yum-nonfree>`_

.. NOTE::
   The repositories are mirrored and snapshotted just like any external
   repository. As such they can be reached through the `test` and `prod`
   interfaces described elsewhere.
   NB: the nonfree repo is known as *nrec-nonfree* when mirrored!

Client configuration (example)
``````````````````````````````

Example of client configuration in a yum repo file under ``/etc/yum.repos.d/``::

  [nrec-internal]
  name=NREC internal repo
  baseurl=https://download.iaas.uio.no/nrec/prod/nrec-internal/el8
  enabled=1
  gpgcheck=0
  priority=10

For the internal (nonfree) repository::

  [nrec-nonfree]
  name=Internal NREC repository
  baseurl=https://download.iaas.uio.no/nrec/prod/nrec-nonfree/el8
  enabled=1
  gpgcheck=0
  priority=10


APT repository
--------------

**Directory name**: ``aptrepo``

iFor local APT-packages which belongs in an ordinary DEB-based repository ithere
is a similar setup as for the above mentioned YUM repository.
This is located in ``aptrepo``.
These files/packages are then considered and consumed exactly like any other,
external, repository used by the project/code.

The architectures and codenames supported are described in the `distribution`
file located in the ``apt`` subdirectory of the *repo-admin* GIT repository.

Steps to import packages
````````````````````````

1. Save new package to the ``incoming`` subdirectory inside *aptrepo*

#. Execute the deb repo tool inside the ``aptrepo`` directory::

    reprepro -b . --confdir /etc/kelda/prod/apt includedeb wheezy incoming/\*

    (replace *wheezy* with whatever codename is considered)

#. Remove package(s) from the ``incoming`` directory



**URL**: `<https://download.iaas.uio.no/nrec/aptrepo>`_

.. NOTE::
   This repository is mirrored and snapshotted ijust like any external
   repository (named *nrec-internal-apt*). As such it can be reached through the
   `test` and `prod` interfaces described elsewhere.

Client configuration (example)
``````````````````````````````

Example of client configuration in ``/etc/apt/sources.list``::

  deb [trusted=yes] https://download.iaas.uio.no/nrec/prod/nrec-internal-apt wheezy main


(Temp) How to build reprepro
````````````````````````````

*reprepro* has been fetched from ``epel``, but this package is not (yet) built
for RHEL 9. It is thus built locally for now, until a proper package is
available. This section should then be removed!

On a clean **UiO managed RHEL 9** instance, these commands is run to build a
*reprepro* command for EL9 (inside a suitable build area):

1. dnf install git automake libdb-devel zlib-devel bzip2-devel xz-devel
#. git clone https://salsa.debian.org/debian/reprepro.git
#. cd reprepo
#. ./autogen.sh
#. /configure --with-libgpgme=no
#. make

There should now be a *reprepro'* binary inside this directory. This file is
copied over to */usr/local/sbin* on `download`.


Ruby Gem repository
-------------------

**Directory name**: ``gem``

Gems which are locally produced or adapted might be installed into this
repository. The gems might then be installed through the 'sensu_gem* puppet
provider or using the `--source` parameter for *gem install*.


Steps to import gems
````````````````````

- upload package into the `gems` subdirectory
- remove all files named '\*specs\*'  (should be 6 all in all)
- remove the `quick` subdirecory recursively
- run as the `iaas` user:
  *gem generate_index --update --directory .*
  (ignoring errors)


For upload procedure, see below.


Standalone file archives
------------------------

**Directory name**: ``rpm``, ``nrec-resources`` and ``nonfree``

Files (RPM packages or other types) which are needed by the project but which should or cannot
use the local YUM repository, can be distributed from the generic archive
located under the ``rpm``, ``nrec-resources`` or ``nonfree`` subdirectory. No additional operations required, other
than the ensuring correct SELinux label as described above.

**URL**: `<https://download.iaas.uio.no/nrec/rpm>`_
**URL**: `<https://download.iaas.uio.no/nrec/nonfree>`_
**URL**: `<https://download.iaas.uio.no/nrec/nrec-resources>`_

The distinction between those, is that `nonfree` is only accessible from a
restricted set of IP addresses (at the time of writing the *login* and *proxy*
nodes), `nrec-resources` from all NREC allocated ranges (infra and instances)
whereas `rpm` is reachable from the world.

The access lists for the restricted areas are maintained in the *repo-admin*
gitolite repository, in the `httpd` subdirectory.


Upload procedure
````````````````

Probably the simplest way to upload a file to the ``rpm`` (or ``nonfree``) archive is to first
place the file on an available web site and then download it into the archive on *download*:

1. upload file to a web archive (for instance `<https://folk.uio.no>`_ for UiO affiliated personel)
#. log in to *download* from one of the login nodes in the usual manner::

    sudo ssh iaas@download.iaas.uio.no

#. `cd /var/www/html/nrec/rpm`

#. download the file with wget, curl or something like that


Local mirror and snapshot service
=================================


To facility tight control of the code and files used in our environment, and to
ensure the availability in case of network or external system outages, etc., a
local mirror and snapshot service is implemented.

Content and description of included subdirectories:

========== =============== ============================================================================================== ===============================================
Short name Long name        Description                                                                                    URL
========== =============== ============================================================================================== ===============================================
repo       Repository      Latest sync from external sources                                                              https://download.iaas.uio.no/nrec/repo
snapshots  Snapshots       Regular (usually daily) snapshots of data in repo                                              https://download.iaas.uio.no/nrec/snapshots
test       Test repo       Pointer to a specific snapshot in time, usually newer than `prod`                              https://download.iaas.uio.no/nrec/test
prod       Production repo Pointer to a specific snapshot in time with well-tested data, used in production environments  https://download.iaas.uio.no/nrec/prod
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
attempted accessed and synced. The type of repository - as defined in the
configuration file for the appropriate listing - determines what actions are
taken on the data. As this is mainly YUM repositories, the appropriate metadata
commands are executed to create a proper local repository. Any YUM repo defined
in the configuration must have a corresponding repo-definition in a suitable
file in the ``yum.repos.d`` subdirectory (in the git repo!).

The mirroring is done once every night by a root cron job.

To access the most current data in the mirror, us this URL::

    https://download.iaas.uio.no/nrec/repo/

This repository also contains the access list configuration for the restricted
areas like **nonfree** and **nrec-resources**.

Snapshots
---------

**Directory**: ``snapshots``

Every night a cron job runs to create snapshots of all mirrored repositories (of
all kinds). A snapshot subdirectory is created named by the current date and time.
Under this, all repos can be accessed. This way any data can be retrieved from
any data in the past on which a snapshot has been taken.

*current*: In the ``snapshots`` directory there is always a special "snapshot"
named ``current``. This entry is at any time linked to the most current
snapshot.

To access the snapshot library::

    https://download.iaas.uio.no/nrec/snapshots/


.. Note::
   The snapshot data are created using a system of hardlinks. This way unaltered
   data is not duplicated, which conserves space considerably.


Test and prod
-------------

**Directories**: ``test``, ``prod``


All mirrored repos used by NREC can be accessed through a static and well
known historic version using the *test* and *prod* interfaces. By configuring
the appropriate files in the internal **repo-admin** git repo, each repo might
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
  ``prod`` are linking to
- If there are more than one link listed to the same repo the most current
  is always the one activated.
- Existing links not listed in the current configuration will be removed!

Update procedure
````````````````

1. Clone or pull the git repo locally::

     git@git.iaas.uio.no:repo-admin

   This must be done on a node inside the set up (like the login nodes) due
   to access restrictions on the local git repo.
#. Edit one or both files: `prod.config` and/or `test.config` (or any of the
   other config files), entering or changing to reflect the date required (consult
   `the web page <https://iaas-repo.uio.no/nrec/snapshots/>`_ for exact
   timestamp to use.
#. Commit and push to the central git repo.
#. On `osl-login-01` run the ansible job ``update_repo.yaml``::

     sudo ansible-playbook -e "myhosts=download" lib/update_repo.yaml

   This action pull the latest config and update the pointers in `test` and
   `prod`.


Publicizing procedure
---------------------

Normal (automatic)
``````````````````

**rpm**, **nonfree**, **nrec-resources**  and **gem**:
  Files placed inside this location is instantly accessible, provided correct
  SELinux labeling. No snapshotting provided! Access lists set up via the
  configuration and scripts in the `httpd` subdirectory of the *repo-admin*
  repo documented above.


**nrec-internal** and **aptrepo**:
  Files placed inside this location is instantly accessible, provided correct
  SELinux labeling. No snapshotting provided through this interface! For this use
  the SNAPSHOT, TEST or PROD interfaces instead.


**repo**:
  Any repositories which are mirrored (including YUMREPO) have new files
  accessible here after the mirroring job is run during night time. The version
  available is always the most recent!


**snapshots**:
  Every night after mirror job completion a snapshot of the current mirrors are
  taken. Any of these snapshots are available through this interface below a
  directory named by the timestamp [YYYY-MM-DD-hhmm]. The most current snapshot
  is additionally presented as "current".


**test**, **prod**:
  These interfaces should be seen as a static representation of data from specific
  date/times. Each mirrored repository (if configured to be listed here) is
  listed with a link to a specific snapshot of the repo in question. The PROD
  repository is what is used in the production environment and should never be
  more recent than TEST (this is actually prohibited by the setup routine for
  these pointers). Data is available concurrently with the snapshots it is linked
  to.


Manual routine for instant publicizing
``````````````````````````````````````

**rpm**, **nonfree** (incl. *yum-nonfree*), **gem**  and **ports**:
  Nothing required!

**nrec-internal**, **nrec-nonfree**  and **aptrepo**:
  New files are available through the ordinary interfaces after mirroring and
  snapshotting. This is usually done nightly, but the routines might be run
  manually if necessary:

  1. sudo /opt/kelda/repoadmin.sh -e prod sync
  2. sudo /opt/kelda/repoadmin.sh -e prod snapshot


Caveats
-------

* Any changes in the local YUM or APT repositories (``nrec-internal``, ``nrec-nonfree``
  resp. ``aptrepo``) are not accessible through the mirror interface (``repo``) until
  after the next upcoming mirror job (usually during the next night, check crontab on
  the mirror server for details). After this, the data should be accessible under the
  ``repo`` link.

* New data mirrored is available under the ``snapshot`` link only after the next
  snapshot run (check crontab for details). This is normally scheduled for some
  time after the nightly mirror job.

* Data stored in any of the local repositories are instantly accessible when
  accessed using the direct URL's as listed above.


Purging of old/unused data
==========================

For conservation of disk space there is a janitor script which may be used to
remove (purge) snapshots which are no longer used::

  /usr/local/sbin/snapshot_cleanup.sh

.. Note::
   Only snapshots older than the oldest snapshot still referenced by any
   `test` or `prod` pointers may be deleted.

Invocation:

.. parsed-literal::
   [ sudo ] /usr/local/sbin/snapshot_cleanup.sh [-d|u] [ [-t <YYYY-MM-DD-HHMM> ] | [-r <repository name>] ]

   -u: print usage text and exit
   -d: dry-run (just print what would otherwise be deleted)
   -t: purge snapshots older than timestamp provided
       Timestamp format equals format used by kelda (config fields and snapshot
       directory naming)
   -r: expunge named repository, complete with mirror and every snapshot of it
       (but only snapshots of this particular mirror)

   NB: `-t` and `-r` are mutually exclusive!

   If no `-t` or `-r` argument provided then all snapshots older than oldest still in
   use are removed!

For now there is no automatic invocation, and any cleanup should be done
manually. User confirmation is requested. If running as the *iaas* user then
`sudo` is required.
