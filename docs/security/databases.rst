.. |date| date::

Databases
=========

Last changed: |date|

.. contents::

.. _OpenStack Security Guide\: Databases: http://docs.openstack.org/security-guide/databases.html

+-------------------------+---------------------+
| **Impact**              | High                |
+-------------------------+---------------------+
| **Implemented percent** | **0%** (0/?)        |
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
   We are using MySQL.


Database back end considerations
--------------------------------

.. _OpenStack Security Guide\: Databases - Database back end considerations: http://docs.openstack.org/security-guide/databases/database-backend-considerations.html

Ref: `OpenStack Security Guide\: Databases - Database back end considerations`_

``[----]`` **Evaluate existing MySQL security guidance**
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

``[----]`` **Unique database user accounts per node**
  FIXME: Document this

``[----]`` **Separate database administrator account**
  FIXME: Document this

``[----]`` **Database administrator account is protected**
  FIXME: Document this

Require user accounts to require SSL transport
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``[----]`` **The database user accounts are configured to require TLS**
  FIXME: Document this

Authentication with X.509 certificates
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``[----]`` **The database user accounts are configured to require X.509 certificates**
  FIXME: Document this

Nova-conductor
~~~~~~~~~~~~~~

``[----]`` **Document how Nova-conductor is used**
  FIXME: Are we using Nova-conductor?


Database transport security
---------------------------

.. _OpenStack Security Guide\: Databases - Database transport security: http://docs.openstack.org/security-guide/databases/database-transport-security.html

Ref: `OpenStack Security Guide\: Databases - Database transport security`_

Database server IP address binding
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``[----]`` **Database access only over an isolated management network**
  FIXME: Document this

Database transport
~~~~~~~~~~~~~~~~~~

``[----]`` **The database requires TLS**
  FIXME: Document this
