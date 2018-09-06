=================
New identity node
=================

Install a new identity node by running :file:`$himlarcli/node.py`.

When the new node is ready, run :file:`$ansible/identity_node.sh`.

Log into api and restart haproxy.

Now, log into the master identity and check if the slave identity has also the same fernet keys.


First identity node (master)
============================
Log into proxy and install a new identity node by ruuning ::

  ./node.py install

From the master identity node, as a keystone user you can run::

  keystone-manage fernet_rotate

Generate a pgp key "/usr/local/sbin/create-gpg.sh"

Now you can push the key to db manually, or wait for a day and this will happens automatically.

In order to push the key manually, run the token script from the master identity node::

  /usr/local/sbin/token_dist.sh fernet

Log into api and restart haproxy.