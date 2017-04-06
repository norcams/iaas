============================
Running himlarcli in vagrant
============================

You will need access to both the public and transport net on the host
you plan to run himlarcli. This should work on the same host where you
run vagrant.

Himlarcli source code
=====================

Clone the repo from https://github.com/norcams/himlarcli and follow the
instructions in the README.

config.ini
==========

You will need a working config.ini file for himlarcli. You could either copy
the one from vagrant/dev-proxy-01 node or from :file:`/opt/himlarcli/` on login.

Make sure that the following elementer in config.ini are correct:

* auth_url
* password (see hieradata/vagrant/common.yaml)
* region
* keystone_cachain

The openstack endpoints used in himlarcli must also resolv. This can be done
by editing :file:`/etc/hosts` on the host.

Testing
=======

:file:`instance.py` are good for testing both keystone and nova API, and
:file:`update_images.py` for testing glance API.
