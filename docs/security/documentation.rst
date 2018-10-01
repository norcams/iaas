.. |date| date::

System documentation
====================

Last changed: |date|

.. contents::

+-------------------------+---------------------+
| **Impact**              | Low                 |
+-------------------------+---------------------+
| **Implemented percent** | **25%** (1/4)       |
+-------------------------+---------------------+

System Inventory
----------------

.. _OpenStack Security Guide\: System documentation: http://docs.openstack.org/security-guide/documentation.html
.. _Physical hardware: ../design/physical-hardware.html

From `OpenStack Security Guide\: System documentation`_:

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

``[PASS]`` **Hardware inventory**
  A high-level view of the hardware inventory is documented in the
  document `Physical hardware`_.

``[----]`` **Software inventory**
  FIXME

``[----]`` **Network topology**
  FIXME

``[----]`` **Services, protocols and ports**
  FIXME
