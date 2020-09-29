================
Cleanup old data
================

All Openstack services keeps the deleted objects stored in the database until
we tell dem to archive the data to shadow tables. Most services have command
line tools to do this and also purge old data from the shadow tables (some
services might only have the purge option and not move to shadow tables).

Nova
====

Cinder
======

Check old data for problems
===========================

Nova
----

The block_device_mapping tables can grow a lot when we have rogue automatic
services like cinder-csi in openshift.

To find top 10 instances with possible problems use this command in nova db.

.. code-block:: sql

  select instance_uuid, count(instance_uuid) from shadow_block_device_mapping
  group by instance_uuid order by count(instance_uuid) desc limit 10;

To check from a date use something like this (change the date):

.. code-block:: sql

  select instance_uuid, count(instance_uuid) from shadow_block_device_mapping
  where created_at > '2020-07-13 09:30:53' group by instance_uuid order by
  count(instance_uuid) desc limit 10;
