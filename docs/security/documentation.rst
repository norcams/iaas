.. |date| date::

[2019] System documentation
===========================

``REVISION 2019-02-21``

.. contents::

+-------------------------+---------------------+
| **Impact**              | Low                 |
+-------------------------+---------------------+
| **Implemented percent** | **75%** (3/4)       |
+-------------------------+---------------------+

System Inventory
----------------

.. _OpenStack Security Guide\: System documentation: http://docs.openstack.org/security-guide/documentation.html
.. _Physical hardware: ../design/physical-hardware.html#
.. _Virtual machines: ../design/virtual-machines.html
.. _Networking overview: ../design/physical-hardware.html#networking-overview

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
  A high-level view of the hardware inventory is outlined in the
  document `Physical hardware`_.

``[PASS]`` **Software inventory**
  A high-level view of the software inventory is outlined in the
  document `Virtual machines`_.

``[PASS]`` **Network topology**
  A high-level view of the network topology is outlined in the
  document `Networking overview`_.

``[DEFERRED]`` **Services, protocols and ports**
  FIXME
