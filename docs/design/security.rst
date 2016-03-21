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

**Hardware inventory [-]**
  FIXME

**Software inventory [-]**
  FIXME

**Network topology [-]**
  FIXME

**Services, protocols and ports [-]**
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

**Triage [-]**
  When we are notified of a security update, this is discussed at the
  next morning meeting. We will then decide the impact of the update
  to our environment, and take proper action.

  * FIXME: Make this a policy.

**Testing the updates [-]**
  We have test clouds in each location (currently OSL and BGO) which
  in most respects are identical to the production clouds. This allows
  for easy testing of updates.

  * FIXME: Make this a policy.
  * FIXME: OSL test cloud isn't ready yet.

**Deploying the updates [-]**
  When testing is completed and the update is verified, and we are
  satisfied with any performance impact, stability, application impact
  etc., the update is deployed in production. This is done
  automatically via the following procedure:

  * FIXME: Automatic update procedure?

Configuration management
~~~~~~~~~~~~~~~~~~~~~~~~

FIXME: Describe automated configuration and deployment, or add links.

**Policy changes [-]**
  FIXME: How are policy changes tracked?

Secure backup and recovery
~~~~~~~~~~~~~~~~~~~~~~~~~~

FIXME.

Security auditing tools
~~~~~~~~~~~~~~~~~~~~~~~

FIXME.


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

**Customer facing interfaces using trusted CA [-]**
  All customer facing interfaces should be provisioned using
  Certificate Authorities that are installed in the operating system
  certificate bundles by default. It should just work without the
  customer having to accept an untrusted CA, or having to install some
  third-party software. We need certificates signed by a widely
  recognized public CA.

  * FIXME: Identify and list all customer facing interfaces
  * FIXME: Ensure publicly recognized CA on these interfaces

**Internal endpoints use non-public CA [-]**
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

**Ensure updated OpenSSL [-]**
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

**Ensure TLS 1.2 [-]**
  Make sure that only TLS 1.2 is used. Previous versions of TLS, as
  well as SSL, should be disabled completely.

**Limit cipher suite on public endpoints [-]**
  Limit the cipher suite on public facing endpoints to the
  general **HIGH:!aNULL:!eNULL:!DES:!3DES:!SSLv3:!TLSv1:!CAMELLIA**.

**Limit cipher suite on internal endpoints [-]**
  Limit the cipher suite on public facing endpoints
  to **ECDHE-ECDSA-AES256-GCM-SHA384**.



