===========
Persistence
===========

Snapshot instance (warm / running + cold / shutoff)

Snapshot instance (warm / running + cold / shutoff) with attached volume(s)

Power off / stop and power on / start instance

Suspend / hibernate and resume instance (suspend to disk)

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


Save instance for later while freeing resources:

Shelve running instance

Unselve shelved instance

