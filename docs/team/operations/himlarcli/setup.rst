=====
Setup
=====

Location
========

Himlar CLI can be found under :file:`/opt/himlarcli` on `login-01` and
`proxy-01` nodes. Config file is distributed with puppet under
:file:`/etc/himlarcli/config.ini`.

Running on login-01
-------------------

When running scripts on login you will be able to use some scipts but not access
keystone admin API. So you will not be able to run script for user or project
management here.

Since login are used for both test and production locations there are
several config files under :file:`/opt/himlarcli/` named :file:`config.ini.<loc>`.

Deployment
==========

There is an `ansible <../ansible/index.html>`_ playbook and script to update to
latest version on all nodes::

  cd <ansible-repo>
  bin/himlarcli.sh <loc>
