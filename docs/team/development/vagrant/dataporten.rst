================================
Setting up dataporten in vagrant
================================

First make sure that the `access`-node is part of your :file:`HIMLAR_NODESET`.
There should be at least one nodeset with `access` in :file:`nodes.yaml`.

To use Dataporten to authenticate a user in `access` and `keystone`, you
will first need to set up two applications at https://dashboard.dataporten.no

More help can be found at https://docs.dataporten.no/


Login to Dataporten Dashboard, and register new application.

Redirect uri from `access` should be::

  https://access.vagrant.iaas.intern/login

and for `master`::

  https://dashboard.vagrant.iaas.intern/login
  
You need to add the following scope in `Permissions` for each application::

  email
  userid-feide
  profile
  openid

Also make sure `dashboard.himlar.local` and `access.himlar.local` are in
:file:`/etc/hosts` on the machine you are running your browser.

Then copy `Client ID` and `Client Secret` from `Oauth details` to::

  hieradata/secrets/nodes/vagrant-access-01.secrets.yaml
  hieradata/secrets/nodes/vagrant-identity-01.secrets.yaml

Reference hieradata/secrets/nodes on the other locations for exact content.

To allow `Dataporten` login in `horizon`, run the dataporten
script once in himlarcli as root::

 ./dataporten.py
