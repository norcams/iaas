====
ETCD
====

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
