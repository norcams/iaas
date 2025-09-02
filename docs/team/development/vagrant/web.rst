.. |date| date::

====================================
Working with web services in Vagrant
====================================

Last changed: |date|

Here are some tips to working with the difference web services like
dashboard, access and API in Vagrant.

/etc/hosts
==========

You will need to update the :file:`/etc/hosts` on the machine where you
run your browser or API calls. Look in :file:`common.yaml` for the location
you are working with, and add all public address. Example for default nodeset::

  # vagrant frontend
  #192.168.0.250   access.iaas.intern
  #192.168.0.250   console.iaas.intern
  192.168.0.250   api.iaas.intern
  #192.168.0.250   report.iaas.intern
  #192.168.0.251   ns.iaas.intern
  #192.168.0.252   resolver.iaas.intern
  #192.168.0.254   dashboard.iaas.intern
  #192.168.0.250   status.iaas.intern
  # vagrant frontend 2
  192.168.0.250   access.vagrant.iaas.intern
  192.168.0.250   console.vagrant.iaas.intern
  192.168.0.250   api.vagrant.iaas.intern
  192.168.0.250   report.vagrant.iaas.intern
  192.168.0.251   ns.vagrant.iaas.intern
  192.168.0.252   resolver.vagrant.iaas.intern
  192.168.0.254   dashboard.vagrant.iaas.intern
  192.168.0.250   status.vagrant.iaas.intern
  # vagrant public
  192.168.0.250   compute.api.vagrant.iaas.intern
  192.168.0.250   network.api.vagrant.iaas.intern
  192.168.0.250   image.api.vagrant.iaas.intern
  192.168.0.250   identity.api.vagrant.iaas.intern
  192.168.0.250   volume.api.vagrant.iaas.intern
  192.168.0.250   metric.api.vagrant.iaas.intern
  192.168.0.250   object.api.vagrant.iaas.intern
  192.168.0.250   metric.trp.vagrant.iaas.intern
  192.168.0.250   placement.api.vagrant.iaas.intern
  192.168.0.250   rating.api.vagrant.iaas.intern
  192.168.0.250   dns.api.vagrant.iaas.intern
  # vagrant mgm
  172.31.0.10     login.mgmt.vagrant.iaas.intern
  172.31.0.11     foreman.mgmt.vagrant.iaas.intern
  172.31.0.13     logger.mgmt.vagrant.iaas.intern
  172.31.0.14     monitor.mgmt.vagrant.iaas.intern
  172.31.0.31     mq.mgmt.vagrant.iaas.intern
  172.31.0.96     metric.mgmt.vagrant.iaas.intern
  172.31.0.86     api.mgmt.vagrant.iaas.intern
  # vagrant trp
  172.31.8.81     identity.trp.vagrant.iaas.intern
  172.31.8.86     compute.trp.vagrant.iaas.intern
  172.31.8.86     network.trp.vagrant.iaas.intern
  172.31.8.86     placement.trp.vagrant.iaas.intern


The reason for also including::

  192.168.0.250   api.iaas.intern

is because the generated certificate is a wildcard certificate and will lead to an SSL error if OS_AUTH_URL in the openrc file for use by the Openstack client, is api.vagrant.iaas.intern. Instead, set it to api.iaas.intern

sshuttle
========

If you work on a remote Vagrant host you will need to have access to
Vagrants' public, trp and mgmt net. This can be done with sshuttle::

  sshuttle -r <remote host> 192.168.0.250/29 172.31.0.0/25 172.31.8.0/25

