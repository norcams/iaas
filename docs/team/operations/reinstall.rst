====================
Reinstall hypervisor
====================

Last changed: 2022-08-02

This describes reinstall of hypervisor with VMs with local storage (e.g.
controllers and compute with local storage).

* Stop running VMs with himlarcli, openstack cli or virsh

* Mount cephfs with ansible :file:`cephfs_mount.yaml`

* Create backup directory in :file:`/cephfs/<host>`

* Backup the disks of all VMs (:file:`/var/lib/nova/instances` or :file:`/var/lib/libvirt/images`).
  Example::

    rsync -Pav --sparse --exclude swapfile /var/lib/nova/instances/* /cephfs/<host>

* For controller only: backup domxml from :file:`/etc/libvirt/qemu/<nodename>.xml`
  to :file:`/cephfs/<host>`

* Check backup with md5sum (optional)

* Unmount cephfs with ansible :file:`cephfs_mount.yaml`

* Reinstall hypervisor

* Make sure puppet runs without error

* Mount cephfs

* Restore disk (and domxml for controller)

* Start VMs
