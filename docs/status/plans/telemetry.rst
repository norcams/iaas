======================
Telemetry and metrics
======================

Last updated: 2018-02-21

We are collecting data from polling services and notification messages from the
message queue (AMQP). The data are collected by the telemetry node(s) running
the Openstack Ceilometer, and are stored on metric node(s) in a time series
database running Gnocchi.

For ocata the measurments stored are described `in this document
<https://docs.openstack.org/ocata/admin-guide/telemetry-measurements.html>`_

Nodes and services
==================

Metric
------

This nodes are running the time series database. The metric are stored in a
database and measurement are stored on disk.

Running services

  * openstack-gnocchi-metricd
  * openstack-gnocchi-statsd
  * httpd (gnocchi api)

Dependency nodes and services

  * identity - keystone
  * db - mysql

Telemetry
---------

This nodes running polling services and collect notifications. All data are
then sent to the Gnocchi API.

Running services:

  * openstack-ceilometer-notification
  * openstack-ceilometer-polling (namespace: central)

Dependency nodes and services

  * mq - rabbitmq (notifications)
  * metric - httpd (gnocchi api)
  * api - haproxy (all endpoints for polling)
