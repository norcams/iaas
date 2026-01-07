Dangling Volume Attachment Remedy
=================================

This document describes how to resolve a dangling volume attachment in OpenStack
*without directly modifying the database*, by refreshing the volume attachment
connector information using ``nova-manage``.

This approach is useful when a volume appears attached in Nova but cannot be
detached due to inconsistent attachment state between Nova and Cinder.

Prerequisites
-------------

You need:

* Administrative access to OpenStack
* Access to the hypervisor hosting the instance
* Access to a node where ``nova-manage`` can be executed (typically a controller
  or compute node)

Identify Server and Volume UUIDs
--------------------------------

First, identify the **server UUID** and **volume UUID**. This can be achieved in
multiple ways using OpenStack tools such as ``openstackclient``.

If you already know the server UUID, you can list attached volumes with:

::

  openstack server volume list <server_uuid>

Example output:

::

  +----------+--------------------------------------+--------------------------------------+------+------------------------+--------------------------------------+--------------------------------------+
  | Device   | Server ID                            | Volume ID                            | Tag  | Delete On Termination? | Attachment ID                        | BlockDeviceMapping UUID              |
  +----------+--------------------------------------+--------------------------------------+------+------------------------+--------------------------------------+--------------------------------------+
  | /dev/sdb | 03549f61-9cee-4bdf-b5e9-39c18d815a06 | 4abf2cfe-5208-47bb-9a72-15114a722113 | None | False                  | 7d879965-997d-47c2-ae7a-2bdb2aad320d | 51b3a6c0-7787-452c-a5ae-0a0b5e16b11b |
  +----------+--------------------------------------+--------------------------------------+------+------------------------+--------------------------------------+--------------------------------------+

From this output, note the following values:

* Server UUID
* Volume UUID
* Attachment ID (if present)

Retrieve Connector Information from the Hypervisor
--------------------------------------------------

Next, retrieve the connector information from the **hypervisor where the instance
is currently running**. This information is required to refresh the volume
attachment.

Log in to the hypervisor and run:

::

  nova-manage volume_attachment get_connector --json

Save the output to a file (for example ``connector.json``). This data will be
used in the next step.

.. note::

   The connector information reflects the actual storage connectivity of the
   compute host (for example iSCSI initiators, FC WWPNs, or multipath settings).
   Mismatches here are a common cause of dangling attachments.

Refresh the Volume Attachment
-----------------------------

Log in to a node where ``nova-manage`` is available (typically a controller node
or the same compute node).

Run the following command, using the server UUID, volume UUID, and the connector
file obtained in the previous step:

::

  nova-manage volume_attachment refresh \
    03549f61-9cee-4bdf-b5e9-39c18d815a06 \
    4abf2cfe-5208-47bb-9a72-15114a722113 \
    connector.json

This forces Nova to refresh the attachment metadata and re-synchronize with
Cinder.

After this step, normal volume operations (such as detach) should work again.

Detach the Volume (if Required)
-------------------------------

If the original issue was the inability to detach the volume, you should now be
able to do so normally:

::

  openstack server remove volume <server_uuid> <volume_uuid>

Verification and Useful Commands
--------------------------------

On the hypervisor, you can verify volume attachments at the libvirt level with:

::

  virsh domblklist instance-XXXXXXX

Example output:

::

  Target   Source
  -----------------------------------------------------------------------------
  sda      /var/lib/nova/instances/03549f61-9cee-4bdf-b5e9-39c18d815a06/disk
  sdb      volumes/volume-4abf2cfe-5208-47bb-9a72-15114a722113

Optional: Detaching Directly via Libvirt
----------------------------------------

.. warning::

   Detaching disks directly via libvirt is **not recommended** as a normal
   operational procedure. This method should only be used during troubleshooting
   when standard OpenStack workflows are not functioning.

Example:

::

  virsh detach-disk instance-000094b0 sdb --persistent

Expected output:

::

  Disk detached successfully
