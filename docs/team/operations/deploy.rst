======================
Deployment of new code
======================

Deployment is done on the puppetmaster node. From login you should reach it by running

.. code:: bash

  ssh iaas@puppet

Hieradata and profile
=====================

.. code:: bash

  cd /opt/himlar
  git pull
  apachectl graceful

Puppet modules
==============

Active puppet modules reside in `/etc/puppet/modules`. For minor changes in
`Puppetfile` this should update the active modules from source:

.. code:: bash

  cd /opt/himlar
  HIMLAR_PUPPETFILE=deploy provision/puppetmodules.sh
  apachectl graceful

To rebuild all modules from source:

.. code:: bash

  rm -Rf /etc/puppet/modules
  cd /opt/himlar
  provision/puppetmodules.sh
  apachectl graceful


Secrets
=======

Secrets are stored at `git@git.<domain>` in `hieradata/secrets`.
To update /opt/himlar/hieradata/secrets:

.. code:: bash

    cd /opt/himlar
    provision/puppetsecrets.sh

With ansible
============

To use `ansible <ansible/index.html>`_ to deployment::

  cd <ansible-repo>
  bin/<loc>/deploy.sh
