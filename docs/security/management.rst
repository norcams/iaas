.. |date| date::

[2021] Management
=================

``REVISION 2021-01-26``

.. contents::

+-------------------------+---------------------+
| **Impact**              | Medium              |
+-------------------------+---------------------+
| **Implemented percent** | **76%** (13/17)     |
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


  *Updates are announced on the* `OpenStack Announce mailing list`_. *The
  security notifications are also posted through the downstream
  packages, for example, through Linux distributions that you may be
  subscribed to as part of the package updates.*

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
  Patching_ policy.


Configuration management
~~~~~~~~~~~~~~~~~~~~~~~~

Deployment of both physical and virtual nodes in NREC is done using
Ansible playbooks, which are maintained on GitHub. The configuration
managements is completely automated via Puppet. The Puppet code and
hieradata is maintained on GitHub. All changes are tracked via Git.

``[PASS]`` **Policy changes**
  Policy changes are tracked in Git and/or our KanBan board

Secure backup and recovery
~~~~~~~~~~~~~~~~~~~~~~~~~~

If we at some point decide to take backup of the infrastructure or
instances, we should include the backup procedures and policies in the
overall security plan.

``[PASS]`` **Backup procedure and policy**
  We do not take regular, incremental backups. Important data are
  replicated within the NREC infrastructure to mitigate information
  loss.

Security auditing tools
~~~~~~~~~~~~~~~~~~~~~~~

.. _SCAP: https://fedorahosted.org/scap-security-guide/

We should consider using SCAP_ or similar security auditing tools in
combination with configuration management.

``[FAIL]`` **Security auditing tools**
  Security auditing tools such as SCAP adds complexity and
  significant delays in the pipeline. Therefore, this is not a priority
  at this time.


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
  provisioning. The provisioning process is handled by Ansible.

``[FAIL]`` **Verified boot**
  It is recommended to use *secure boot* via TPM chip to boot the
  infrastructure nodes in the cloud. TPM adds unwanted complexity and
  we don't use it.

``[PASS]`` **Node hardening**
  We do general node hardening via a security baseline which we
  maintain via Puppet. The security baseline is based on best practice
  from the OS vendor, as well as our own experience. All nodes are
  using Mandatory Access Control (MAC) via SELinux.


Runtime verification
~~~~~~~~~~~~~~~~~~~~

From OpenStack Security Guide:

  *Once the node is running, we need to ensure that it remains in a
  good state over time. Broadly speaking, this includes both
  configuration management and security monitoring. The goals for each
  of these areas are different. By checking both, we achieve higher
  assurance that the system is operating as desired.*

``[FAIL]`` **Intrusion detection system**
  We are not running an Intrusion detection system (IDS).


Server hardening
~~~~~~~~~~~~~~~~

This mostly includes file integrity management.

``[FAIL]`` **File integrity management (FIM)**
  We should consider a FIM tool to ensure that files such as sensitive
  system or application configuration files are no corrupted or
  changed to allow unauthorized access or malicious behaviour.

  * While we don't run a specific FIM tool, our configuration
    management system (Puppet) functions as a watchdog for most
    important files.


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

``[PASS]`` **Capabilities**
  The dashboard is configured via Puppet, and shows only capabilities
  that are known to work properly. Buttons, menu items etc. that
  doesn't work or provides capabilities that NREC doesn't offer are
  disabled in the dashboard.

``[PASS]`` **Security considerations**
  There are a few things that need to be considered (from `OpenStack Security Guide\: Management - Management interfaces`_):

  * The dashboard requires cookies and JavaScript to be enabled in the
    web browser.

    - **(FIXME FIXME FIXME)** The cookies are only used for the dashboard and are
      not used for tracking the user's activities beyond NREC.

  * The web server that hosts the dashboard should be configured for
    TLS to ensure data is encrypted.

    - **(pass):** TLS v1.2 or later is enforced.

  * Both the horizon web service and the OpenStack API it uses to
    communicate with the back end are susceptible to web attack
    vectors such as denial of service and must be monitored.

    - **(pass)** We have monitoring in place

  * It is now possible (though there are numerous deployment/security
    implications) to upload an image file directly from a user’s hard
    disk to OpenStack Image service through the dashboard. For
    multi-gigabyte images it is still strongly recommended that the
    upload be done using the glance CLI.

    - **(pass)** Image uploading is done directly to Glance via a
      redirect in dashboard.

  * Create and manage security groups through dashboard. The security
    groups allows L3-L4 packet filtering for security policies to
    protect virtual machines.

    - **(pass)** The default security group blocks everything. Users
      can edit security groups through the dashboard.


OpenStack API
~~~~~~~~~~~~~

``[PASS]`` **Security considerations**
  There are a few things that need to be considered (from `OpenStack Security Guide\: Management - Management interfaces`_):

  * The API service should be configured for TLS to ensure data is
    encrypted.

    - **(pass):** TLS v1.2 or later is enforced.

 * As a web service, OpenStack API is susceptible to familiar web
   site attack vectors such as denial of service attacks.

    - **(pass)** We have monitoring in place


Secure shell (SSH)
~~~~~~~~~~~~~~~~~~

``[N/A]`` **Host key fingerprints**
  Host key fingerprints should be stored in a secure and queryable
  location. One particularly convenient solution is DNS using SSHFP
  resource records as defined in RFC-4255. For this to be secure, it
  is necessary that DNSSEC be deployed.

  * Host keys are wiped periodically to avoid conflicts and ensure
    that reinstalled hosts function correctly. SSH access is done
    through a single entry point and host keys are not important.


Management utilities
~~~~~~~~~~~~~~~~~~~~

``[PASS]`` **Security considerations**
  There are a few things that need to be considered (from `OpenStack Security Guide\: Management - Management interfaces`_):

  * The dedicated management utilities (\*-manage) in some cases use
    the direct database connection.

    - **(pass)** We don't use dedicated management utilities unless
      strictly necessary

  * Ensure that the .rc file which has your credential information is
    secured.

    - **(pass)** Credential information is stored securely.


Out-of-band management interface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``[PASS]`` **Security considerations**
  There are a few things that need to be considered (from `OpenStack Security Guide\: Management - Management interfaces`_):

  * Use strong passwords and safeguard them, or use client-side TLS
    authentication.

    - **(pass)** We have strong passwords that are stored securely

  * Ensure that the network interfaces are on their own
    private(management or a separate) network. Segregate management
    domains with firewalls or other network gear.

    - **(pass)** OOB interfaces are on a private network

  * If you use a web interface to interact with the BMC/IPMI, always
    use the TLS interface, such as HTTPS or port 443. This TLS
    interface should NOT use self-signed certificates, as is often
    default, but should have trusted certificates using the correctly
    defined fully qualified domain names (FQDNs).

    - **(n/a)** OOB interfaces are on a closed network and trusted CA
      is not necessary.

  * Monitor the traffic on the management network. The anomalies might
    be easier to track than on the busier compute nodes.

    - **(n/a)** Not necessary due to closed network.
