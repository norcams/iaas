.. |date| date::

[2021] Data processing
======================

``REVISION 2021-10-20``

.. contents::

.. _OpenStack Security Guide\: Data processing: http://docs.openstack.org/security-guide/data-processing.html

From `OpenStack Security Guide\: Data processing`_:

  *The Data processing service for OpenStack (sahara) provides a
  platform for the provisioning and management of instance clusters
  using processing frameworks such as Hadoop and Spark. Through the
  OpenStack dashboard or REST API, users will be able to upload and
  execute framework applications which may access data in object
  storage or external providers. The data processing controller uses
  the Orchestration service to create clusters of instances which may
  exist as long-running groups that can grow and shrink as requested,
  or as transient groups created for a single workload.*

.. NOTE::
   Does not apply. We are not using Sahara.
