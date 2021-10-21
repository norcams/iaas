===================
Identity and tokens
===================

Keystone has an extensive use of tokens (`Read the Openstack documentation for
more details <https://docs.openstack.org/keystone/rocky/admin/identity-tokens.html>`_ ).
The identity nodes have to share the same set of tokens to make this all work as
expected. One of the nodes is responsible for rotating the tokens at regular
intervals, and then distribute them to the other participtaing nodes. This
rotation is done to make sure the tokens are fresh, and do not linger around for
an extended time. For reliable distribution through regions (in circumstances where an environment
consists of several regions), the database cluster is used. The tokens are
encrypted with a shared GPG key for security reasons.

Each identity host run a script once a day in order to share these tokens. The
master nodes stores the tokens in the database through this script, while the
slaves all retrieves them. The script refuses to activate any tokens if the
number of available ones are below a specific threshold. At the time of writing
this is defined as **3**. As the initial installation only provide two of each
kind, special consideration has to be taken to bootstrap the keystone
environment in the situation where a new master node is set up.

.. NOTE::
   Since the token rotation and the sync between nodes are not synchronized,
   this leads to the situation where the current token on the nodes are not the
   same. For this reason *keystone* accepts tokens a couple of generations back
   in addition to the most current.


Token storage
=============

Local storage (identity nodes)
------------------------------

**/etc/keystone/credential-keys**

**/etc/keystone/fernet/keys**


Distribution
------------

:DB environment:
  global

:Database:
  token-keys

:Database user:
  keystone

:Tables:
  credentials

  fernet


Bootstrap
=========

Masters
-------

When any master nodes have been provisioned, there are only two tokens of each
kind. This number is below the sanity check threshold, and thus the distribution
logic halts the procedure. The effect of which is that no tokens are seen on any
of the slave nodes in the environment.

Initial bootstrap procedure
"""""""""""""""""""""""""""

Choose **one** of these methods:

- wait until the next day when the rotation job has secured a third token
- manually run the rotation job (must be run as the ``keystone`` user):

  [root@master ] sudo -u keystone keystone-manage fernet_rotate

  This job should be run on the master only!


Slaves
------

The slaves contains two tokens as well when provisioned. In addition to be below
the threshold, these tokens are not valid. To initialize the slave properly, the
node must be configured to retrieve tokens stored into the database cluster by
the master node. The cron jobs to do this every night should already be set up
by the installation routine, but to be able to decrypt the stored data, the node
must have hold of the proper GPG key. To push the key and also trigger an
initial run of the retrieval jobs, there is an ansible job defined. So after
installation of the slave identity node, simply run::

  [root@master ] sudo ansible-playbook -e "myhosts=<identity host>" lib/setup_identity.yaml

This job basically ...

1. push secrets, including the GPG key necessary to decrypt
2. run puppet
3. trigger the retrieval jobs

.. NOTE::
   This ansible job only have an effect on SLAVES! Do not run on master nodes.

tokens,
