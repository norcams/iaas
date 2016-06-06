==========
Himlar CLI
==========

Himlar CLI is a command line tool written in Python to manage our Openstack
installation through the API.

Source code: https://github.com/norcams/himlarcli

Location
========

Himlar CLI can be found under :file:`/opt/himlarcli` on `login`, `master` and
`dashboard` nodes. Config file is distributed with puppet under
:file:`/etc/himlarcli/config.ini`.

Deploy
------
There is an `ansible <ansible/index.html>`_ playbook and script to update to
latest version on all::

  cd <ansible-repo>
  bin/<loc>/himlarcli.sh

Running
=======

All python script should have help text when passing `-h` argument to a script.

Login
-----
When running scripts on login you will be able to send mail but not access
keystone admin API. So you will not be able to run script for user or project
management here (including stats.py).

Since login are used for both development and production locations there are
several config files under :file:`/opt/himlarcli/` named :file:`config.ini.<loc>`.


Notify users
============

:file:`notify_reinstall.py` will send an email to each user that have an
instance running on a compute host. This email will include a list of
affected instances. The mail body can be edited under
:file:`misc/notify_email.txt`.

Host operations
===============

With :file:`host.py` there are options to `stop`, `start`, `list` or `delete`
instances on a compute host.
