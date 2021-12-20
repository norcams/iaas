==========
Vagrant up
==========

The nodes in vagrant should be started in stages. Each stage should complete
before the next one are started.

**First stage:**

  * db-global-01
  * db-regional-01
  * mq-01
  * api-01
  * dashboard-01 (optional)
  * access-01 (optional)
  * monitor-01 (optional)
  * logger-01 (optional)
  * proxy-01 (optional)
  * admin-01 (optional)

**Second stage:**

  * identity-01

**Main stage:**

  * novactrl-01
  * image-01
  * volume-01
  * network-01
  * console-01 (optional)
  * metric-01 (optional)
  * telemetry-01 (optional)

**Last stage:**

  * compute-01

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
