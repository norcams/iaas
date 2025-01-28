====
ETCD
====

Maintenance
===========

Tips for retention compaction and defrag of datastore. Max size for the datastore
is default 2 GB. 

https://etcd.io/docs/v3.2/op-guide/maintenance/

How to fix etcd cluster
=======================

The etcd cluster needs to be reconfigured from time to time, and typically if a
network node is reinstalled. In order to include a newly installed (or
otherwise reset) node into an existing cluster, some action is required.

With Ansible
============

There's an Ansible playbook available that automates all the steps required to
bring a reinstalled node back into the cluster. Check the following before you
run it:

* The node must be fully provisioned by Puppet after reinstall. etcd will fail,
  which is why we have this playbook, but the node must otherwise be properly
  installed.
* The node needs a script that we deploy with Puppet located in
  /usr/local/sbin/bootstrap-etcd-member
* There should be no empty variables in the script. If there are, check for
  missing hieradata.

The playbook needs two variables:

* 'member' is the hostname of the node we're bringing back into the cluster.
* 'manage_from' is the hostname of another node in a functioning cluster where
  we delete the old member and re-add the newly installed one.

The playbook will figure out the rest.

This example re-adds bgo-network-02 into the cluster, managed from bgo-network-01::

  sudo ansible-playbook -e 'member=bgo-network-02 manage_from=bgo-network-01' lib/reconfigure_etcd_cluster.yaml

If successful, all tasks should run without errors **except** 'TASK [Bootstrap
member]' **which is supposed to fail**. This task runs etcd in the foreground
asynchronously, which is needed for bootstrapping, and exits after 30 seconds.
Then it runs Puppet, which will start etcd as a systemd service.

Expanding from a single-node cluster
------------------------------------

The above playbook will bring back a reinstalled node into an already existing
multi-node cluster, however, expanding from a single-node cluster into a
multi-node one requires a slightly different procedure.

First, the initial-cluster parameter must contain all the nodes present when
bootstrapping, This is configured by Puppet, including the script we use for
bootstrapping. Expand the cluster node by node; starting with the initial
single node cluster, add a second node in the configuration, then use the
Ansible playbook called expand_etcd_cluster::

  sudo ansible-playbook -e 'member=bgo-network-02 manage_from=bgo-network-01 member_ip=172.18.0.72' lib/expand_etcd_cluster.yaml

We need to provide the IP address of the new member since we cannot fetch it
from etcdctl. 

If successful, all tasks should run without errors **except** 'TASK [Bootstrap
member]' **which is supposed to fail**. This task runs etcd in the foreground
asynchronously, which is needed for bootstrapping, and exits after 30 seconds.
Then it runs Puppet, which will start etcd as a systemd service.

Check the etcd cluster by running the following command on one of the nodes::

  etcdctl cluster-health

which should report both nodes being healthy.

Then proceed with the next node.

Fix compute nodes after etcd outage
===================================

If the etcd cluster running on the network nodes has been unresponsive for an
extended period of time, the following services need to be restarted on
compute, after verifying that the cluster is healthy::

  etcd
  etcd-grpc-proxy
  calico-dhcp-agent
  calico-felix
  openstack-nova-compute
  openstack-nova-metadata-api  

We have an Ansible playbook for this task::

  sudo ansible-playbook -e 'myhosts=bgo-compute' lib/restart_etcd_compute.yaml <- Fix!

Manually
========

If Ansible fails for some reason you can try to do the procedure manually.

Following the official docs are usually sufficient, available here:

`https://coreos.com/etcd/docs/latest/v2/runtime-configuration.html`

Keep the following in mind:

* Delete the old member from the cluster first, then add the new one.
* When you add the new member, etcdctl returns three environment variables you must set **on the node you're bootstrapping**
* Make sure the etcd service is stopped and /var/lib/etcd is empty on the node you're bootstrapping
* Disable puppet agent until you're done
* The etcd commands for the node you're bootstrapping must be run as the etcd user.

Bootstrapping example (bgo-network-01)::

  etcd --listen-client-urls http://0.0.0.0:2379,http://127.0.0.1:4001 --advertise-client-urls http://172.18.0.71:2379 --listen-peer-urls http://0.0.0.0:2380 --initial-advertise-peer-urls http://172.18.0.71:2380 --data-dir /var/lib/etcd/bgo-network-01.etcd

After bootstrapping, stop etcd running in foreground, enable puppet and
initiate a puppetrun. This will start the etcd service, and you're good to go.
