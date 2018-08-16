uib-ha
======

In location `uib` we are running 4 nodes (2 test and 2 prod) with haproxy
and corosync/pacemaker.

These nodes run load balancing/HA for different UiB only services, but can
also be used for UH-IaaS services.

Access to the nodes are only available through bgo-login-01.

Deployment
----------

The cluster runs `himlar <https://github.com/norcams/himlar>`_ but without any admin node:

Deploy wit ansible::

  sudo ansible-playbook -e "myhosts=uib-ha-test" lib/deploy_himlar.yaml

Run puppet::

  cd /opt/himlar
  provision/puppetrun.sh

Management
----------

Some tips and tricks to manage the cluster (each cluster are two nodes).

Check status::

  pcs status

Set node in standby (for patching or booting)::

  pcs node standby <fqdn>

Set node back to online::

  pcs node unstandby <fqdn>
