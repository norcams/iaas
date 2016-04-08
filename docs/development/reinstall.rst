.. |date| date::

=========
Reinstall
=========

Last changed: |date|

.. contents:: :depth: 2

Secrets
=======

Secrets for nodes are stored under ``/opt/repo/secrets/nodes`` on the login
node. To deploy these we use ansible. You also need access to the local
git repo on login. If clone fails get help to add your key to gitolite.

Make sure you have your ssh key in ssh-agent on login first with ``ssh-add -l``.

As yourself on login run::

  git clone git@git.iaas.uio.no:ansible
  cd ansible
  bin/<location>-dashboard.sh
