.. |date| date::

Instance security management
============================

Last changed: |date|

.. contents::

.. _OpenStack Security Guide\: Instance security management: http://docs.openstack.org/security-guide/instance-management.html

+-------------------------+---------------------+
| **Impact**              | High                |
+-------------------------+---------------------+
| **Implemented percent** | **100%** (6/6)      |
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

``[PASS]`` **Consider adding hardware random number generators (HRNG)**
  We do not consider HRNG necessary for a deployment of this scale. This
  may be revisited in the future.


Scheduling instances to nodes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

From OpenStack Security Guide:

  *Before an instance is created, a host for the image instantiation
  must be selected. This selection is performed by the nova-scheduler
  which determines how to dispatch compute and volume requests.*

``[PASS]`` **Describe which scheduler and filters that are used**
  For now, we use the default nova scheduling filters, and all compute
  hosts are considered equal in features and performance. This will
  change in the future if the need arise for more specialized resources.


Trusted images
~~~~~~~~~~~~~~

From OpenStack Security Guide:

  *In a cloud environment, users work with either pre-installed images
  or images they upload themselves. In both cases, users should be
  able to ensure the image they are utilizing has not been tampered
  with.*

``[PASS]`` **Maintain golden images**
  We provide updated upstream cloud images for popular linux distributions.
  Other operating system golden images will be evaluated.

``[N/A]`` **Consider enabling instance signature verification**
  For now, this is beyond the scope of the project.


Instance migrations
~~~~~~~~~~~~~~~~~~~

``[PASS]`` **Disable live migration**
  Live migration is not available in our deployment. For now, the instances
  have to be cold migrated. This is an admin only task, used mainly in
  conjunction with reinstallation of compute hosts.


Monitoring, alerting, and reporting
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``[PASS]`` **Aggrgate logs, e.g. to ELK**
  Compute host logs are sent to an ELK stack.
