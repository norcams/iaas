.. |date| date::

========
Identity
========

Last changed: |date|

.. contents::
.. section-numbering::

.. _OpenStack Security Guide\: Identity: http://docs.openstack.org/security-guide/identity.html

+-------------------------+---------------------+
| **Impact**              | High                |
+-------------------------+---------------------+
| **Implemented percent** | **0%** (0/?)        |
+-------------------------+---------------------+

From `OpenStack Security Guide\: Identity`_:

  *Identity service (keystone) provides identity, token, catalog, and
  policy services for use specifically by services in the OpenStack
  family. Identity service is organized as a group of internal
  services exposed on one or many endpoints. Many of these services
  are used in a combined fashion by the frontend, for example an
  authenticate call will validate user/project credentials with the
  identity service and, upon success, create and return a token with
  the token service.*


Authentication
--------------

.. _OpenStack Security Guide\: Identity - Authentication: http://docs.openstack.org/security-guide/identity/authentication.html

Ref: `OpenStack Security Guide\: Identity - Authentication`_

Invalid login attempts
~~~~~~~~~~~~~~~~~~~~~~

``[----]`` **Prevent or mitigate brute-force attacks**
  A pattern of repetitive failed login attempts is generally an
  indicator of brute-force attacks. This is important to us as ours is
  a public cloud. We need to figure out if our user authentication
  service has the possibility to block out an account after some
  configured number of failed login attempts. If not, describe
  policies around reviewing access control logs to identify and detect
  unauthorized attempts to access accounts.

  * FIXME: Implement or describe as outlined above

Multi-factor authentication
~~~~~~~~~~~~~~~~~~~~~~~~~~~

``[----]`` **Multi-factor authentication for privileged accounts**

  We should employ multi-factor authentication for network access to
  privileged user accounts. This will provide insulation from brute
  force, social engineering, and both spear and mass phishing attacks
  that may compromise administrator passwords.

  * FIXME: Implement multi-factor


Authentication methods
----------------------

.. _OpenStack Security Guide\: Identity - Authentication methods: http://docs.openstack.org/security-guide/identity/authentication-methods.html

Ref: `OpenStack Security Guide\: Identity - Authentication methods`_

``[----]`` **Document authentication policy requirements**
  We should document (or provide link to external documentation) the
  authentication policy requirements, such as password policy
  enforcement (password length, diversity, expiration etc.).

  * FIXME: Document this


Authorization
-------------

.. _OpenStack Security Guide\: Identity - Authorization: http://docs.openstack.org/security-guide/identity/authorization.html

Ref: `OpenStack Security Guide\: Identity - Authorization`_

  *The Identity service supports the notion of groups and roles. Users
  belong to groups while a group has a list of roles. OpenStack
  services reference the roles of the user attempting to access the
  service. The OpenStack policy enforcer middleware takes into
  consideration the policy rule associated with each resource then the
  user’s group/roles and association to determine if access is allowed
  to the requested resource.*

Establish formal access control policies
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``[----]`` **Describe formal access control policies**
  The policies should include the conditions and processes for
  creating, deleting, disabling, and enabling accounts, and for
  assigning privileges to the accounts.

  * FIXME: Describe this

``[----]`` **Describe periodic review**
  We should periodically review the policies to ensure that the
  configuration is in compliance with approved policies.

  * FIXME: Describe policy for reviewing the policies

Service authorization
~~~~~~~~~~~~~~~~~~~~~

``[----]`` **Don't use "tempAuth" file for service auth**
  The Compute and Object Storage can be configured to use the Identity
  service to store authentication information. The "tempAuth" file
  method displays the password in plain text and should not be used.

  * FIXME: Make sure that we're not using "tempAuth"

``[----]`` **Use client authentication for TLS**
  The Identity service supports client authentication for TLS which
  may be enabled. TLS client authentication provides an additional
  authentication factor, in addition to the user name and password,
  that provides greater reliability on user identification.

  * FIXME: Is this implemented?

``[----]`` **Protect sensitive files**
  The cloud administrator should protect sensitive configuration files
  from unauthorized modification. This can be achieved with mandatory
  access control frameworks such as SELinux, including
  ``/etc/keystone/keystone.conf`` and ``X.509`` certificates.

  * FIXME: SELinux


Policies
--------

.. _OpenStack Security Guide\: Identity - Policies: http://docs.openstack.org/security-guide/identity/policies.html

Ref: `OpenStack Security Guide\: Identity - Policies`_

``[----]`` **Describe policy configuration management**
  Each OpenStack service defines the access policies for its resources
  in an associated policy file. A resource, for example, could be API
  access, the ability to attach to a volume, or to fire up
  instances. The policy rules are specified in JSON format and the
  file is called policy.json. Ensure that any changes to the access
  control policies do not unintentionally weaken the security of any
  resource.

  * FIXME: Describe policy for changing policy.json


Tokens
------

.. _OpenStack Security Guide\: Identity - Tokens: http://docs.openstack.org/security-guide/identity/tokens.html

Ref: `OpenStack Security Guide\: Identity - Tokens`_

  *Once a user is authenticated a token is generated for authorization
  and access to an OpenStack environment. A token can have a variable
  life span; however the default value for expiry is one hour. The
  recommended expiry value should be set to a lower value that allows
  enough time for internal services to complete tasks.*

``[----]`` **Reduce token lifetime**
  We should consider reducing the token lifetime.

  * FIXME: Consider this


Checklist
---------

.. _OpenStack Security Guide\: Identity - Checklist: http://docs.openstack.org/security-guide/identity/checklist.html

Ref: `OpenStack Security Guide\: Identity - Checklist`_

See the above link for info about these checks.

``[----]`` **Check-Identity-02: Are strict permissions set for Identity configuration files?**
  Yes/No?

``[----]`` **Check-Identity-03: is TLS enabled for Identity?**
  Yes/No?

``[----]`` **Check-Identity-04: Does Identity use strong hashing algorithms for PKI tokens?**
  Yes/No?

``[----]`` **Check-Identity-05: Is max_request_body_size set to default (114688)?**
  Yes/No?

``[----]`` **Check-Identity-06: Disable admin token in /etc/keystone/keystone.conf**
  Yes/No?
