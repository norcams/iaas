================
SSL certificates
================

Last changed: 2023-03-28


Generation
----------

Generation of CSR for :file:`*.iaas.uio.no` and self signed
certificates we use our own Root CA git repo on `login`::

  git@git.iaas.uib.no:ca_setup

This repo should also have all key, certs and config files for all certs in use.

For nrec.no, uhdc.no, uh-iaas.no and iaas.uib.no se :file:`/opt/public_certs` 
repo on login.

Naming conventions
------------------

========= ==========================================
 Type      Filename
========= ==========================================
cachain   /etc/pki/tls/certs/cachain.pem
key       /etc/pki/tls/private/<CNAME>.key.pem
cert      /etc/pki/tls/certs/<CNAME>.cert.pem
========= ==========================================

<CNAME> is the certificate CNAME.

Storage
-------

All three files should be stored on `login` under full path with root set at
:file:`/opt/repo/secrets/nodes/<HOSTNAME>/`

Distribution
------------

There is an `ansible <ansible/index.html>`_ playbook to push secrets to nodes
(see tasks.md for more info).
This requires that a YAML config file describes the files and mode.
Example of :file:`inventory/host_vars/bgo-db-01.yaml`::

  secret_files:
      cert:
        path:  '/etc/pki/tls/certs/db01.bgo.uhdc.no.cert.pem'
        mode:  '0644'
        owner: 'root'
        group: 'root'
      key:
        path:  '/etc/pki/tls/private/db01.bgo.uhdc.no.key.pem'
        mode:  '0644'
        owner: 'root'
        group: 'root'
      cafile:
        path:  '/etc/pki/tls/certs/cachain.pem'
        mode:  '0640'
        owner: 'root'
        group: 'mysql'
