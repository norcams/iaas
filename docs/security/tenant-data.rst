.. |date| date::

Tenant data privacy
===================

Last changed: |date|

.. contents::

.. _OpenStack Security Guide\: Tenant data privacy: http://docs.openstack.org/security-guide/tenant-data.html

+-------------------------+---------------------+
| **Impact**              | High                |
+-------------------------+---------------------+
| **Implemented percent** | **0%** (0/?)        |
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

``[DEFERRED]`` **Track, document and verify media sanitization and disposal actions**
  * OSL: Media are shredded before being disposed
  * BGO: unknown

``[DEFERRED]`` **Test sanitation equipment and procedures to verify proper performance**
  * OSL: Equipment has been properly tested
  * BGO: unknown

``[PASS]`` **Sanitize portable, removable storage devices prior to connecting such devices to the cloud infrastructure**
  * Portable, removable media are never connected to the cloud infrastructure

``[DEFERRED]`` **Destroy cloud system media that cannot be sanitized**
  * OSL: Media are destroyed using a shredder
  * BGO: unknown

Data not securely erased
""""""""""""""""""""""""

Regarding erasure of metadata, the security guide suggests using
database and/or system configuration for auto vacuuming and periodic
free-space wiping.

``[----]`` **Periodic database vacuuming**
  FIXME: Implement and document

``[----]`` **Periodic free-space wiping of ephemeral storage**
  FIXME: Implement and document

Instance memory scrubbing
"""""""""""""""""""""""""

.. _KVM documentation: http://www.linux-kvm.org/page/Memory

As we're using KVM, which relies on Linux page management, we need to
consult the `KVM documentation`_ about memory scrubbing.

``[----]`` **Consider automatic/periodic memory scrubbing**
  FIXME: Consult KVM doc, consider if this is needed and document

Cinder volume data
""""""""""""""""""

From OpenStack Security Guide:

  *Use of the OpenStack volume encryption feature is highly
  encouraged. This is discussed in the Data Encryption section
  below. When this feature is used, destruction of data is
  accomplished by securely deleting the encryption key.*

``[----]`` **Consider volume encryption**
  FIXME: This depends on the plugin used. Document this.

``[----]`` **Secure erasure of volume data**
  FIXME: Review and implement mechanisms that are feasible and
  applicable in our case.

Image service delay delete feature
""""""""""""""""""""""""""""""""""

From OpenStack Security Guide:

  *OpenStack Image service has a delayed delete feature, which will
  pend the deletion of an image for a defined time period. It is
  recommended to disable this feature if it is a security concern*

``[----]`` **Consider disabling delayed delete**
  FIXME: Consider if this is a security concern, and consider
  disabling the delayed delete feature

Compute soft delete feature
"""""""""""""""""""""""""""

From OpenStack Security Guide:

  *OpenStack Compute has a soft-delete feature, which enables an
  instance that is deleted to be in a soft-delete state for a defined
  time period. The instance can be restored during this time period.*

``[----]`` **Consider disabling compute soft delete**
  FIXME: Consider if this is a security concern, and consider
  disabling the soft delete feature

Compute instance ephemeral storage
""""""""""""""""""""""""""""""""""

From OpenStack Security Guide:

  *The creation and destruction of ephemeral storage will be somewhat
  dependent on the chosen hypervisor and the OpenStack Compute
  plug-in.*

``[----]`` **Document ephemeral storage deletion**
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

``[----]`` **Consider volume encryption**
  FIXME: Consider this and document

Ephemeral disk encryption
~~~~~~~~~~~~~~~~~~~~~~~~~

``[----]`` **Consider ephemeral disk encryption**
  FIXME: Consider this and document

Block Storage volumes and instance ephemeral filesystems
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``[----]`` **Consider which options we have available**
  FIXME: Document

``[----]`` **Consider adding encryption**
  FIXME: Consider and document

Network data
~~~~~~~~~~~~

``[----]`` **Consider encrypting tenant data over IPsec or other tunnels**
  FIXME: Consider and document


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

``[DEFERRED]`` **Consider adding Barbican**
  FIXME: Consider and document
