===========
Persistence
===========

Snapshot instance (cold / shutoff + warm / running)

Snapshot instance (cold / shutoff + warm / running) with attached volume

Shutoff and resume instance

Pause and resume instance

New instance from snapshot

Snapshot volume

Download instance snapshot

Download volume snapshot

Update instance packages

Read from attached volume

Write to attached volume


Live networking:

Remove IPv4 and IPv6 ICMP security group rule to instance and verify

Add IPv4 and IPv6 ICMP security group rule to instance and verify


Verify QEMU guest agent is running


Modify instance while running:

Install secondary pubkey to cloud user and use to login SSH

Install secondary user and pubkey in instance and use to login SSH

Set root password with --password and verify


Modify instance while preserving network:

Rebuild instance with user data to change root password and verify

Rebuild instance from snapshot and login SSH

Rebuild instance with new pubkey and login SSH

Resize instance to another flavor within the same aggregate


Change volume type while attached / unattached:

  * mass-storage-default <-> rbd
  * mass-storage-default <-> mass-storage-ssd
  * rbd <-> mass-storage--ssd


