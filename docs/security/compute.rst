.. |date| date::

Compute
=======

Last changed: |date|

.. contents::

.. _OpenStack Security Guide\: Compute: http://docs.openstack.org/security-guide/compute.html

+-------------------------+---------------------+
| **Impact**              | High                |
+-------------------------+---------------------+
| **Implemented percent** | **78%** (0/9)       |
+-------------------------+---------------------+

From `OpenStack Security Guide\: Compute`_:

  *The OpenStack Compute service (nova) is one of the more complex
  OpenStack services. It runs in many locations throughout the cloud
  and interacts with a variety of internal services. The OpenStack
  Compute service offers a variety of configuration options which may
  be deployment specific. In this chapter we will call out general
  best practice around Compute security as well as specific known
  configurations that can lead to security issues. In general, the
  nova.conf file and the /var/lib/nova locations should be
  secured. Controls like centralized logging, the policy.json file,
  and a mandatory access control framework should be
  implemented. Additionally, there are environmental considerations to
  keep in mind, depending on what functionality is desired for your
  cloud.*


Hypervisor selection
--------------------

.. _OpenStack Security Guide\: Compute - Hypervisor selection: http://docs.openstack.org/security-guide/compute/hypervisor-selection.html

Ref: `OpenStack Security Guide\: Compute - Hypervisor selection`_

We are using KVM.


Hardening the virtualization layers
-----------------------------------

.. _OpenStack Security Guide\: Compute - Hardening the virtualization layers: http://docs.openstack.org/security-guide/compute/hardening-the-virtualization-layers.html

Ref: `OpenStack Security Guide\: Compute - Hardening the virtualization layers`_

Physical hardware (PCI passthrough)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``[N/A]`` **Ensure that the hypervisor is configured to utilize IOMMU**

``[PASS]`` **Disable PCI passthrough**

Minimizing the QEMU code base
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Does not apply. We are using precompiled QEMU.

Compiler hardening
~~~~~~~~~~~~~~~~~~

Does not apply. We are using precompiled QEMU.

Mandatory access controls
~~~~~~~~~~~~~~~~~~~~~~~~~

``[DEFERRED]`` **Ensure SELinux / sVirt is running in Enforcing mode**
A device ACL for the instance virtual network interfaces needs review, but risk is assumed to be low.


How to select virtual consoles
------------------------------

.. _OpenStack Security Guide\: Compute - How to select virtual consoles: http://docs.openstack.org/security-guide/compute/how-to-select-virtual-consoles.html

Ref: `OpenStack Security Guide\: Compute - How to select virtual consoles`_

``[PASS]`` We run SSL hardened spice console


Checklist
---------

.. _OpenStack Security Guide\: Compute - Checklist: http://docs.openstack.org/security-guide/compute/checklist.html

Ref: `OpenStack Security Guide\: Compute - Checklist`_

See the above link for info about these checks.

``[PASS]`` **Check-Compute-01: Is user/group ownership of config files set to root/nova?**
  Yes

``[PASS]`` **Check-Compute-02: Are strict permissions set for configuration files?**
  Yes

``[PASS]`` **Check-Compute-03: Is keystone used for authentication?**
  Yes

``[PASS]`` **Check-Compute-04: Is secure protocol used for authentication?**
  Yes?

``[DEFERRED]`` **Check-Compute-05: Does Nova communicate with Glance securely?**
  Nova communicates with glance on a private network for now, but TLS is in the pipeline.
