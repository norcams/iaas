=================
Repository server
=================

For locally created packages and to ensure integrity and version control of
externally hosted essential code a local repository server is set up outside of
the cloud infrastructure.

* **Hostname**: ``iaas-repo.uio.no``
* **Alias** (name used in code): ``download.iaas.uio.no``
* **Access**: as for normal infrastructure nodes (*iaas*-user from one of the
  login nodes)
* **Repo root directory**: ``/var/www/html/uh-iaas``


Internally produced packages
============================

Packages built locally by the project are made available for use (default for the world!)
by storing it in one of the prepared directories depending on whether the package is to
be part of a yum repository or as a stand-alone package.

The *iaas* group owns all files and directories under the repo root, the
hierarchy is configured with the `set group ID` bit. Accordingly
all relevant repo operations can (and should) be done as the *iaas* user.

**NOTE**

Make sure new packages and files have the correct SELinux label::

  sudo restorecon <file>

or::

  sudo restorecon -R <directory>


YUM repository
--------------

Packages which should always have its latest version installed on all nodes
should be placed somewhere under the ``yumrepo`` subdirectory.

Packages which should no longer be part of this repository should be deleted for
better maintainability.

**IMPORTANT**

After all file operations update the repository meta data::

  /usr/bin/createrepo <repo root directory>/yumrepo


**URL**: `<https://download.iaas.uio.no/uh-iaas/yumrepo>`_

Also available with TLS (https)!


Standalone
----------

Packages which is needed by the project but which for some reason should be kept
outside of a normal yum repository should be placed under the ``rpm``
subdirectory. No additional operations required.

**URL**: `<https://download.iaas.uio.no/uh-iaas/rpm>`_

Also available with TLS (https)!


Local repository of externally produced code
============================================

To ensure known states of required software there is a local repository of all
external sources used. All repositories configured bu the UH-IaaS code should
point to this local site::

    https://download.iaas.uio.no/uh-iaas/prod/

This is a link to a snapshot of the data which are all tested and certified.


Directories and contents
------------------------

=============== ============================================================================================== ===============================================
Long name        Description                                                                                    URL
=============== ============================================================================================== ===============================================
Repository      Latest sync from external sources                                                              https://download.iaas.uio.no/uh-iaas/repo
Snapshots       Regular (usually daily) snapshots of data in repo                                              https://download.iaas.uio.no/uh-iaas/snapshots
Test repo       Pointer to a specific snapshot in time, usually newer than `prod`                              https://download.iaas.uio.no/uh-iaas/test 
Production repo Pointer to a specific snapshot in time with well-tested data, used in production environments  https://download.iaas.uio.no/uh-iaas/prod
=============== ============================================================================================== ===============================================


Usage is normally as follows:

:repo: for development or other use of most up-to-date code
:test: test code which is aimed for next production release
:prod: production code
:snapshots: can be used to test against code from a specific date


Configuration
-------------

Configuration for the repositories is stored in the local git repo::

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

- ``test`` should never point to older snapshots than ``prod``
- Pointers in ``prod`` **must also** exist in ``test``, the rationale
  being that this somewhat ensures that `prod` has already been tested.
  Links in the `prod` configuration which does not also exist in the `test`
  configuration will *not* be activated.
- If there are more than one link listed to the same repo the newest is always
  the one activated.
- Existing links not listed in the current configuration will be removed!


How to update
`````````````

1. Clone or pull the git repo locally
#. Edit files
#. Commit and push to central git repo
#. Log on to *osl-login-01*
#. Run the ansible job ``update_repo.yaml``::

     sudo ansible-playbook -e "hosts=download" lib/update_repo.yaml

   This action pull the latest config and update the pointers in `test` and
   `prod`.
