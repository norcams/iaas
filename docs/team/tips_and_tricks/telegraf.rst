========
Telegraf
========

We use Telegraf to collect metrics which is stored in InfluxDB. 

Lsit of current plugins in use
Redfish
Nvidia-smi

To test a config and see which metrics are collected you can run this 
.. code:: bash

   telegraf -test -config /etc/telegraf/telegraf.d/redfish.conf 

Metrics collected can be used in Grafana, queries from InfluxDB can be used to plot graphs in Grafana. 