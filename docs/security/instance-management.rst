.. |date| date::

============================
Instance security management
============================

Last changed: |date|

.. contents::
.. section-numbering::

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

