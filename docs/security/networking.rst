.. |date| date::

Networking
==========

``REVISION 2019-03-14``

.. contents::

.. _OpenStack Security Guide\: Networking: http://docs.openstack.org/security-guide/networking.html

+-------------------------+---------------------+
| **Impact**              | High                |
+-------------------------+---------------------+
| **Implemented percent** | **85%** (12/14)     |
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

``[PASS]`` **Use Neutron for security groups**
  The calico neutron network plugin provides a rich security feature set.
  Calico uses neutron security groups and implements the rules with
  iptables on the compute hosts. Thus, security rulesets can be described
  down to instance level.

Networking services security best practices
-------------------------------------------

.. _OpenStack Security Guide\: Networking - Networking services security best practices: http://docs.openstack.org/security-guide/networking/securing-services.html

Ref: `OpenStack Security Guide\: Networking - Networking services security best practices`_

``[PASS]`` **Document how Calico is used in UH-IaaS infrastructure**
  We enable the calico plugin as the neutron core plugin system wide. Thus, no L2
  connectivity is provided between instances, and as a design feature, no project
  isolation on L3 connectivity. In other words, there is no such thing as a
  private network, even for RFC 1918 address spaces. This design relies on
  security groups to provide isolation and pr project security.

``[N/A]`` **Document which security domains have access to OpenStack network node**
  As a consequence of our network design, no network nodes are deployed.

``[N/A]`` **Document which security domains have access to SDN services node**
  We do not use SDN service nodes.

OpenStack Networking service configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``[PASS]`` **Restrict bind address of the API server: neutron-server**
  Neutron API servers is bound to interal network only. 


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

``[PASS]`` **Evaluate network policy**
  User creation of networks, virtual routers and networks is prohibited by
  policy. Only administrator created networking resources are available
  for projects and users. 

Security groups
~~~~~~~~~~~~~~~

  *``nova.conf`` should always disable built-in security groups and
  proxy all security group calls to the OpenStack Networking API when
  using OpenStack Networking.*

``[PASS]`` **Set firewall_driver option in nova.conf**
  **firewall_driver** is set
  to **nova.virt.firewall.NoopFirewallDriver** so that nova-compute
  does not perform iptables-based filtering itself.

``[FAIL]`` **Set security_group_api option in nova.conf**
  It is recommended that **security_group_api** is set to neutron so
  that all security group requests are proxied to the OpenStack
  Networking service.

  We do not set the **security_group_api** option at all.

Quotas
~~~~~~

``[N/A]`` **Document choices wrt. networking quotas**
  As users can not create networking resources, no quotas apply.


Checklist
---------

.. _OpenStack Security Guide\: Networking - Checklist: http://docs.openstack.org/security-guide/networking/checklist.html

Ref: `OpenStack Security Guide\: Networking - Checklist`_

See the above link for info about these checks.

``[PASS]`` **Check-Neutron-01: Is user/group ownership of config files set to root/neutron?**
  Yes

``[PASS]`` **Check-Neutron-02: Are strict permissions set for configuration files?**
  Yes

``[PASS]`` **Check-Neutron-03: Is keystone used for authentication?**
  Yes

``[PASS]`` **Check-Neutron-04: Is secure protocol used for authentication?**
  Yes

``[FAIL]`` **Check-Neutron-05: Is TLS enabled on Neutron API server?**
  The negative implications for the user experience by implementing
  this is considered to outweight the extra security gained by this.
