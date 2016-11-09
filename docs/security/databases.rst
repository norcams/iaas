.. |date| date::

Databases
=========

Last changed: |date|

.. contents::

.. _OpenStack Security Guide\: Databases: http://docs.openstack.org/security-guide/databases.html

+-------------------------+---------------------+
| **Impact**              | High                |
+-------------------------+---------------------+
| **Implemented percent** | **44%** (4/9)        |
+-------------------------+---------------------+

From `OpenStack Security Guide\: Databases`_:

  *The choice of database server is an important consideration in the
  security of an OpenStack deployment. Multiple factors should be
  considered when deciding on a database server, however for the scope
  of this book only security considerations will be
  discussed. OpenStack supports a variety of database types (see
  OpenStack Cloud Administrator Guide for more information). The
  Security Guide currently focuses on PostgreSQL and MySQL.*

.. NOTE::
   We are using MariaDB 10.1 with packages directly from upstream repo.


Database back end considerations
--------------------------------

.. _OpenStack Security Guide\: Databases - Database back end considerations: http://docs.openstack.org/security-guide/databases/database-backend-considerations.html

Ref: `OpenStack Security Guide\: Databases - Database back end considerations`_

``[DEFERRED]`` **Evaluate existing MySQL security guidance**
  See link above for details.

  * FIXME: Evaluate and document


Database access control
-----------------------

.. _OpenStack Security Guide\: Databases - Database access control: http://docs.openstack.org/security-guide/databases/database-access-control.html

Ref: `OpenStack Security Guide\: Databases - Database access control`_

Database authentication and access control
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

From OpenStack Security Guide:

  *Given the risks around access to the database, we strongly recommend
  that unique database user accounts be created per node needing
  access to the database.*

``[PASS]`` **Unique database user accounts per node**
  Each service run on different host, and each host has a unique user.

``[PASS]`` **Separate database administrator account**
  The root user is only used to provision new databases and users.

``[DEFERRED]`` **Database administrator account is protected**
  FIXME: Document this

Require user accounts to require SSL transport
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``[DEFERRED]`` **The database user accounts are configured to require TLS**
  All databases support TLS, but only DB replication between location requires
  TLS.

Authentication with X.509 certificates
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``[DEFERRED]`` **The database user accounts are configured to require X.509 certificates**
  FIXME: Document this

Nova-conductor
~~~~~~~~~~~~~~

``[PASS]`` **Consider turning off nova-conductor**
  OpenStack Compute offers a sub-service called nova-conductor which
  proxies database connections over RPC.

  We use nova conductor, and nova compute have access to it over the message bus.
  The RPC messaging bus are not encrypted, but run on a private
  network. This is acceptable risk.

Database transport security
---------------------------

.. _OpenStack Security Guide\: Databases - Database transport security: http://docs.openstack.org/security-guide/databases/database-transport-security.html

Ref: `OpenStack Security Guide\: Databases - Database transport security`_

Database server IP address binding
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``[PASS]`` **Database access only over an isolated management network**
  Database replication is done over public network, with TLS and firewall to
  restrict access.


Database transport
~~~~~~~~~~~~~~~~~~

``[DEFERRED]`` **The database requires TLS**
  All databases support TLS transport, but only DB replication between
  locations requires TLS.
