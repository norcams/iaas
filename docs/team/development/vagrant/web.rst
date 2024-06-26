.. |date| date::

====================================
Working with web services in vagrant
====================================

Last changed: |date|

Here are some tips to working with the difference web services like
dashboard, access and API in vagrant.

/etc/hosts
==========

You will need to update the :file:`/etc/hosts` on the machine where you
run your browser or API calls. Look in :file:`common.yaml` for the location
you are working with, and add all public address. Example for default nodeset::

  # vagrant public
  192.168.0.252   access.vagrant.iaas.intern
  192.168.0.254   dashboard.vagrant.iaas.intern
  192.168.0.250   status.vagrant.iaas.intern
  192.168.0.250   api.iaas.intern
  192.168.0.250   compute.api.vagrant.iaas.intern
  192.168.0.250   network.api.vagrant.iaas.intern
  192.168.0.250   image.api.vagrant.iaas.intern
  192.168.0.250   identity.api.vagrant.iaas.intern
  192.168.0.250   volume.api.vagrant.iaas.intern
  192.168.0.250   console.vagrant.iaas.intern

  # vagrant trp
  172.31.8.81     identity.trp.vagrant.iaas.intern
  172.31.8.86     compute.trp.vagrant.iaas.intern
  172.31.8.86     network.trp.vagrant.iaas.intern

  # vagrant mgmt
  172.31.0.11     foreman.mgmt.vagrant.iaas.intern
  172.31.0.10     vagrant-login-01.mgmt.vagrant.iaas.intern

sshuttle
========

If you work on a remote vagrant host you will need to have access to
vagrants' public, trp and mgmt net. This can be done with sshuttle::

  sshuttle -r <remote host> 192.168.0.250/29 172.31.0.0/25 172.31.8.0/25

