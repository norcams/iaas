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


Dashboard
=========

.. _OpenStack Security Guide\: Dashboard: http://docs.openstack.org/security-guide/dashboard.html

+-------------------------+---------------------+
| **Impact**              | High                |
+-------------------------+---------------------+
| **Implemented percent** | **0%** (0/?)        |
+-------------------------+---------------------+

From `OpenStack Security Guide\: Dashboard`_:

  *Horizon is the OpenStack dashboard that provides users a
  self-service portal to provision their own resources within the
  limits set by administrators. These include provisioning users,
  defining instance flavors, uploading VM images, managing networks,
  setting up security groups, starting instances, and accessing the
  instances through a console.*


Domain names, dashboard upgrades, and basic web server configuration
--------------------------------------------------------------------

.. _OpenStack Security Guide\: Dashboard - Domain names, dashboard upgrades, and basic web server configuration: http://docs.openstack.org/security-guide/dashboard/domains-dashboard-upgrades-basic-web-server-configuration.html

Ref: `OpenStack Security Guide\: Dashboard - Domain names, dashboard upgrades, and basic web server configuration`_

Domain names
~~~~~~~~~~~~

From OpenStack Security Guide:

  *We strongly recommend deploying dashboard to a second-level domain,
  such as https://example.com, rather than deploying dashboard on
  a shared subdomain of any level, for example
  https://openstack.example.org or
  https://horizon.openstack.example.org. We also advise against
  deploying to bare internal domains like https://horizon/. These
  recommendations are based on the limitations of browser
  same-origin-policy.*

``[----]`` **Use second-level domain**
  FIXME: Are we using a second-level domain?

``[----]`` **Employ HTTP Strict Transport Security (HSTS)**
  If not using second-level domain, we are advised to avoid a
  cookie-backed session store and employ HTTP Strict Transport
  Security (HSTS)

  * FIXME: ?

Basic web server configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

From OpenStack Security Guide:

  *The dashboard should be deployed as a Web Services Gateway Interface
  (WSGI) application behind an HTTPS proxy such as Apache or nginx. If
  Apache is not already in use, we recommend nginx since it is
  lightweight and easier to configure correctly.*

``[----]`` **Is dashboard deployed as a WSGI application behind an HTTPS proxy?**
  FIXME: Answer and document

Allowed hosts
~~~~~~~~~~~~~

From OpenStack Security Guide:

  *Configure the ALLOWED_HOSTS setting with the fully qualified host
  name(s) that are served by the OpenStack dashboard. Once this
  setting is provided, if the value in the “Host:” header of an
  incoming HTTP request does not match any of the values in this list
  an error will be raised and the requestor will not be able to
  proceed. Failing to configure this option, or the use of wild card
  characters in the specified host names, will cause the dashboard to
  be vulnerable to security breaches associated with fake HTTP Host
  headers.*

``[----]`` **Is ALLOWED_HOSTS configured for dashboard?**
  FIXME: Answer and document

Horizon image upload
~~~~~~~~~~~~~~~~~~~~

It is recommended that we disable HORIZON_IMAGES_ALLOW_UPLOAD unless
we have a plan to prevent resource exhaustion and denial of service.

``[----]`` **Is HORIZON_IMAGES_ALLOW_UPLOAD disabled?**
  FIXME: Answer and document


HTTPS, HSTS, XSS, and SSRF
--------------------------

.. _OpenStack Security Guide\: Dashboard - HTTPS, HSTS, XSS, and SSRF: http://docs.openstack.org/security-guide/dashboard/https-hsts-xss-ssrf.html

Ref: `OpenStack Security Guide\: Dashboard - HTTPS, HSTS, XSS, and SSRF`_

Cross Site Scripting (XSS)
~~~~~~~~~~~~~~~~~~~~~~~~~~

From OpenStack Security Guide:

  *Unlike many similar systems, the OpenStack dashboard allows the
  entire Unicode character set in most fields. This means developers
  have less latitude to make escaping mistakes that open attack
  vectors for cross-site scripting (XSS).*

``[----]`` **Audit custom dashboards**
  Audit any custom dashboards, paying particular attention to use of
  the ``mark_safe`` function, use of ``is_safe`` with custom template
  tags, the ``safe`` template tag, anywhere auto escape is turned off,
  and any JavaScript which might evaluate improperly escaped data.

  * FIXME: Are we using any custom dashboards?

Cross Site Request Forgery (CSRF)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

From OpenStack Security Guide:

  *Dashboards that utilize multiple instances of JavaScript should be
  audited for vulnerabilities such as inappropriate use of the
  @csrf_exempt decorator.*

``[----]`` **Audit custom dashboards**
  FIXME: Are we using any custom dashboards?

HTTPS
~~~~~

From OpenStack Security Guide:

  *Deploy the dashboard behind a secure HTTPS server by using a valid,
  trusted certificate from a recognized certificate authority (CA).*

``[----]`` **Use trusted certificate for dashboard**
  FIXME

``[----]`` **Redirect to fully qualified HTTPS URL**
  Configure HTTP requests to the dashboard domain to redirect to the
  fully qualified HTTPS URL.

  * FIXME: Any redirects?

HTTP Strict Transport Security (HSTS)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It is highly recommended to use HTTP Strict Transport Security (HSTS).

``[----]`` **Use HSTS**
  FIXME: Are we using HSTS?


Front-end caching and session back end
--------------------------------------

.. _OpenStack Security Guide\: Dashboard - Front-end caching and session back end: http://docs.openstack.org/security-guide/dashboard/front-end-caching-session-back-end.html

Ref: `OpenStack Security Guide\: Dashboard - Front-end caching and session back end`_

Front-end caching
~~~~~~~~~~~~~~~~~

``[----]`` **Do not use front-end caching tools**
  FIXME: Are we using this?

Session back end
~~~~~~~~~~~~~~~~

It is recommended to use ``django.contrib.sessions.backends.cache`` as
our session back end with memcache as the cache. This as opposed to
the default, which saves user data in signed, but unencrypted cookies
stored in the browser.

``[----]`` **Consider using caching back end**
  FIXME: Consider and document


Static media
------------

.. _OpenStack Security Guide\: Dashboard - Static media: http://docs.openstack.org/security-guide/dashboard/static-media.html

Ref: `OpenStack Security Guide\: Dashboard - Static media`_

  *The dashboard’s static media should be deployed to a subdomain of
  the dashboard domain and served by the web server. The use of an
  external content delivery network (CDN) is also acceptable. This
  subdomain should not set cookies or serve user-provided content. The
  media should also be served with HTTPS.*

``[----]`` **Static media via subdomain**
  FIXME: Is this implemented?

``[----]`` **Subdomain not serving cookies or user-provided content**
  FIXME: Make sure

``[----]`` **Subdomain via HTTPS**
  FIXME: Make sure


Secret key
----------

.. _OpenStack Security Guide\: Dashboard - Secret key: http://docs.openstack.org/security-guide/dashboard/secret-key.html

Ref: `OpenStack Security Guide\: Dashboard - Secret key`_

  *The dashboard depends on a shared SECRET_KEY setting for some
  security functions. The secret key should be a randomly generated
  string at least 64 characters long, which must be shared across all
  active dashboard instances. Compromise of this key may allow a
  remote attacker to execute arbitrary code. Rotating this key
  invalidates existing user sessions and caching. Do not commit this
  key to public repositories.*

``[----]`` **Randomly generated string at least 64 characters long**
  FIXME: Make sure

``[----]`` **Not in public repo**
  FIXME: Make sure


Cookies
-------

.. _OpenStack Security Guide\: Dashboard - Cookies: http://docs.openstack.org/security-guide/dashboard/cookies.html

Ref: `OpenStack Security Guide\: Dashboard - Cookies`_

``[----]`` **Session cookies should be set to HTTPONLY**
  FIXME: Make sure

``[----]`` **Never configure CSRF or session cookies to have a wild card domain with a leading dot**
  FIXME: Make sure

``[----]`` **Horizon’s session and CSRF cookie should be secured when deployed with HTTPS**
  FIXME: Make sure


Cross Origin Resource Sharing (CORS)
------------------------------------

.. _OpenStack Security Guide\: Dashboard - Cross Origin Resource Sharing (CORS): http://docs.openstack.org/security-guide/dashboard/cross-origin-resource-sharing-cors.html

Ref: `OpenStack Security Guide\: Dashboard - Cross Origin Resource Sharing (CORS)`_

  *Configure your web server to send a restrictive CORS header with
  each response, allowing only the dashboard domain and protocol*

``[----]`` **Restrictive CORS header**
  FIXME: Make sure


Checklist
---------

.. _OpenStack Security Guide\: Dashboard - Checklist: http://docs.openstack.org/security-guide/dashboard/checklist.html

Ref: `OpenStack Security Guide\: Dashboard - Checklist`_

See the above link for info about these checks.

``[----]`` **Check-Dashboard-01: Is user/group of config files set to root/horizon?**
  Yes/No?

``[----]`` **Check-Dashboard-02: Are strict permissions set for horizon configuration files?**
  Yes/No?

``[----]`` **Check-Dashboard-03: Is USE_SSL parameter set to True?**
  Yes/No?

``[----]`` **Check-Dashboard-04: Is CSRF_COOKIE_SECURE parameter set to True?**
  Yes/No?

``[----]`` **Check-Dashboard-05: Is SESSION_COOKIE_SECURE parameter set to True?**
  Yes/No?

``[----]`` **Check-Dashboard-06: Is SESSION_COOKIE_HTTPONLY parameter set to True?**
  Yes/No?

``[----]`` **Check-Dashboard-07: Is password_autocomplete set to False?**
  Yes/No?

``[----]`` **Check-Dashboard-08: Is disable_password_reveal set to True?**
  Yes/No?


Compute
=======

.. _OpenStack Security Guide\: Compute: http://docs.openstack.org/security-guide/compute.html

+-------------------------+---------------------+
| **Impact**              | High                |
+-------------------------+---------------------+
| **Implemented percent** | **0%** (0/?)        |
+-------------------------+---------------------+

From `OpenStack Security Guide\: Compute`_:

  *The OpenStack Compute service (nova) is one of the more complex
  OpenStack services. It runs in many locations throughout the cloud
  and interacts with a variety of internal services. The OpenStack
  Compute service offers a variety of configuration options which may
  be deployment specific. In this chapter we will call out general
  best practice around Compute security as well as specific known
  configurations that can lead to security issues. In general, the
  nova.conf file and the /var/lib/nova locations should be
  secured. Controls like centralized logging, the policy.json file,
  and a mandatory access control framework should be
  implemented. Additionally, there are environmental considerations to
  keep in mind, depending on what functionality is desired for your
  cloud.*


Hypervisor selection
--------------------

.. _OpenStack Security Guide\: Compute - Hypervisor selection: http://docs.openstack.org/security-guide/compute/hypervisor-selection.html

Ref: `OpenStack Security Guide\: Compute - Hypervisor selection`_

We are using KVM.


Hardening the virtualization layers
-----------------------------------

.. _OpenStack Security Guide\: Compute - Hardening the virtualization layers: http://docs.openstack.org/security-guide/compute/hardening-the-virtualization-layers.html

Ref: `OpenStack Security Guide\: Compute - Hardening the virtualization layers`_

Physical hardware (PCI passthrough)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``[----]`` **Ensure that the hypervisor is configured to utilize IOMMU**
  FIXME: Make sure

``[----]`` **Disable PCI passthrough**
  FIXME: Is this disabled?

Minimizing the QEMU code base
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Does not apply. We are using precompiled QEMU.

Compiler hardening
~~~~~~~~~~~~~~~~~~

Does not apply. We are using precompiled QEMU.

Mandatory access controls
~~~~~~~~~~~~~~~~~~~~~~~~~

``[----]`` **Ensure SELinux / sVirt is running in Enforcing mode**
  FIXME: Make sure


How to select virtual consoles
------------------------------

.. _OpenStack Security Guide\: Compute - How to select virtual consoles: http://docs.openstack.org/security-guide/compute/how-to-select-virtual-consoles.html

Ref: `OpenStack Security Guide\: Compute - How to select virtual consoles`_

``[----]`` **Choose which virtual console we want**
  FIXME: Select and document


Checklist
---------

.. _OpenStack Security Guide\: Compute - Checklist: http://docs.openstack.org/security-guide/compute/checklist.html

Ref: `OpenStack Security Guide\: Compute - Checklist`_

See the above link for info about these checks.

``[----]`` **Check-Compute-01: Is user/group ownership of config files set to root/nova?**
  Yes/No?

``[----]`` **Check-Compute-02: Are strict permissions set for configuration files?**
  Yes/No?

``[----]`` **Check-Compute-03: Is keystone used for authentication?**
  Yes/No?

``[----]`` **Check-Compute-04: Is secure protocol used for authentication?**
  Yes/No?

``[----]`` **Check-Compute-05: Does Nova communicate with Glance securely?**
  Yes/No?


Block Storage
=============

.. _OpenStack Security Guide\: Block Storage: http://docs.openstack.org/security-guide/block-storage.html

+-------------------------+---------------------+
| **Impact**              | High                |
+-------------------------+---------------------+
| **Implemented percent** | **0%** (0/8)        |
+-------------------------+---------------------+

From `OpenStack Security Guide\: Block Storage`_:

  *OpenStack Block Storage (cinder) is a service that provides software
  (services and libraries) to self-service manage persistent
  block-level storage devices. This creates on-demand access to Block
  Storage resources for use with OpenStack Compute (nova)
  instances. This creates software-defined storage via abstraction by
  virtualizing pools of block storage to a variety of back-end storage
  devices which can be either software implementations or traditional
  hardware storage products. The primary functions of this is to
  manage the creation, attaching and detaching of the block
  devices. The consumer requires no knowledge of the type of back-end
  storage equipment or where it is located.*


Checklist
---------

.. _OpenStack Security Guide\: Block Storage - Checklist: http://docs.openstack.org/security-guide/block-storage/checklist.html

Ref: `OpenStack Security Guide\: Block Storage - Checklist`_

See the above link for info about these checks.

``[----]`` **Check-Block-01: Is user/group ownership of config files set to root/cinder?**
  Yes/No?

``[----]`` **Check-Block-02: Are strict permissions set for configuration files?**
  Yes/No?

``[----]`` **Check-Block-03: Is keystone used for authentication?**
  Yes/No?

``[----]`` **Check-Block-04: Is TLS enabled for authentication?**
  Yes/No?

``[----]`` **Check-Block-05: Does cinder communicate with nova over TLS?**
  Yes/No?

``[----]`` **Check-Block-06: Does cinder communicate with glance over TLS?**
  Yes/No?

``[----]`` **Check-Block-07: Is NAS operating in a secure environment?**
  Yes/No?

``[----]`` **Check-Block-08: Is max size for the body of a request set to default (114688)?**
  Yes/No?


Shared File Systems
===================

.. _OpenStack Security Guide\: Shared File Systems: http://docs.openstack.org/security-guide/shared-file-systems.html

From `OpenStack Security Guide\: Shared File Systems`_:

  *The Shared File Systems service (manila) provides a set of services
  for management of shared file systems in a multi-tenant cloud
  environment, similar to how OpenStack provides for block-based
  storage management through the OpenStack Block Storage service
  project. With the Shared File Systems service, you can create a
  remote file system, mount the file system on your instances, and
  then read and write data from your instances to and from your file
  system.*

.. NOTE::
   Does not apply. We are not using Manila.


Networking
==========

.. _OpenStack Security Guide\: Networking: http://docs.openstack.org/security-guide/networking.html

+-------------------------+---------------------+
| **Impact**              | High                |
+-------------------------+---------------------+
| **Implemented percent** | **0%** (0/?)        |
+-------------------------+---------------------+

From `OpenStack Security Guide\: Networking`_:

  *OpenStack Networking enables the end-user or tenant to define,
  utilize, and consume networking resources. OpenStack Networking
  provides a tenant-facing API for defining network connectivity and
  IP addressing for instances in the cloud in addition to
  orchestrating the network configuration. With the transition to an
  API-centric networking service, cloud architects and administrators
  should take into consideration best practices to secure physical and
  virtual network infrastructure and services.*


Networking services
-------------------

.. _OpenStack Security Guide\: Networking - Networking services: http://docs.openstack.org/security-guide/networking/services.html

Ref: `OpenStack Security Guide\: Networking - Networking services`_

L2 isolation using VLANs and tunneling
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Does not apply. We're using Calico, in which L2 isn't employed at all.

Network services
~~~~~~~~~~~~~~~~

``[----]`` **Use Neutron for security groups**
  When using the Networking service, we recommend that you enable
  security groups in this service and disable it in the Compute
  service.

  * FIXME: Describe how this works with Calico


Networking services security best practices
-------------------------------------------

.. _OpenStack Security Guide\: Networking - Networking services security best practices: http://docs.openstack.org/security-guide/networking/securing-services.html

Ref: `OpenStack Security Guide\: Networking - Networking services security best practices`_

``[----]`` **Document how Calico is used in UH-IaaS infrastructure**
  FIXME: Provide documentation

``[----]`` **Document which security domains have access to OpenStack network node**
  FIXME: Provide documentation

``[----]`` **Document which security domains have access to SDN services node**
  FIXME: Provide documentation

OpenStack Networking service configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``[----]`` **Restrict bind address of the API server: neutron-server**
  FIXME: Document restriction


Securing OpenStack networking services
--------------------------------------

.. _OpenStack Security Guide\: Networking - Securing OpenStack networking services: http://docs.openstack.org/security-guide/networking/services-security-best-practices.html

Ref: `OpenStack Security Guide\: Networking - Securing OpenStack networking services`_

Networking resource policy engine
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

From OpenStack Security Guide:

  *A policy engine and its configuration file, policy.json, within
  OpenStack Networking provides a method to provide finer grained
  authorization of users on tenant networking methods and objects. The
  OpenStack Networking policy definitions affect network availability,
  network security and overall OpenStack security.*

``[----]`` **Evaluate network policy**
  FIXME: Evaluate and document

Quotas
~~~~~~

``[----]`` **Document choices wrt. networking quotas**
  FIXME: Document this


Checklist
---------

.. _OpenStack Security Guide\: Networking - Checklist: http://docs.openstack.org/security-guide/networking/checklist.html

Ref: `OpenStack Security Guide\: Networking - Checklist`_

See the above link for info about these checks.

``[----]`` **Check-Neutron-01: Is user/group ownership of config files set to root/neutron?**
  Yes/No?

``[----]`` **Check-Neutron-02: Are strict permissions set for configuration files?**
  Yes/No?

``[----]`` **Check-Neutron-03: Is keystone used for authentication?**
  Yes/No?

``[----]`` **Check-Neutron-04: Is secure protocol used for authentication?**
  Yes/No?

``[----]`` **Check-Neutron-05: Is TLS enabled on Neutron API server?**
  Yes/No?


Object Storage
==============

.. _OpenStack Security Guide\: Object Storage: http://docs.openstack.org/security-guide/object-storage.html

From `OpenStack Security Guide\: Object Storage`_:

  *OpenStack Object Storage (swift) is a service that provides software
  that stores and retrieves data over HTTP. Objects (blobs of data)
  are stored in an organizational hierarchy that offers anonymous
  read-only access, ACL defined access, or even temporary
  access. Object Store supports multiple token-based authentication
  mechanisms implemented via middleware.*

.. NOTE::
   Does not apply. We are not using Swift.


Message queuing
===============

.. _OpenStack Security Guide\: Message queuing: http://docs.openstack.org/security-guide/messaging.html

+-------------------------+---------------------+
| **Impact**              | High                |
+-------------------------+---------------------+
| **Implemented percent** | **0%** (0/?)        |
+-------------------------+---------------------+

From `OpenStack Security Guide\: Message queuing`_:

  *Message queues effectively facilitate command and control functions
  across OpenStack deployments. Once access to the queue is permitted
  no further authorization checks are performed. Services accessible
  through the queue do validate the contexts and tokens within the
  actual message payload. However, you must note the expiration date
  of the token because tokens are potentially re-playable and can
  authorize other services in the infrastructure.*

  *OpenStack does not support message-level confidence, such as message
  signing. Consequently, you must secure and authenticate the message
  transport itself. For high-availability (HA) configurations, you
  must perform queue-to-queue authentication and encryption.*

.. NOTE::
   We are using RabbitMQ as message queuing service back end.

Messaging security
------------------

.. _OpenStack Security Guide\: Message queuing - Messaging security: http://docs.openstack.org/security-guide/messaging/security.html

Ref: `OpenStack Security Guide\: Message queuing - Messaging security`_

Messaging transport security
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

From OpenStack Security Guide:

  *We highly recommend enabling transport-level cryptography for your
  message queue. Using TLS for the messaging client connections
  provides protection of the communications from tampering and
  eavesdropping in-transit to the messaging server.*

``[----]`` **Ensure TLS is used for RabbitMQ**
  FIXME: yes/no

``[----]`` **Use an internally managed CA**
  FIXME: Document this

``[----]`` **Ensure restricted file permissions on certificate and key files**
  FIXME: yes/no

Queue authentication and access control
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

From OpenStack Security Guide:

  *We recommend configuring X.509 client certificates on all the
  OpenStack service nodes for client connections to the messaging
  queue and where possible (currently only Qpid) perform
  authentication with X.509 client certificates. When using user names
  and passwords, accounts should be created per-service and node for
  finer grained auditability of access to the queue.*

``[----]`` **Configure X.509 client certificates on all OpenStack service nodes**
  FIXME: Implement and document

``[----]`` **Any user names and passwords are per-service and node**
  FIXME: Implement and document

Message queue process isolation and policy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``[----]`` **Use network namespaces**
  Network namespaces are highly recommended for all services running
  on OpenStack Compute Hypervisors. This will help prevent against the
  bridging of network traffic between VM guests and the management
  network.

  * FIXME: Ensure and document

``[----]`` **Ensure queue servers only accept connections from management network**
  FIXME: Ensure and document

``[----]`` **Use mandatory access controls**
  FIXME: SELinux in enforcing mode on all nodes


Data processing
===============

.. _OpenStack Security Guide\: Data processing: http://docs.openstack.org/security-guide/data-processing.html

From `OpenStack Security Guide\: Data processing`_:

  *The Data processing service for OpenStack (sahara) provides a
  platform for the provisioning and management of instance clusters
  using processing frameworks such as Hadoop and Spark. Through the
  OpenStack dashboard or REST API, users will be able to upload and
  execute framework applications which may access data in object
  storage or external providers. The data processing controller uses
  the Orchestration service to create clusters of instances which may
  exist as long-running groups that can grow and shrink as requested,
  or as transient groups created for a single workload.*

.. NOTE::
   Does not apply. We are not using Sahara.


Databases
=========

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


Tenant data privacy
===================

.. _OpenStack Security Guide\: Tenant data privacy: http://docs.openstack.org/security-guide/tenant-data.html

+-------------------------+---------------------+
| **Impact**              | High                |
+-------------------------+---------------------+
| **Implemented percent** | **0%** (0/?)        |
+-------------------------+---------------------+

From `OpenStack Security Guide\: Tenant data privacy`_:

  *OpenStack is designed to support multitenancy and those tenants will
  most probably have different data requirements. As a cloud builder
  and operator you need to ensure your OpenStack environment can
  address various data privacy concerns and regulations.*


Data privacy concerns
---------------------

.. _OpenStack Security Guide\: Tenant data privacy - Data privacy concerns: http://docs.openstack.org/security-guide/tenant-data/data-privacy-concerns.html

Ref: `OpenStack Security Guide\: Tenant data privacy - Data privacy concerns`_

Data residency
~~~~~~~~~~~~~~

From OpenStack Security Guide:

  *Numerous OpenStack services maintain data and metadata belonging to
  tenants or reference tenant information.*

  *Tenant data stored in an OpenStack cloud may include the following items:*
  - *Object Storage objects*
  - *Compute instance ephemeral filesystem storage*
  - *Compute instance memory*
  - *Block Storage volume data*
  - *Public keys for Compute access*
  - *Virtual machine images in the Image service*
  - *Machine snapshots*
  - *Data passed to OpenStack Compute’s configuration-drive extension*

  *Metadata stored by an OpenStack cloud includes the following non-exhaustive items:*
  - *Organization name*
  - *User’s “Real Name”*
  - *Number or size of running instances, buckets, objects, volumes, and other quota-related items*
  - *Number of hours running instances or storing data*
  - *IP addresses of users*
  - *Internally generated private keys for compute image bundling*

Data disposal
~~~~~~~~~~~~~

From OpenStack Security Guide:

  *OpenStack operators should strive to provide a certain level of
  tenant data disposal assurance. Best practices suggest that the
  operator sanitize cloud system media (digital and non-digital) prior
  to disposal, release out of organization control or release for
  reuse. Sanitization methods should implement an appropriate level of
  strength and integrity given the specific security domain and
  sensitivity of the information.*

The security guide states that the cloud operators should do the
following:

``[----]`` **Track, document and verify media sanitization and disposal actions**
  FIXME: Describe and document

``[----]`` **Test sanitation equipment and procedures to verify proper performance**
  FIXME: Document testing

``[----]`` **Sanitize portable, removable storage devices prior to connecting such devices to the cloud infrastructure**
  FIXME: Document policies regarding this

``[----]`` **Destroy cloud system media that cannot be sanitized**
  FIXME: wtf?

Data not securely erased
""""""""""""""""""""""""

Regarding erasure of metadata, the security guide suggests using
database and/or system configuration for auto vacuuming and periodic
free-space wiping.

``[----]`` **Periodic database vacuuming**
  FIXME: Implement and document

``[----]`` **Periodic free-space wiping of ephemeral storage**
  FIXME: Implement and document

Instance memory scrubbing
"""""""""""""""""""""""""

.. _KVM documentation: http://www.linux-kvm.org/page/Memory

As we're using KVM, which relies on Linux page management, we need to
consult the `KVM documentation`_ about memory scrubbing.

``[----]`` **Consider automatic/periodic memory scrubbing**
  FIXME: Consult KVM doc, consider if this is needed and document

Cinder volume data
""""""""""""""""""

From OpenStack Security Guide:

  *Use of the OpenStack volume encryption feature is highly
  encouraged. This is discussed in the Data Encryption section
  below. When this feature is used, destruction of data is
  accomplished by securely deleting the encryption key.*

``[----]`` **Consider volume encryption**
  FIXME: This depends on the plugin used. Document this.

``[----]`` **Secure erasure of volume data**
  FIXME: Review and implement mechanisms that are feasible and
  applicable in our case.

Image service delay delete feature
""""""""""""""""""""""""""""""""""

From OpenStack Security Guide:

  *OpenStack Image service has a delayed delete feature, which will
  pend the deletion of an image for a defined time period. It is
  recommended to disable this feature if it is a security concern*

``[----]`` **Consider disabling delayed delete**
  FIXME: Consider if this is a security concern, and consider
  disabling the delayed delete feature

Compute soft delete feature
"""""""""""""""""""""""""""

From OpenStack Security Guide:

  *OpenStack Compute has a soft-delete feature, which enables an
  instance that is deleted to be in a soft-delete state for a defined
  time period. The instance can be restored during this time period.*

``[----]`` **Consider disabling compute soft delete**
  FIXME: Consider if this is a security concern, and consider
  disabling the soft delete feature

Compute instance ephemeral storage
""""""""""""""""""""""""""""""""""

From OpenStack Security Guide:

  *The creation and destruction of ephemeral storage will be somewhat
  dependent on the chosen hypervisor and the OpenStack Compute
  plug-in.*

``[----]`` **Document ephemeral storage deletion**
  FIXME: Document how this works in our environment


Data encryption
---------------

.. _OpenStack Security Guide\: Tenant data privacy - Data encryption: http://docs.openstack.org/security-guide/tenant-data/data-encryption.html

From `OpenStack Security Guide\: Tenant data privacy - Data encryption`_:

  *The option exists for implementers to encrypt tenant data wherever
  it is stored on disk or transported over a network, such as the
  OpenStack volume encryption feature described below. This is above
  and beyond the general recommendation that users encrypt their own
  data before sending it to their provider.*

Volume encryption
~~~~~~~~~~~~~~~~~

``[----]`` **Consider volume encryption**
  FIXME: Consider this and document

Ephemeral disk encryption
~~~~~~~~~~~~~~~~~~~~~~~~~

``[----]`` **Consider ephemeral disk encryption**
  FIXME: Consider this and document

Block Storage volumes and instance ephemeral filesystems
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``[----]`` **Consider which options we have available**
  FIXME: Document

``[----]`` **Consider adding encryption**
  FIXME: Consider and document

Network data
~~~~~~~~~~~~

``[----]`` **Consider encrypting tenant data over IPsec or other tunnels**
  FIXME: Consider and document


Key management
--------------

.. _OpenStack Security Guide\: Tenant data privacy - Key management: http://docs.openstack.org/security-guide/tenant-data/key-management.html

From `OpenStack Security Guide\: Tenant data privacy - Key management`_:

  *The volume encryption and ephemeral disk encryption features rely
  on a key management service (for example, barbican) for the creation
  and secure storage of keys. The key manager is pluggable to
  facilitate deployments that need a third-party Hardware Security
  Module (HSM) or the use of the Key Management Interchange Protocol
  (KMIP), which is supported by an open-source project called PyKMIP.*

``[----]`` **Consider adding Barbican**
  FIXME: Consider and document


Instance security management
============================

.. _OpenStack Security Guide\: Instance security management: http://docs.openstack.org/security-guide/instance-management.html

+-------------------------+---------------------+
| **Impact**              | High                |
+-------------------------+---------------------+
| **Implemented percent** | **0%** (0/?)        |
+-------------------------+---------------------+

From `OpenStack Security Guide\: Instance security management`_:

  *One of the virtues of running instances in a virtualized environment
  is that it opens up new opportunities for security controls that are
  not typically available when deploying onto bare metal. There are
  several technologies that can be applied to the virtualization stack
  that bring improved information assurance for cloud tenants.*

  *Deployers or users of OpenStack with strong security requirements
  may want to consider deploying these technologies. Not all are
  applicable in every situation, indeed in some cases technologies may
  be ruled out for use in a cloud because of prescriptive business
  requirements. Similarly some technologies inspect instance data such
  as run state which may be undesirable to the users of the system.*


Security services for instances
-------------------------------

.. _OpenStack Security Guide\: Instance security management - Security services for instances: http://docs.openstack.org/security-guide/instance-management/security-services-for-instances.html

Ref: `OpenStack Security Guide\: Instance security management - Security services for instances`_

Entropy to instances
~~~~~~~~~~~~~~~~~~~~

From OpenStack Security Guide:

  *The Virtio RNG is a random number generator that uses /dev/random as
  the source of entropy by default, however can be configured to use a
  hardware RNG or a tool such as the entropy gathering daemon (EGD) to
  provide a way to fairly and securely distribute entropy through a
  distributed system.*

``[----]`` **Consider adding hardware random number generators (HRNG)**
  FIXME: Consider and document


Scheduling instances to nodes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

From OpenStack Security Guide:

  *Before an instance is created, a host for the image instantiation
  must be selected. This selection is performed by the nova-scheduler
  which determines how to dispatch compute and volume requests.*

``[----]`` **Describe which scheduler and filters that are used**
  FIXME: Document this


Trusted images
~~~~~~~~~~~~~~

From OpenStack Security Guide:

  *In a cloud environment, users work with either pre-installed images
  or images they upload themselves. In both cases, users should be
  able to ensure the image they are utilizing has not been tampered
  with.*

``[----]`` **Maintain golden images**
  FIXME: Describe/document policies for maintaining a set of golden
  images obtained from trusted sources

``[DEFERRED]`` **Consider enabling instance signature verification**
  Only available in Mitaka and later releases


Instance migrations
~~~~~~~~~~~~~~~~~~~

``[----]`` **Disable live migration**
  FIXME: disable this if we don't want to support it


Monitoring, alerting, and reporting
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``[----]`` **Aggrgate logs, e.g. to ELK**
  FIXME: Implement and document

