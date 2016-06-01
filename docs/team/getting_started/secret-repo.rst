=================
Secret repository
=================

For data that should not be publically available (on GitHub or elsewhere) there
is a in-house repository named `secrets` This contains these areas:

- hieradata

  Data used by the **himlar** code. This area is controlled by *git*

- nodes

  For files only used by or on specific systems

- common

  Non-host specific files, like licenses and proprietary binaries


hieradata
---------

Data in here is accessed and controlled by *git* at `git@git.<domain>` in `hieradata/secrets`.

This repo should not be accessed outside our locations and you will need your
SSH key to get access to the git repo (try ssh -A <user>@<loc>-login-01).

For retrieval and update of data, follow this routine:

.. code:: bash

    git clone git@git.iaas.uio.no:hieradata/secrets
    cd secrets
    ... edit ...
    git commit ...
    git push


For activation consult the ``Deployment`` section of this documentation.


nodes and common
----------------

Data under these sections are stored manually under the respective directory on
any of the login nodes. Afterwards data should be synced between the locations
using the script described below.

Data under `common` can be stored arbitrarily. For `nodes` create a directory
name by the shortform of the hostname (i.e. non-FQDN). For data utilized by *ansible*
driven jobs the structure might be dictated by the playbook used. One of those
is the SSL certificate distribution.


Syncronization of data between repositories
'''''''''''''''''''''''''''''''''''''''''''

.. NOTE::
   The script described here is not yet fully functional!

The login node in OSL is defined as *master*, the implication being::

  - data which exists on several locations is set to the content of the osl data
  - data which exists solely on the slave is copied to the master


To syncronize, run as yourself after any change:

.. code:: bash

    cd /opt/repo/secrets
    ./secret-sync.sh [delete]

The `delete` option removes any files on slave(s) which does not exist on the
master. Use this with caution!

The rquirements for this to work is that all files and directories are owned and
writeable by group ``wheel``!
