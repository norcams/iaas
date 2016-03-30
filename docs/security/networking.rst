.. |date| date::

==========
Networking
==========

Last changed: |date|

.. contents::
.. section-numbering::

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
