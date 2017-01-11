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
