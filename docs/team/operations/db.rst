==
DB
==


Galera management
=================

The galera cluster consist of three nodes:

* bgo-db-01
* osl-db-01
* uib-ha-02 (quorum node only)

To check the current status as root on db-01::

   mysql
   SHOW STATUS LIKE 'wsrep_cluster_size';

Cluster size must be 2 or greater.

Start stop quorum node
----------------------

From bgo-login-01::

  sudo ssh iaas@uib-ha-02
  sudo -i
  systemctl status garbd

  systemctl stop garbd
  systemctl start garbd

Bootstrap cluster
-----------------
You will need to bootstrap the cluster if systemctl start mysqld fails on bgo-db-01
for some reason.

.. WARNING::
  If there are new data on osl-db-01 this will be lost unless we have a db dump
  and restore it on bgo-db-01 after mysqld have been started.

First stop mysqld on db-01 and garbd on uib-ha-02.

On bgo-db-01 edit /var/lib/mysql/grastate.dat and make sure::

  safe_to_bootstrap: 1

Bootstrap cluster on bgo-db-01:

  galera_new_cluster

Verify that mysqld are running and do a restore if necessary::

  systemctl status mysqld

Start mysqld on osl-db-01 and garbd på uib-ha-02

Verify cluster size are now 3.


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
