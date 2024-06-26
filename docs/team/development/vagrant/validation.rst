.. |date| date::

====================================
Validate that components are working
====================================

Last changed: |date|

himlarcli on host
=================

::

  ./hypervisor.py list --format table

himlarcli on proxy
==================

::

	[<username>@vagrant-login-01 ~]$ sudo ssh vagrant@vagrant-proxy-01
	sudo -i
	cd /opt/himlarcli
	source bin/activate
	./hypervisor.py list --format table

openstack cli on proxy
======================

::

	[<username>@vagrant-login-01 ~]$ sudo ssh vagrant@vagrant-proxy-01
	sudo -i
	source openrc
  openstack flavor list



