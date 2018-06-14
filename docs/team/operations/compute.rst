.. |A| image:: /images/16x16_yes.png
.. |O| image:: /images/16x16_no.png
.. |I| image:: /images/16x16_warning.png

==================
Compute management
==================

Note all AZ names will have a region prefix not used in this document.
E.g. `default-1` will be `bgo-default-1` in `bgo`.

Updated information about active aggregate and compute host lists can be found in
`Trello <https://trello.com/norcams>`_.

Organization
============

Each compute host should only be in one host aggregate and one availability zone.

Availability zone
-----------------

We have 3 different AZ:

* default-1
* legacy-1
* iaas-team-only-1 [*]_

.. [*]  this is only available to limited projects (e.g. iaas-team). Note that
        everybody can see it, but will get a "No valid host" error if they try
        to use it. This is also the default AZ for new compute hosts.

Host aggregate
--------------

Each AZ have one or more host aggregates with hosts.

* central1 (default-1)
* group1 (legacy-1)
* group2 (legacy-1)
* group3 (legacy-1)
* placeholder1 (iaas-team-only-1)

Disk setup
==========

Each compute host can either be setup with local disk for instances or use
Ceph. This should not be changed without a full reinstall. To see det disk
setup for a compute host look inn the hieradata node file.

Aggregate management
====================

All aggregates in `legacy-1` will be managed by aggregate.py in himlarcli.
This include activate (enable/disable hosts), migrate and notification.

The addition and removal of compute hosts in aggregates are manual and can be
done with Openstack CLI.

Workflow example
----------------

If we need to use a standby compute host (called compute-XY) from placeholder1
in central1 we will need to do the following:

* Reinstall compute-XY with correct disk setup
* Disable other hosts in `iaas-team-only-1` and enable compute-XY
* Test compute-XY by staring an instance in `iaas-team-only-1`
* With Openstack CLI remove compute-XY from placeholder1 aggregate and add to central1


Compute reinstall
=================

For compute host (hypervisor) management use himlarcli and hyervisor.py.
This script will have sub commands for enable/disable and move between
aggregate.

Before you start make sure the compute host are empty and disabled.

Ansible script
--------------

NB! Delete the running instances or migrate them to another compute node before you start!

To reinstall a compute host with `ansible <ansible/index.html>`_ run::

  cd <ansible-repo>
  bin/rebuild_compute.sh <HOST> --force

Testing
-------

To test the compute host after a reinstall move it to the placeholder1 host
aggregate og test with iaas-team-only-1 AZ and iaas-team only project.
