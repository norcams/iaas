======================
Deployment of new code
======================

With ansible
============

To use `ansible <ansible/index.html>`_ to deployment::

  cd $ANSIBLE
  bin/deploy.sh <loc>

.. CAUTION::
  Sometimes the r10k used in :file:`provision/puppetmodules.sh` will not deploy
  a new version of a puppet module. Check deployed module version in
  :file:`/etc/puppetlabs/code/modules/<modulename>/metadata.json`

Manual deployment
=================

Deployment is done on the :file:`admin-01` node. From login you should reach it by running

.. code:: bash

  ssh iaas@<loc>-admin-01.<domain>

Hieradata and profile
---------------------

.. code:: bash

  sudo -i
  cd /opt/himlar
  git pull

Puppet modules
--------------

Active puppet modules reside in `/etc/puppetlabs/code/modules`. For minor
changes in `Puppetfile` this should update the active modules from source:

.. code:: bash

  cd /opt/himlar
  HIMLAR_PUPPETFILE=deploy provision/puppetmodules.sh

To rebuild a module from source:

.. code:: bash

    rm -Rf /etc/puppetlabs/code/modules/<modulename>
    cd /opt/himlar
    HIMLAR_PUPPETFILE=deploy provision/puppetmodules.sh

To rebuild all modules from source:

.. code:: bash

  rm -Rf /etc/puppetlabs/code/modules/*
  cd /opt/himlar
  provision/puppetmodules.sh




Secrets
-------

Secrets are stored at `git@git.<domain>` in `hieradata/secrets`.
To update /opt/himlar/hieradata/secrets:

.. code:: bash

    cd /opt/himlar
    provision/puppetsecrets.sh
