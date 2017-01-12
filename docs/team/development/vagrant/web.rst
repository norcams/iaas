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
you are working with, and add all public address. Example for full nodeset::

  172.31.24.56    access.dev.iaas.intern
  172.31.24.51    dashboard.dev.iaas.intern
  172.31.24.51    status.dev.iaas.intern
  172.31.16.81    identity.trp.dev.iaas.intern
  172.31.24.86    api.dev.iaas.intern
  172.31.24.86    compute.api.dev.iaas.intern
  172.31.24.86    network.api.dev.iaas.intern
  172.31.24.86    image.api.dev.iaas.intern
  172.31.24.86    identity.api.dev.iaas.intern
  172.31.24.86    volume.api.dev.iaas.intern

sshuttle
========

If you work on a remote vagrant host you will need to have access to
vagrants public net. This can be done with sshuttle::

  sshuttle -r <remote host> 172.31.24.0/24
