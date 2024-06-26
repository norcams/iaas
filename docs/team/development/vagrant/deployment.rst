.. |date| date::

======================================
Deploy himlar and himlarcli to Vagrant
======================================

Last changed: |date|

himlarcli
=========

From login to proxy, like prod (starting on host)::

  ssh vagrant
  # Check that agent is forwarded
  ssh-add -L
  git clone https://github.com/norcams/ansible
  cd ansible
  ./bin/himlarcli.sh vagrant

Fixes:

- Whitelist error for bin/himlar.sh

Create the empty file::

  [<username>@vagrant-login-01 ~]$ sudo -i
  [root@vagrant-login-01 ~]# touch /opt/repo/secrets/common/whitelist_users.txt

- DK locale in himlarcli/printer.py causing problems

Install package::

  [root@vagrant-proxy-01 ~]# dnf install glibc-langpack-en

Comparison:

Vagrant::

  ./bin/himlarcli.sh vagrant

Prod::

  ./bin/himlarcli.sh osl

himlar
======

Using vagrant. Does not require admin node, unlike puppet agent -t

Example 1: vagrant rsync and provision from host:<himlar>

Sync current himlar repo::

  vagrant rsync compute

Apply puppet from himlar for a role::

  vagrant provision compute

Example 2: Puppet apply from node

Apply puppet from himlar for a node::

  vagrant ssh compoute
  sudo -i
  puppet apply /opt/himlar/manifests/site.pp

Comparisons:

Vagrant::

  1: vagrant rsync
  2: vagrant provision
  3: ./opt/himlar/provision/puppetrun.sh
  4: puppet apply /opt/himlar/manifests/site.pp

Prod::

  1: ./bin/deploy.sh osl
  2: puppet agent -t
  3: ./opt/himlar/provision/puppetrun.sh
  4: puppet apply /opt/himlar/manifests/site.pp

Note! In prod, puppet apply performs caching locally, while puppet agent -t checks puppetmaster (admin node).

