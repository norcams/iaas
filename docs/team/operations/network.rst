=======================
Network node management
=======================

Network node reinstall
======================

With Ansible
------------

To reinstall a network host with `ansible <ansible/index.html>`_ run::

  cd <ansible-repo>
  bin/rebuild_network_node.sh <node> <manage from>

Where <node> is the node you wish to reinstall and <manage from> is another
network node who's member of a common etcd cluster.

If this does not succeed the most likely cause is that there are issues in one
of the initial puppetruns.

Testing
-------

Run::

  etcdctl cluster-health

on one of the network nodes, everything should be OK here.
