================================
Setting up dataporten in vagrant
================================

First make sure that the `access`-node is part of your :file:`HIMLAR_NODESET`.
There should be at least one nodeset with `access` in :file:`nodes.yaml`.

To use Dataporten to authenticate user in `access` and `keystone` you
will first need to set up to two applications at https://dashboard.dataporten.no

More help can be found at https://docs.dataporten.no/

You need to add the following scope in permissions for each application::

  email
  userid-feide
  profile
  openid

Redirect uri from `access` should be::

  https://access.himlar.local/login

and for `master`::

  https://dashboard.himlar.local:5000/v3/auth/OS-FEDERATION/websso/oidc/redirect

Also make sure `dashboard.himlar.local` and `access.himlar.local` is your
vagrant hosts :file:`/etc/hosts`

Then copy `Client ID` and `Client Secret` from `Oauth details` to::

  hieradata/secrets/nodes/vagrant-access-01.secrets.yaml
  hieradata/secrets/nodes/vagrant-master-01.secrets.yaml

To setup `master` to allow Dataporten login in `horizon` run this provision
script once on the master as root::

 /opt/himlar/provision/dataporten/setup_master.sh
