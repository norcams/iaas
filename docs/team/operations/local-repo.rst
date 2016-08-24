=================
Repository server
=================

For locally created packages and to ensure integrity and version control of
externally hosted essential code a local repository server is set up outside of
the cloud infrastructure.

* **Hostname**: ``iaas-repo.uio.no``
* **Alias** (name used in code): ``downloads.iaas.uio.no``
* **Access**: as for normal infrastructure nodes (*iaas*-user from one of the
  login nodes)
* **Repo root directory**: ``/var/www/html/uh-sky``


Internally produced packages
============================

Packages built locally by the project are made available for use (default for the world!)
by storing it in one of the prepared directories depending on the package is to
be part of a yum repository or as a stand-alone package.

The *iaas* group owns all files and directories under the repo root, the
hierarchy is configured with the `set group ID` bit. Accordingly
all relevant repo operations can (and should) be done as the *iaas* user.


YUM repository
--------------

Packages which should always have its latest version installed on all nodes
should be placed somewhere under the ``yumrepo`` subdirectory.

Packages which should no longer be part of this repository should be deleted for
better maintainability.

**IMPORTANT**

After all file operations update the repository meta data::

  /usr/bin/createrepo <repo root directory>/yumrepo


**URL**: `<http://download.iaas.uio.no/uh-sky/yumrepo>`_

Also available with TLS (https)!


Standalone
----------

Packages which is needed by the project but which for some reason should be kept
outside of a normal yum repository should be placed under the ``rpm``
subdirectory. No additional operations required.

**URL**: `<http://download.iaas.uio.no/uh-sky/rpm>`_

Also available with TLS (https)!


Local repository of externally produced code
============================================

To ensure known states of required software is always available there is plans
for a local cache with well defined snapshots stored on this system. The setup
is under testing and will be documented in this section in due time.

