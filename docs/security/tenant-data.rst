.. |date| date::

[2021] Tenant data privacy
==========================

``REVISION 2021-10-20``

.. contents::

.. _OpenStack Security Guide\: Tenant data privacy: http://docs.openstack.org/security-guide/tenant-data.html

+-------------------------+---------------------+
| **Impact**              | High                |
+-------------------------+---------------------+
| **Implemented percent** | **55%** (10/18)     |
+-------------------------+---------------------+

From `OpenStack Security Guide\: Tenant data privacy`_:

  *OpenStack is designed to support multitenancy and those tenants will
  most probably have different data requirements. As a cloud builder
  and operator you need to ensure your OpenStack environment can
  address various data privacy concerns and regulations.*


Data privacy concerns
---------------------

.. _OpenStack Security Guide\: Tenant data privacy - Data privacy concerns: http://docs.openstack.org/security-guide/tenant-data/data-privacy-concerns.html

Ref: `OpenStack Security Guide\: Tenant data privacy - Data privacy concerns`_

Data residency
~~~~~~~~~~~~~~

From OpenStack Security Guide:

  *Numerous OpenStack services maintain data and metadata belonging to
  tenants or reference tenant information.*

  *Tenant data stored in an OpenStack cloud may include the following items:*
  - *Object Storage objects*
  - *Compute instance ephemeral filesystem storage*
  - *Compute instance memory*
  - *Block Storage volume data*
  - *Public keys for Compute access*
  - *Virtual machine images in the Image service*
  - *Machine snapshots*
  - *Data passed to OpenStack Compute’s configuration-drive extension*

  *Metadata stored by an OpenStack cloud includes the following non-exhaustive items:*
  - *Organization name*
  - *User’s “Real Name”*
  - *Number or size of running instances, buckets, objects, volumes, and other quota-related items*
  - *Number of hours running instances or storing data*
  - *IP addresses of users*
  - *Internally generated private keys for compute image bundling*

Data disposal
~~~~~~~~~~~~~

From OpenStack Security Guide:

  *OpenStack operators should strive to provide a certain level of
  tenant data disposal assurance. Best practices suggest that the
  operator sanitize cloud system media (digital and non-digital) prior
  to disposal, release out of organization control or release for
  reuse. Sanitization methods should implement an appropriate level of
  strength and integrity given the specific security domain and
  sensitivity of the information.*

The security guide states that the cloud operators should do the
following:

``[PASS]`` **Track, document and verify media sanitization and disposal actions**
  * OSL: Media are shredded before being disposed
  * BGO: Media are shredded before being disposed

``[PASS]`` **Test sanitation equipment and procedures to verify proper performance**
  * OSL: Equipment has been properly tested
  * BGO: Equipment has been properly tested

``[N/A]`` **Sanitize portable, removable storage devices prior to connecting such devices to the cloud infrastructure**
  * Portable, removable media are never connected to the cloud infrastructure

``[PASS]`` **Destroy cloud system media that cannot be sanitized**
  * OSL: Media are destroyed using a shredder
  * BGO: Media destruction is contracted to external provider

Data not securely erased
""""""""""""""""""""""""

Regarding erasure of metadata, the security guide suggests using
database and/or system configuration for auto vacuuming and periodic
free-space wiping.

``[DEFERRED]`` **Periodic database vacuuming**
  Not implemented at this time. We will revisit this at a later time.

``[FAIL]`` **Periodic free-space wiping of ephemeral storage**
  Most instances are hosted on a centralized, object based storage
  system (ceph) with no physical or logical access to an underlying
  block based storage. For specialized instances (vGPU, HPC, sHPC etc)
  with instance disk hosted locally on the hypervisor in QCOW2 files
  the risk is considered to be acceptable

Instance memory scrubbing
"""""""""""""""""""""""""

.. _KVM documentation: http://www.linux-kvm.org/page/Memory

As we're using KVM, which relies on Linux page management, we need to
consult the `KVM documentation`_ about memory scrubbing.

``[FAIL]`` **Consider automatic/periodic memory scrubbing**
  We rely on the KVM defaults for memory management and scrubbing

Cinder volume data
""""""""""""""""""

From OpenStack Security Guide:

  *Use of the OpenStack volume encryption feature is highly
  encouraged. This is discussed in the Data Encryption section
  below. When this feature is used, destruction of data is
  accomplished by securely deleting the encryption key.*

``[FAIL]`` **Consider volume encryption**
  Not considered to be essential at this time

``[PASS]`` **Secure erasure of volume data**
  Ceph will automatically erase the objects within a volume when the
  volume is deleted

Image service delay delete feature
""""""""""""""""""""""""""""""""""

From OpenStack Security Guide:

  *OpenStack Image service has a delayed delete feature, which will
  pend the deletion of an image for a defined time period. It is
  recommended to disable this feature if it is a security concern*

``[PASS]`` **Consider disabling delayed delete**
  Considered, we don't think this is a security concern.

Compute soft delete feature
"""""""""""""""""""""""""""

From OpenStack Security Guide:

  *OpenStack Compute has a soft-delete feature, which enables an
  instance that is deleted to be in a soft-delete state for a defined
  time period. The instance can be restored during this time period.*

``[PASS]`` **Consider disabling compute soft delete**
  Considered, we don't think this is a security concern.

Compute instance ephemeral storage
""""""""""""""""""""""""""""""""""

From OpenStack Security Guide:

  *The creation and destruction of ephemeral storage will be somewhat
  dependent on the chosen hypervisor and the OpenStack Compute
  plug-in.*

``[DEFERRED]`` **Document ephemeral storage deletion**
  FIXME: Document how this works in our environment


Data encryption
---------------

.. _OpenStack Security Guide\: Tenant data privacy - Data encryption: http://docs.openstack.org/security-guide/tenant-data/data-encryption.html

From `OpenStack Security Guide\: Tenant data privacy - Data encryption`_:

  *The option exists for implementers to encrypt tenant data wherever
  it is stored on disk or transported over a network, such as the
  OpenStack volume encryption feature described below. This is above
  and beyond the general recommendation that users encrypt their own
  data before sending it to their provider.*

Volume encryption
~~~~~~~~~~~~~~~~~

``[PASS]`` **Consider volume encryption**
  Considered.

Ephemeral disk encryption
~~~~~~~~~~~~~~~~~~~~~~~~~

``[PASS]`` **Consider ephemeral disk encryption**
  Considered.

Block Storage volumes and instance ephemeral filesystems
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``[DEFERRED]`` **Consider which options we have available**
  FIXME: Consider and Document

``[PASS]`` **Consider adding encryption**
  Considered.

Network data
~~~~~~~~~~~~

``[PASS]`` **Consider encrypting tenant data over IPsec or other tunnels**
  Considered. Not a security concern in our case.


Key management
--------------

.. _OpenStack Security Guide\: Tenant data privacy - Key management: http://docs.openstack.org/security-guide/tenant-data/key-management.html

From `OpenStack Security Guide\: Tenant data privacy - Key management`_:

  *The volume encryption and ephemeral disk encryption features rely
  on a key management service (for example, barbican) for the creation
  and secure storage of keys. The key manager is pluggable to
  facilitate deployments that need a third-party Hardware Security
  Module (HSM) or the use of the Key Management Interchange Protocol
  (KMIP), which is supported by an open-source project called PyKMIP.*

``[PASS]`` **Consider adding Barbican**
  Considered. We will not add Barbican at this time
