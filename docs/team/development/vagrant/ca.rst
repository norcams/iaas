.. |date| date::

=================
Generate CA files
=================

Last changed: |date|

.. WARNING::
   If you have problems with the CA: delete :file:`provision/ca`, check
   out all files tracked in git and rerun :file:`bootstrap.sh`

You will need to generate a CA key pair with openssl to sign the certificate
used in vagrant to test TLS for endpoint. Fist make sure openssl in installed
on your host computer (if not run the scipts and copy alle the .pem files
back to your host)::


  cd $himlar
  cd provision/ca
  echo "YOUR SECRET" > passfile
  ./bootstrap.sh

**NB! You must run the script from the provision/ca directory!**

The CA chain .pem file can be found in::

  $himlar/provision/ca/certs/intermediate/ca-chain.cert.pem

If you trust that no one will have access to your passfile you could
add :file:`$himlar/provision/ca/certs/intermediate/intermediate.cert.pem`
to your browser to avoid warnings.

Use in puppet
=============

In puppet this CA is used to generate certificates defined in the hash::

  profile::application::openssl::certs
