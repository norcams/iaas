==========
Vagrant up
==========

The nodes in vagrant should be started in stages. Each stage should complete
before the next one are started.

**First stage:**

  * db-global
  * db-regional
  * mq
  * api
  * dashboard (optional)
  * access (optional)
  * monitor (optional)
  * logger (optional)
  * proxy (optional)
  * admin (optional)

**Second stage:**

  * identity

**Main stage:**

  * novactrl
  * image
  * volume
  * network
  * console (optional)
  * metric (optional)
  * telemetry (optional)

**Last stage:**

  * compute

Final fixes
===========

A few final stages are needed to start an instance in vagrant.

Host aggregate and AZ
---------------------

After running vagrant up compute you will need to run vagrant provison novactrl
to add the newly created compute node to a host aggregate and the correct
availability zone (AZ).

Metadata api
------------

We need to restart openstack-nova-metadata-api on compute-01. This can be done with ansible::

  ansible-playbook -e "myhosts=vagrant-compute" lib/restart_compute_services.yaml


Flavors
-------

Flavors are missing. m1 can be added with :file:`himlarcli/flavor.py` or openstack cli::

  ./flavor.py update m1

Image
-----

You will need a public cirros image to test with. One way to quickly fix this are to
use :file:`himlarcli/image.py` and then just run::

  ./image.py update -i vagrant.yaml

Dataporten
----------

`See more about setting up dataporten in vagrant <dataporten.html>`_

After running destroy/up only himlarcli/dataporten.py will be needed.

To create a dataporten user in vagrant after setting dashboard up, we can use
:file:`himlarcli/access.py` to add a user request to the queue and process the
request and add the user.
