.. |date| date::

Management
==========

Last changed: |date|

.. contents::

+-------------------------+---------------------+
| **Impact**              | Medium              |
+-------------------------+---------------------+
| **Implemented percent** | **26%** (5/19)      |
+-------------------------+---------------------+

Continuous systems management
-----------------------------

.. _OpenStack Security Guide\: Management - Continuous systems management: http://docs.openstack.org/security-guide/management/continuous-systems-management.html

From `OpenStack Security Guide\: Management - Continuous systems management`_:

  *A cloud will always have bugs. Some of these will be security
  problems. For this reason, it is critically important to be prepared
  to apply security updates and general software updates. This
  involves smart use of configuration management tools, which are
  discussed below. This also involves knowing when an upgrade is
  necessary.*

Vulnerability management
~~~~~~~~~~~~~~~~~~~~~~~~

.. _OpenStack Announce mailing list: http://lists.openstack.org/cgi-bin/mailman/listinfo/openstack-announce
.. _Patching: ../team/operations/patching.html


  *Updates are announced on the `OpenStack Announce mailing list`_. The
  security notifications are also posted through the downstream
  packages, for example, through Linux distributions that you may be
  subscribed to as part of the package updates.*

FIXME: Are we subscribed to this list?

FIXME: Are we subscribed to similar list pertaining to the repo/distro
used?

``[PASS]`` **Triage**
  When we are notified of a security update, this is discussed at the
  next morning meeting. We will then decide the impact of the update
  to our environment, and take proper action.

``[PASS]`` **Testing the updates**
  We have test clouds in each location (currently OSL and BGO) which
  in most respects are identical to the production clouds. This allows
  for easy testing of updates.

``[PASS]`` **Deploying the updates**
  When testing is completed and the update is verified, and we are
  satisfied with any performance impact, stability, application impact
  etc., the update is deployed in production. This is done via the
  following procedure:

  * Patching_


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

.. _OpenStack Security Guide\: Management - Integrity life-cycle: http://docs.openstack.org/security-guide/management/integrity-life-cycle.html

From `OpenStack Security Guide\: Management - Integrity life-cycle`_:

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

From OpenStack Security Guide:

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

.. _OpenStack Security Guide\: Management - Management interfaces: http://docs.openstack.org/security-guide/management/management-interfaces.html

From `OpenStack Security Guide\: Management - Management interfaces`_:

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
