.. |date| date::

=================
Generate CA files
=================

Last changed: |date|

.. WARNING::
   If you have problems with the CA: delete :file:`provision/ca`, check
   out all files tracked in git and rerun :file:`bootstrap.sh`

You will need to generate a CA key pair with openssl to sign the certificate
used in Vagrant to test TLS for endpoint. First make sure openssl is installed
on your host computer (if not, run the scipts and copy all the .pem files
back to your host)::


  cd $himlar
  cd provision/ca
  echo "YOUR_SECRET" > passfile
  ./bootstrap.sh

**NB! You must run the script from the provision/ca directory!**

The CA chain .pem file can be found in::

  $himlar/provision/ca/intermediate/certs/ca-chain.cert.pem

Use in puppet
=============

In puppet, this CA is used to generate certificates defined in the hash::

  profile::application::openssl::certs
