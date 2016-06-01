.. |date| date::

=================
Generate CA files
=================

Last changed: |date|

You will need to generate a CA key pair with openssl to sign the certificate
used in vagrant to test TLS for endpoint. Fist make sure openssl in installed
on your host computer (if not run the scipts and copy alle the .pem files
back to your host)::

  cd $himlar
  cd provision/ca
  ./generate_ca.sh

**NB! You must run the script from the provision/ca directory!**

You should then have 3 .pem files::

  $himlar/provision/ca/certs/ca.cert.pem
  $himlar/provision/ca/certs/ca-chain.cert.pem
  $himlar/provision/ca/private/ca.key.pem

If you trust that no one will have access to your ca.key.pem file you could
add ca-chain.cert.pem to your browser to avoid warnings.


Distribute the files to the vagrant instance
============================================

For the nodes where this certificate is needed make sure its code includes::

  - profile::application::sslcert

The certificate and the key will be named after the FQDN of the host.
