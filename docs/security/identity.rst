.. |date| date::

(2019) Identity
===============

``REVISION 2019-02-21``

.. contents::

.. _OpenStack Security Guide\: Identity: http://docs.openstack.org/security-guide/identity.html

+-------------------------+---------------------+
| **Impact**              | High                |
+-------------------------+---------------------+
| **Implemented percent** | **88%** (16/18)     |
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

``[PASS]`` **Prevent or mitigate brute-force attacks**
  A pattern of repetitive failed login attempts is generally an
  indicator of brute-force attacks. This is important to us as ours is
  a public cloud. We need to figure out if our user authentication
  service has the possibility to block out an account after some
  configured number of failed login attempts. If not, describe
  policies around reviewing access control logs to identify and detect
  unauthorized attempts to access accounts.

  * Users are automatically banned from logging in after a number of
    authentication requests.


Multi-factor authentication
~~~~~~~~~~~~~~~~~~~~~~~~~~~

``[PASS]`` **Multi-factor authentication for privileged accounts**

  We should employ multi-factor authentication for network access to
  privileged user accounts. This will provide insulation from brute
  force, social engineering, and both spear and mass phishing attacks
  that may compromise administrator passwords.

  * While authentication to service accounts is possible from the
    "outside", administrative actions are not possible unless
    connecting from the "inside". In order to access the "inside",
    2-factor authentication is required.


Authentication methods
----------------------

.. _OpenStack Security Guide\: Identity - Authentication methods: http://docs.openstack.org/security-guide/identity/authentication-methods.html

Ref: `OpenStack Security Guide\: Identity - Authentication methods`_

``[N/A]`` **Document authentication policy requirements**
  We should document (or provide link to external documentation) the
  authentication policy requirements, such as password policy
  enforcement (password length, diversity, expiration etc.).

  * Regular users are set up after autentication through `Dataporten`. Their
    password are auto-generated and random, the logic used is currently only
    documented in code (github:nocams-himlar-db-prep).


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

``[N/A]`` **Describe formal access control policies**
  The policies should include the conditions and processes for
  creating, deleting, disabling, and enabling accounts, and for
  assigning privileges to the accounts.

  * We use an external authentication point

``[DEFERRED]`` **Describe periodic review**
  We should periodically review the policies to ensure that the
  configuration is in compliance with approved policies.

  * FIXME: Work in progress.


Service authorization
~~~~~~~~~~~~~~~~~~~~~

``[PASS]`` **Don't use "tempAuth" file for service auth**
  The Compute and Object Storage can be configured to use the Identity
  service to store authentication information. The "tempAuth" file
  method displays the password in plain text and should not be used.

  * ``tempAuth`` is not used.

``[FAIL]`` **Use client authentication for TLS**
  The Identity service supports client authentication for TLS which
  may be enabled. TLS client authentication provides an additional
  authentication factor, in addition to the user name and password,
  that provides greater reliability on user identification.

  * The negative implications for the user experience by implementing this
    is considered to outweight the extra security gained by this.

``[PASS]`` **Protect sensitive files**
  The cloud administrator should protect sensitive configuration files
  from unauthorized modification. This can be achieved with mandatory
  access control frameworks such as SELinux, including
  ``/etc/keystone/keystone.conf`` and ``X.509`` certificates.

  * SELinux is running in enforcing mode.


Administrative users
~~~~~~~~~~~~~~~~~~~~

  *We recommend that admin users authenticate using Identity service
  and an external authentication service that supports 2-factor
  authentication, such as a certificate. This reduces the risk from
  passwords that may be compromised. This recommendation is in
  compliance with NIST 800-53 IA-2(1) guidance in the use of
  multi-factor authentication for network access to privileged
  accounts.*

``[PASS]`` **Use 2-factor authentication for administrative access**
  Administrative access is provided via a login service that requires
  2-factor authentication.



Policies
--------

.. _OpenStack Security Guide\: Identity - Policies: http://docs.openstack.org/security-guide/identity/policies.html

Ref: `OpenStack Security Guide\: Identity - Policies`_

``[PASS]`` **Describe policy configuration management**
  Each OpenStack service defines the access policies for its resources
  in an associated policy file. A resource, for example, could be API
  access, the ability to attach to a volume, or to fire up
  instances. The policy rules are specified in JSON format and the
  file is called policy.json. Ensure that any changes to the access
  control policies do not unintentionally weaken the security of any
  resource.

  * We are using default policies, with overrides to disable certain
    capabilities.


Checklist
---------

.. _OpenStack Security Guide\: Identity - Checklist: http://docs.openstack.org/security-guide/identity/checklist.html

Ref: `OpenStack Security Guide\: Identity - Checklist`_

See the above link for info about these checks.

``[PASS]`` **Check-Identity-01: Is user/group ownership of config files set to keystone?**
  Ownership set to ``root:keystone`` or ``keystone:keystone``

``[PASS]`` **Check-Identity-02: Are strict permissions set for Identity configuration files?**
  Not all files in check list exists, the rest is OK

``[N/A]`` **Check-Identity-03: is TLS enabled for Identity?**
  Endpoint runs on the load balancer

``[PASS]`` **Check-Identity-04: Does Identity use strong hashing algorithms for PKI tokens?**
  Yes, set to ``bcrypt``

``[PASS]`` **Check-Identity-05: Is max_request_body_size set to default (114688)?**
  Yes

``[N/A]`` **Check-Identity-06: Disable admin token in /etc/keystone/keystone.conf**
  Enabled in keystone.conf, but the service itself is disabled.

``[PASS]`` **Check-Identity-07: insecure_debug false in /etc/keystone/keystone.conf**
  Yes

``[PASS]`` **Check-Identity-08: Use fernet token in /etc/keystone/keystone.conf**
  Yes
