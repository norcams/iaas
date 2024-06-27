=====================
Setup nodes and guest
=====================

The nodes in Vagrant should be started in stages. Each stage should complete
before the next one are started.

**First stage:**

  * db-global
  * db-regional
  * mq
  * api
  * dashboard (optional)
  * access (optional)
  * monitor (optional)
  * logger (optional)
  * proxy (optional)
  * admin (optional)

**Second stage:**

  * identity

**Main stage:**

  * novactrl
  * image
  * volume
  * network
  * console (optional)
  * metric (optional)
  * telemetry (optional)

**Last stage:**

  * compute


Tips: You may want to destroy all existing nodes and run vagrant box update prior to starting nodes. There is a script that automatically starts all nodes for you in the right order: himlar/provision/vagrant-allup.sh

See the below example using the default nodeset and some additional nodes (proxy and login):

Destroy::

  for vm in db-global db-regional mq api dashboard admin proxy identity novactrl image volume network compute login
  do
    vagrant destroy -f $vm
  done

Update::

  vagrant box update

Up::

  for vm in db-global db-regional mq api dashboard admin proxy identity novactrl image volume network compute login
  do
    vagrant up $vm
  done

Final fixes
===========

A few final stages are needed to start an instance in Vagrant.

Set host aggregate and availability zone
---------------------

After running vagrant up compute you will need to run vagrant provison novactrl
to add the newly created compute node to a host aggregate and the correct
availability zone (AZ).

Config login
------------

You may want to run ansible jobs from the login node within the Vagrant environment, or use it to access the proxy node for running openstack commands. You may config 2FA on login simlar to prod. Using existing file::

  [<username>@vagrant-login-01 ~]$ vim .google_authenticator
  # paste contents of existing file
  [<username>@vagrant-login-01 ~]$ chmod 400 .google_authenticator

or create new::

  vagrant ssh login
  sudo su - <username>
  google-authenticator

with the options specified in https://iaas.readthedocs.io/team/getting_started/two-factor-authentication.html#fa-on-jumphosts-login-nodes

Add to ~/.ssh/config on host::

 Host vagrant
    ControlMaster auto
    ControlPath ~/.ssh/controlmasters/%r@%h:%p
    ControlPersist yes
    ForwardAgent yes
    Hostname login.mgmt.vagrant.iaas.intern 

Installing necessary keys and fixing their permissions:

Create id_rsa and id_rsa.pub for root in vagrant-login-01:/root/.ssh

id_rsa has the contents of ~/.vagrant.d/insecure_private_keys/vagrant.key.rsa on the host machine.

id_rsa.pub has the contents of the rsa line in vagrant@vagrant-login-01:~/.ssh/authorized_keys

Can then sudo ssh from <username>@vagrant-login-01 to OpenStack components: sudo ssh vagrant@vagrant-proxy-01, etc.

For sudo ansible-playbook to work from vagrant-login-01:

Copy /root/.ssh/id_rsa to /root/.vagrant.d/insecure_private_key

chmod 600 in all private keys.

chmod 644 on all public keys.

Deploy himlarcli from login: See https://iaas.readthedocs.io/team/development/vagrant/deployment.html

Restart metadata API (from login)
--------------------------------

We need to restart openstack-nova-metadata-api on compute-01. This can be done with ansible::

  sudo ansible-playbook -e "myhosts=vagrant-compute-01" lib/restart_compute_services.yaml

himlarcli setup on guest to use the Vagrant environment
-------------------------------------------------------

Within himlarcli::

cp config.ini.example config.ini

Edit the [openstack] section (based on config.ini from proxy:/etc/himlarcli/config.ini)::

  [openstack]
  auth_url=https://api.iaas.intern:5000/v3
  username=admin
  password=admin_pass
  project_name=openstack
  default_domain=default
  region=vagrant
  domain=mgmt.vagrant.iaas.intern
  compute_api_version=2.79
  volume_api_version=3.50
  keystone_cachain=<himlar path>/provision/ca/intermediate/certs/ca-chain.cert.pem

Install dependencies (RHEL9)::

  sudo dnf install python3-virtualenv openldap-devel python-devel

Create virtualenv::

  virtualenv . -p /usr/bin/python
  source bin/activate
  pip install --upgrade pip
  # this is needed to install foreman module
  pip install autosemver
  python setup.py develop
  pip install -r requirements.txt

Add to /etc/hosts on guest:

See the next page.

Add flavors
-----------

Flavors are missing. m1 can be added with :file:`himlarcli/flavor.py` or openstack cli::

  ./flavor.py update m1

Add test image
--------------

You will need a public cirros image to test with. One way to quickly fix this are to
use :file:`himlarcli/image.py` and then just run::

  ./image.py update -i vagrant.yaml

This will add a test image called "CirrOS vagrant image"

This will not set an owner to the image, which may cause and error in the dashboard when viewing images.

Fix: Set the openstack project as owner for the image:

openstack project list to find the ID for the project "openstack", for instance 8c8797024bc24587aa9b8052c293d18f

then::

  openstack image set --property owner=8c8797024bc24587aa9b8052c293d18f 'CirrOS vagrant image'

Alternatively, the CirrOS image can be uploaded like the following, which correctly sets the owner to 'openstack':

at [root@vagrant-proxy-01 ~(keystone_vagrant_admin)]$::

  wget http://download.cirros-cloud.net/0.3.4/cirros-0.3.4-x86_64-disk.img
  openstack image create --file cirros-0.3.4-x86_64-disk.img test

Horizon config and login
------------------------

Install NREC dev Intermediate CA as Authority in Chrome:

If you trust that no one will have access to your passfile, you could
add :file:`$himlar/provision/ca/intermediate/certs/intermediate.cert.pem`
to your browser to avoid warnings. 

For Chrome, this is done by:

Privacy and security -> Security -> Manage certificates -> Authorities -> Import

Select the intermediate.cert.pem file, then tick off all boxes.

Access dashboard at https://dashboard.iaas.intern

Authenticate using: Keystone Credentials

User Name: admin

Password: admin_pass

Dataporten
----------

`See more about setting up dataporten in vagrant <dataporten.html>`_

After running destroy/up only himlarcli/dataporten.py will be needed.

To create a dataporten user in Vagrant after setting dashboard up, we can use
:file:`himlarcli/access.py` to add a user request to the queue and process the
request and add the user.
