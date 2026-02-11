===========
Persistence
===========

VM image:

Upload and download a VM image

VM instance:

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


Live networking:

Remove IPv4 and IPv6 ICMP+SSH security group rules to instance and verify

Add IPv4 and IPv6 ICMP+SSH security group rules to instance and verify


Verify QEMU guest agent is running


Modify instance while running:

Install secondary pubkey to cloud user and use to login SSH

Install secondary SSH user and pubkey in instance and use to login SSH

Set root password with --password and verify


Modify instance while preserving network:

Given no volumes attached:

Note! Rebuild is verified to hang if volume(s) are attached to the instance prior to running the rebuild command. However, resize works with volumes attached (test01 2026-02-10).

Rebuild instance with user data to change root password and verify

Rebuild instance from snapshot and login SSH

Rebuild instance with new pubkey and login SSH

Resize instance to another flavor within the same aggregate

Note! Changing volume type while attached is not allowed. An error message will be shown (2026-02-10 test01)

Change volume type while attached / unattached:

  * mass-storage-default <-> rbd
  * mass-storage-default <-> mass-storage-ssd
  * rbd <-> mass-storage--ssd


Save instance for later while freeing resources:

Shelve instance

Unselve shelved instance

