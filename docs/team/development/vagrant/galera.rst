=================
Galera DB cluster
=================

Some tips for setting up galera in vagrant:

Setup
-----

.. WARNING::
   If you have running :file:`db-global` or :file:`db-regional` nodes these must
   be halted or destroyed first!

* use :file:`db` nodeset
* you will need 3 nodes: :file:`db-global-01`, :file:`db-global-02`,
  :file:`ha-01`
* Start first  :file:`db-global-01`
* Uncomment the marked hieradata::

    hieradata/nodes/vagrant/vagrant-db-global-01.yaml
    hieradata/nodes/vagrant/vagrant-db-global-02.yaml
    hieradata/nodes/vagrant/vagrant-ha-01.yaml
    hieradata/vagrant/roles/db-global.yaml

* Provision :file:`db-global-01` (will fail) and run :file:`galera_new_cluster`
  to start database service and run provision once more with errors
* Start :file:`ha-01` and make sure :file:`garbd` is running. You should now have
  a size 2 cluster (see below)
* Start :file:`db-global-01` and start :file:`mariadb.service`.


Check status
------------

Check the current galera cluster status. If everything is working you
should have a size 3 cluster::

  SHOW GLOBAL STATUS LIKE 'wsrep_cluster_%';
