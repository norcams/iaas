==
DB
==


Howto fix cluster
=================

If we get a warning from sensu about::

  CheckWsrepReady CRITICAL: WSREP Ready is not ON. Is OFF

then the galera cluster is broken. This will happen if we have network
problems in one location or the :file:`db-01` node is down in a location.

First thing we need to do is to stop the server on all :file:`db-01` nodes::

  service mysqld stop

At the time the of writing the API is running on :file:`bgo-api-01` so
the identity db must also be running in bgo. If we move the API the cluster
must be started on the new location. On the master location, e.g. node
:file:`bgo-db-01`::

  galera_new_cluster

When the second location is back online we only need to start the servere::

  service mysqld start

How to fix etcd cluster
=======================

The etcd cluster needs to be reconfigured from time to time, and typically if a
network node is reinstalled. In order to include a newly installed (or
otherwise reset) node into an existing cluster, manual action is required.

Following the procedures in the official docs are mostly sufficient, available
here:

`https://coreos.com/etcd/docs/latest/v2/runtime-configuration.html`

Keep the following in mind:

* Delete the old member from the cluster first, then add the new one.
* Make sure the etcd service is stopped and /var/lib/etcd is empty on the node you're bootstrapping
* Disable puppet agent until you're done
* The etcd commands for the node you're bootstrapping must be run as the etcd user.

Bootstrapping example (bgo-network-01)::

  etcd --listen-client-urls http://0.0.0.0:2379,http://127.0.0.1:4001 --advertise-client-urls http://172.18.0.71:2379 --listen-peer-urls http://0.0.0.0:2380 --initial-advertise-peer-urls http://172.18.0.71:2380 --data-dir /var/lib/etcd/bgo-network-01.etcd

After bootstrapping, stop etcd running in foreground, enable puppet and
initiate a puppetrun. This will start the etcd service, and you're good to go.
