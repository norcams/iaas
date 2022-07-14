===========================
Migrate a running instances
===========================

Last changed: 2022-07-14

This document describes migrating an instance from one compute node (source) to
another (target) while the instance is running (e.g. NOT legacy). The aggregate
cannot have any NUMA aware instances (e.g. Alice/Atlas workload).

Before you start
================

* Reinstall and test the target
* Make sure the target and source are in the same aggregate
* Make sure :file:`cpu_model` (see nova.conf) is the same on target and source
  (e.g. Haswell-noTSX)

Migrate
=======

We use `himlarcli <himlarcli/index.html>`_ and :file:`migrate.py migrate` to do
the migration.

Tips
====

* Test first with :file:`--limit 1` to see that everything is working
* Use :file:`--large` on first run to migrate the instances with lots of RAM first

Known issues
============

If an instance where created with a server group and this server group are deleted
the instance can refuse to be migrated. This behavior have been seen on some
instances with local storage (e.q. shpc or alice). There is a script in himlarcli
to fix the problem:

.. code:: bash
   
   ./request_specs.py show <instance-id>

if there is a server group present and this cannot be found with openstack cli we
can remove the group from the instance scheduler hints:

.. code:: bash
   
   ./request_specs.py remove-hints <instance-id>

Help
====

This document describes using openstack cli to migrate an instance to target and
what to do when a migration times out:

https://docs.openstack.org/nova/latest/admin/live-migration-usage.html
