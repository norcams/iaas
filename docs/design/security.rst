.. |date| date::

======================
Security concerns
======================

Last changed: |date|

.. contents::
.. section-numbering::


Introduction
============

.. _OpenStack Security Guide: http://docs.openstack.org/security-guide/

This document is an attempt to write up all the security measures that
can, will or should be implemented. The basis is the `OpenStack
Security Guide`_ on openstack.org. We use the sections in the security
guide, and try to answer the following questions:

#. Is this security measure implemented? and if not:
#. What are the potential security impact?
#. Other concerns?
#. Should this be implemented?

For each recommendation, there is at least one check that can have one
of four different values:

* ``[PASS]`` This check has been passed
* ``[FAIL]`` This check is failed
* ``[----]`` This check has not been considered yet
* ``[DEFERRED]`` This check has been postponed or does not apply


System documentation
====================

+-------------------------+---------------------+
| **Impact**              | Low                 |
+-------------------------+---------------------+
| **Implemented percent** | **0%** (0/4)        |
+-------------------------+---------------------+

System Inventory
----------------

From `OpenStack Security Guide`_:

  *Documentation should provide a general description of the OpenStack
  environment and cover all systems used (production, development,
  test, etc.). Documenting system components, networks, services, and
  software often provides the bird’s-eye view needed to thoroughly
  cover and consider security concerns, attack vectors and possible
  security domain bridging points. A system inventory may need to
  capture ephemeral resources such as virtual machines or virtual disk
  volumes that would otherwise be persistent resources in a
  traditional IT system.*

The UH-IaaS infrastructure is, from hardware and up, managed
completely by the UH-IaaS group, and therefore independent of each
institution. Except for networking interface and physical hardware
management, there are no dependencies on the institutions. Links to
infrastructure documentation:

``[----]`` **Hardware inventory**
  FIXME

``[----]`` **Software inventory**
  FIXME

``[----]`` **Network topology**
  FIXME

``[----]`` **Services, protocols and ports**
  FIXME


Management
==========

+-------------------------+---------------------+
| **Impact**              | Medium              |
+-------------------------+---------------------+
| **Implemented percent** | **0%** (0/4)        |
+-------------------------+---------------------+

Continuous systems management
-----------------------------

From `OpenStack Security Guide`_:

  *A cloud will always have bugs. Some of these will be security
  problems. For this reason, it is critically important to be prepared
  to apply security updates and general software updates. This
  involves smart use of configuration management tools, which are
  discussed below. This also involves knowing when an upgrade is
  necessary.*

Vulnerability management
~~~~~~~~~~~~~~~~~~~~~~~~

.. _OpenStack Announce mailing list: http://lists.openstack.org/cgi-bin/mailman/listinfo/openstack-announce

Updates are announced on the `OpenStack Announce mailing list`_.

FIXME: Are we subscribed to this list?

FIXME: Are we subscribed to similar list pertaining to the repo/distro
used?

``[----]`` **Triage**
  When we are notified of a security update, this is discussed at the
  next morning meeting. We will then decide the impact of the update
  to our environment, and take proper action.

  * FIXME: Make this a policy.

``[----]`` **Testing the updates**
  We have test clouds in each location (currently OSL and BGO) which
  in most respects are identical to the production clouds. This allows
  for easy testing of updates.

  * FIXME: Make this a policy.
  * FIXME: OSL test cloud isn't ready yet.

``[----]`` **Deploying the updates**
  When testing is completed and the update is verified, and we are
  satisfied with any performance impact, stability, application impact
  etc., the update is deployed in production. This is done
  automatically via the following procedure:

  * FIXME: Automatic update procedure?

Configuration management
~~~~~~~~~~~~~~~~~~~~~~~~

FIXME: Describe automated configuration and deployment, or add links.

``[----]`` **changes**
  FIXME: How are policy changes tracked?

Secure backup and recovery
~~~~~~~~~~~~~~~~~~~~~~~~~~

If we at some point decide to take backup of the infrastructure or
instances, we should include the backup procedures and policies in the
overall security plan.

``[PASS]`` **Backup procedure and policy**
  We do not take backup of anything (yet).

Security auditing tools
~~~~~~~~~~~~~~~~~~~~~~~

.. _SCAP: https://fedorahosted.org/scap-security-guide/

We should consider using SCAP_ or similar security auditing tools in
combination with configuration management.

``[----]`` **Decide whether or not to use security auditing tools**
  FIXME: Need to decide


Integrity life-cycle
--------------------

From `OpenStack Security Guide`_:

  *We define integrity life cycle as a deliberate process that provides
  assurance that we are always running the expected software with the
  expected configurations throughout the cloud. This process begins
  with secure bootstrapping and is maintained through configuration
  management and security monitoring.*

Secure bootstrapping
~~~~~~~~~~~~~~~~~~~~

The Security Guide recommends having an automated provisioning process
for all nodes in the cloud. This includes compute, storage, network,
service and hybrid nodes. The automated provisioning process also
facilitates security patching, upgrades, bug fixes, and other critical
changes. Software that runs with the highest privilege levels in the
cloud needs special attention.

``[PASS]`` **Node provisioning**
  We use PXE for provisioning, which is recommended. We also use a
  separate, isolated network within the management security domain for
  provisioning. The provisioning process is handled by Foreman with
  Puppet, and is documented here: FIXME

``[----]`` **Verified boot**
  It is recommended to use *secure boot* via TPM chip to boot the
  infrastructure nodes in the cloud.

  * FIXME: Consider secure boot

``[----]`` **Node hardening**
  General hardening of the operating system is something that we need
  to address and document.

  * FIXME: Document hardening

Runtime verification
~~~~~~~~~~~~~~~~~~~~

From `OpenStack Security Guide`_:

  *Once the node is running, we need to ensure that it remains in a
  good state over time. Broadly speaking, this includes both
  configuration management and security monitoring. The goals for each
  of these areas are different. By checking both, we achieve higher
  assurance that the system is operating as desired.*

``[----]`` **Intrusion detection system**
  There are a number of intrusion detection systems available. We need
  to consider using one of them.

  * FIXME: Consider IDS

Server hardening
~~~~~~~~~~~~~~~~

This mostly includes file integrity management.

``[----]`` **File integrity management (FIM)**
  We should consider a FIM tool to ensure that files such as sensitive
  system or application configuration files are no corrupted or
  changed to allow unauthorized access or malicious behaviour.

  * FIXME: Consider FIM


Management interfaces
---------------------

From `OpenStack Security Guide`_:

  *It is necessary for administrators to perform command and control
  over the cloud for various operational functions. It is important
  these command and control facilities are understood and secured.*

  *OpenStack provides several management interfaces for operators and tenants:*

  * *OpenStack dashboard (horizon)*
  * *OpenStack API*
  * *Secure shell (SSH)*
  * *OpenStack management utilities such as nova-manage and glance-manage*
  * *Out-of-band management interfaces, such as IPMI*

Dashboard
~~~~~~~~~

``[----]`` **Capabilities**
  We should consider which capabilities the dashboard should offer to
  customers and administrators.

  * FIXME: Consider capabilities and document decisions

``[----]`` **Security considerations**
  There are a few things that need to be considered (from `OpenStack
  Security Guide`_):

  * The dashboard requires cookies and JavaScript to be enabled in the
    web browser.
    - FIXME: Users should be warned according to EU law.
  * The web server that hosts the dashboard should be configured for
    TLS to ensure data is encrypted.
    - FIXME: Ensure TLS 1.2
  * Both the horizon web service and the OpenStack API it uses to
    communicate with the back end are susceptible to web attack
    vectors such as denial of service and must be monitored.
    - FIXME: Monitoring
  * It is now possible (though there are numerous deployment/security
    implications) to upload an image file directly from a user’s hard
    disk to OpenStack Image service through the dashboard. For
    multi-gigabyte images it is still strongly recommended that the
    upload be done using the glance CLI.
    - FIXME: Add limit to GUI uploading?
  * Create and manage security groups through dashboard. The security
    groups allows L3-L4 packet filtering for security policies to
    protect virtual machines.
    - FIXME: Maintain a set of default security groups

OpenStack API
~~~~~~~~~~~~~

``[----]`` **Capabilities**
  We should consider which capabilities the OpenStack API should offer to
  customers and administrators.

  * FIXME: Consider capabilities and document decisions

``[----]`` **Security considerations**
  There are a few things that need to be considered (from `OpenStack
  Security Guide`_):

  * The API service should be configured for TLS to ensure data is
    encrypted.
    - FIXME: Ensure TLS 1.2
  * As a web service, OpenStack API is susceptible to familiar web
    site attack vectors such as denial of service attacks.
    - FIXME: Monitoring

Secure shell (SSH)
~~~~~~~~~~~~~~~~~~

``[----]`` **Host key fingerprints**
  Host key fingerprints should be stored in a secure and queryable
  location. One particularly convenient solution is DNS using SSHFP
  resource records as defined in RFC-4255. For this to be secure, it
  is necessary that DNSSEC be deployed.

  * FIXME: Consider DNSSEC or other solutions

Management utilities
~~~~~~~~~~~~~~~~~~~~

``[----]`` **Security considerations**
  There are a few things that need to be considered (from `OpenStack
  Security Guide`_):

  * The dedicated management utilities (\*-manage) in some cases use
    the direct database connection.
    - FIXME: Don't use dedicated management utilities unless strictly
      necessary
  * Ensure that the .rc file which has your credential information is
    secured.
    - FIXME: Document how this is accomplished

Out-of-band management interface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``[----]`` **Security considerations**
  There are a few things that need to be considered (from `OpenStack
  Security Guide`_):

  * Use strong passwords and safeguard them, or use client-side TLS
    authentication.
    - FIXME: Ensure and document this
  * ``[PASS]`` Ensure that the network interfaces are on their own
    private(management or a separate) network. Segregate management
    domains with firewalls or other network gear.
  * If you use a web interface to interact with the BMC/IPMI, always
    use the TLS interface, such as HTTPS or port 443. This TLS
    interface should NOT use self-signed certificates, as is often
    default, but should have trusted certificates using the correctly
    defined fully qualified domain names (FQDNs).
    - FIXME: Use trusted CA
  * Monitor the traffic on the management network. The anomalies might
    be easier to track than on the busier compute nodes.
    - FIXME: Monitoring


Secure communication
====================

+-------------------------+---------------------+
| **Impact**              | High                |
+-------------------------+---------------------+
| **Implemented percent** | **0%** (0/?)        |
+-------------------------+---------------------+

From `OpenStack Security Guide`_:

  *There are a number of situations where there is a security
  requirement to assure the confidentiality or integrity of network
  traffic in an OpenStack deployment. This is generally achieved using
  cryptographic measures, such as the Transport Layer Security (TLS)
  protocol.*

Bottom line is that **all** endpoints, whether they are internal or
external, should be secured with encryption. TLS is strongly
preferred, due to recent published security vulnerabilities in SSL.

There are a number of services that need to be addressed:

* Compute API endpoints
* Identity API endpoints
* Networking API endpoints
* Storage API endpoints
* Messaging server
* Database server
* Dashboard


Certification authorities
-------------------------

The security guide recommends that we use separate PKI deployments for
internal systems and public facing services. In the future, we may
want to use separate PKI deployments for different security domains.

``[----]`` **Customer facing interfaces using trusted CA**
  All customer facing interfaces should be provisioned using
  Certificate Authorities that are installed in the operating system
  certificate bundles by default. It should just work without the
  customer having to accept an untrusted CA, or having to install some
  third-party software. We need certificates signed by a widely
  recognized public CA.

  * FIXME: Identify and list all customer facing interfaces
  * FIXME: Ensure publicly recognized CA on these interfaces

``[----]`` **Internal endpoints use non-public CA**
  As described above, it is recommended to use a private CA for
  internal endpoints.

  * FIXME: Identify and list all internal endpoints
  * FIXME: Ensure non-public CA on these endpoints


TLS libraries
-------------

From `OpenStack Security Guide`_:

  *The TLS and HTTP services within OpenStack are typically implemented
  using OpenSSL which has a module that has been validated for FIPS
  140-2.*

We need to make sure that we're using an updated version of OpenSSL.

``[----]`` **Ensure updated OpenSSL**
  UH-IaaS is based on CentOS, and uses the OpenSSL library from that
  distro. We need to make sure that OpenSSL is up-to-date.

  * FIXME: How often are critical components like openssl updated, and
    how is the procedure?


Cryptographic algorithms, cipher modes, and protocols
-----------------------------------------------------

The security guide recommends using **TLS 1.2**, as previous versions
are known to be vulnerable. Furthermore, it is recommended to limit
the cipher suite to **ECDHE-ECDSA-AES256-GCM-SHA384**. It is
acceptable to
accept **HIGH:!aNULL:!eNULL:!DES:!3DES:!SSLv3:!TLSv1:!CAMELLIA** in
cases where we don't control both endpoints.

``[----]`` **Ensure TLS 1.2**
  Make sure that only TLS 1.2 is used. Previous versions of TLS, as
  well as SSL, should be disabled completely.

``[----]`` **Limit cipher suite on public endpoints**
  Limit the cipher suite on public facing endpoints to the
  general **HIGH:!aNULL:!eNULL:!DES:!3DES:!SSLv3:!TLSv1:!CAMELLIA**.

``[----]`` **Limit cipher suite on internal endpoints**
  Limit the cipher suite on public facing endpoints
  to **ECDHE-ECDSA-AES256-GCM-SHA384**.


API endpoints
=============

+-------------------------+---------------------+
| **Impact**              | High                |
+-------------------------+---------------------+
| **Implemented percent** | **0%** (0/?)        |
+-------------------------+---------------------+

From `OpenStack Security Guide`_:

  *The process of engaging an OpenStack cloud is started through the
  querying of an API endpoint. While there are different challenges
  for public and private endpoints, these are high value assets that
  can pose a significant risk if compromised.*


API endpoint configuration recommendations
------------------------------------------

Internal API communications
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. _API endpoint configuration recommendations: http://docs.openstack.org/security-guide/api-endpoints/api-endpoint-configuration-recommendations.html

From `OpenStack Security Guide`_:

  *OpenStack provides both public facing and private API endpoints. By
  default, OpenStack components use the publicly defined
  endpoints. The recommendation is to configure these components to
  use the API endpoint within the proper security domain.*

  *Services select their respective API endpoints based on the
  OpenStack service catalog. These services might not obey the listed
  public or internal API end point values. This can lead to internal
  management traffic being routed to external API endpoints.*

``[----]`` **Configure internal URLs in the Identity service catalog**
  The guide recommends that our Identity service catalog be aware of
  our internal URLs. This feature is not utilized by default, but may
  be leveraged through configuration. See `API endpoint configuration
  recommendations`_ for details.

  * FIXME: Ensure and document this

``[----]`` **Configure applications for internal URLs**
  It is recommended that each OpenStack service communicating to the
  API of another service must be explicitly configured to access the
  proper internal API endpoint. See `API endpoint configuration
  recommendations`_. 

  * FIXME: Ensure and document this

Paste and middleware
~~~~~~~~~~~~~~~~~~~~

From `OpenStack Security Guide`_:

  *Most API endpoints and other HTTP services in OpenStack use the
  Python Paste Deploy library. From a security perspective, this
  library enables manipulation of the request filter pipeline through
  the application’s configuration. Each element in this chain is
  referred to as middleware. Changing the order of filters in the
  pipeline or adding additional middleware might have unpredictable
  security impact.*

``[----]`` **Document middleware**
  We should careful when implementating non-standard software in the
  middleware, and this should be thoroughly documented.

  * FIXME: Are we using any non-standard middleware?

API endpoint process isolation and policy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

From `OpenStack Security Guide`_:

  *You should isolate API endpoint processes, especially those that
  reside within the public security domain should be isolated as much
  as possible. Where deployments allow, API endpoints should be
  deployed on separate hosts for increased isolation.*

``[----]`` **Namespaces**
  Linux supports namespaces to assign processes into independent
  domains.

  * FIXME: Are we using namespaces to compartmentalize API endpoint
    processes?

``[----]`` **Network policy**
  We should pay special attention to API endpoints, as they typically
  bridge multiple security domains. Policies should be in place and
  documented, and we can use firewalls, SELinux etc. to enforce proper
  compartmentalization in the network layer.

  * FIXME: Implement and document this

``[----]`` **Mandatory access controls**
  API endpoint processes should be as isolated from each other as
  possible. This should be enforced through Mandatory Access Controls
  (e.g. SELinux), not just Discretionary Access Controls.

  * FIXME: API processes protected by SELinux


Identity
========

.. _OpenStack Security Guide\: Identity: http://docs.openstack.org/security-guide/identity.html

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

