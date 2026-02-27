===========
Persistence
===========

Operate instance
================

Snapshot instance (warm / running + cold / shutoff)

Snapshot instance (warm / running + cold / shutoff) with attached volume(s)

Power off / stop and power on / start instance

2026-02-11: The reason for suspend / resume disabled is due to it preventing live migration
(Skipped, since Policy doesn't allow os_compute_api:os-suspend-server:suspend to be performed 2026-02-10) Suspend / hibernate and resume instance (suspend to disk)

Pause and unpause instance (suspend to RAM)

New instance from snapshot

Snapshot volume

Download instance snapshot

Download volume snapshot

Update instance packages

Remove IPv4 and IPv6 ICMP+SSH security group rules to instance and verify

Add IPv4 and IPv6 ICMP+SSH security group rules to instance and verify

Verify QEMU guest agent is running

Install secondary pubkey to cloud user and use to login SSH

Install secondary SSH user and pubkey in instance and use to login SSH

Set root password with --password and verify

Note! Rebuild is verified to hang if volume(s) are attached to the instance prior to running the rebuild command. However, resize works with volumes attached (test01 2026-02-10).

Rebuild instance with user data to change root password and verify

Rebuild instance from snapshot and login SSH

Rebuild instance with new pubkey and login SSH

Resize instance to another flavor within the same aggregate with volumes attached

Note! Changing volume type (re-type) while attached is not allowed. An error message will be shown (2026-02-10 test01)

Change volume type (re-type) while attached / unattached:

  * mass-storage-default <-> rbd
  * mass-storage-default <-> mass-storage-ssd
  * rbd <-> mass-storage--ssd

Shelve instance

Unselve shelved instance

Backup & Restore instance

Backup instance (warm / running + cold / shutoff)

Backup instance (warm / running + cold / shutoff) with attached volume(s)

Download and Upload instance snapshot and backup image file

Download:

Download raw and qcow2 image to file using openstack cli and glanceclient

Upload:

Create image from file using openstack cli: openstack image create --file

Create image from file using glanceclient: glance image-create --file

TODO: Create image from file to existing image ID using glanceclient: glance image-uplaod --file ID

Rebuld instance from uploaded image: openstack server rebuild --image

TODO: Rebuld instance from uploaded image and preserve root disk: openstack server rebuild --image --preserve-ephermal

Operate volume
==============

TODO: Backup & Restore volume using volume backup service:

TODO: Backup volume: openstack volume backup create (incremental and not)

TODO: Backup volume when attached / in-use: openstack volume backup create --force

TODO: Backup volume from snapshot: openstack volume backup create --snapshot

TODO: Backup volume from snapshot when volume attached: openstack volume backup create --snapshot --force

TODO: Convert volume snapshot to volume

TODO: Restore volume backup to volume

Create qcow2 image from volume

Download and Upload image backup of volume

Download:

Same as with operating instance

Upload:

Create image from file using openstack cli: openstack image create --file

Create image from file using glanceclient: glance image-create --file

#Create image from file to existing image ID using glanceclient: glance image-uplaod --file ID

Create image from volume when volume not attached: openstack image create --volume

Create volume from image: openstack volume create --image

TODO: Create volume from snapshot: openstack volume create --snapshot

TODO: Clone volume: openstack volume create --source

TODO: Revert a volume from snapshot (in-place)

TODO: Create volume from backup: openstack volume create --backup --os-volume-api-version 3.47

Create volume snapshot from volume: openstack volume snapshot create --volume

TODO: Create volume snapshot from volume when attached: openstack volume snapshot create --volume --force

TODO: Create volume backup from snapshot of volume: openstack volume backup create --snapshot

TODO: Create volume backup from snapshot of volume when volume in-use: openstack volume backup create --snapshot --force

TODO: Restore volume backup to volume

TOOD: Restore volume backup to volume while volume attached: openstack volume backup restore --force

Operate Object Storage
======================

TODO: Backup & Restore object

