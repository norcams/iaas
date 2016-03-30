.. |date| date::

Block Storage
=============

Last changed: |date|

.. contents::

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
