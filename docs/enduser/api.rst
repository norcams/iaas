.. |date| date::

OpenStack API
=============

Last changed: |date|

.. contents::

You will get a password when you do the initial first login
(see :doc:`login`). Please make sure you write this down for later
user. If you where an early adopter or forgot your password please contact us.

OpenStack cli
-------------

After you receive your password for API access you can use the OpenStack
command line client (OpenStack cli) to test the access.

Create a ::file:`keystone_rc.sh` file:

.. code::

  export OS_USERNAME=<email>
  export OS_TENANT_NAME=<email>
  export OS_PASSWORD=<password>
  export OS_AUTH_URL=https://api.uh-iaas.no:5000/v3
  export OS_IDENTITY_API_VERSION=3
  export OS_USER_DOMAIN_NAME=dataporten
  export OS_PROJECT_DOMAIN_NAME=dataporten
  export OS_REGION_NAME=bgo|osl
  export OS_NO_CACHE=1

Make sure *<email>* is the same as the one used by FEIDE.

Install the openstack cli for your system. More help on `Installing the Openstack cli
<http://docs.openstack.org/cli-reference/common/cli_install_openstack_command_line_clients.html>`_

.. code::

  source keystone_rc.sh
  openstack server list

Read more about the openstack cli at http://docs.openstack.org/cli-reference/
