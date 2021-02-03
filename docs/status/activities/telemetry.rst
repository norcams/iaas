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

Compute
-------

This nodes runs the compute polling services. It also sends notifications to
the message queue. The data are sendt directly to the gnocchi api for storage.

Running services:

  * openstack-ceilometer-polling (namespace: compute)

Dependency nodes and services

  * mq - rabbitmq (notifications)
  * metric - httpd (gnocchi api)
  * api - haproxy (volume and image for polling instans data)


Users and projects
==================

We will need users and projects in keystone to access and limit access to
Gnocchi. Ceilometer also needs an admin user for polling data from services.

Vi use the default project :file:`services` in default domain. The following
nodes will now also have access:

* telemetry: ceilometer (role: admin)
* metric: gnocchi (role: admin)
* monitor: monitor (role: user)
* status: statis (roles: user)
