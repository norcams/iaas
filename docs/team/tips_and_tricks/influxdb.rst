========
InfluxDB
========

Running on ``tsdb-01`` and collects status and metric from sensugo and telegraf metric from ceph.

For testing we are using `this ceph template <https://github.com/influxdata/community-templates/tree/master/ceph>`_

This can be install running this on tsdb-01

.. code:: bash

   influx apply -u https://raw.githubusercontent.com/influxdata/community-templates/master/ceph/ceph-cluster.yml --org NREC
