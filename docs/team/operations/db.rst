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

Resetting the Quorum
--------------------

If one of the nodes in the cluster have :file:`wsrep_cluster_status` non-Primary
we will need to reset the quorum. Read more on how to fix this:

http://galeracluster.com/documentation-webpages/quorumreset.html

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
