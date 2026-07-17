===========================
Disk setup on compute hosts
===========================

Compute host needs disk for the host OS (:file:`vg_root`) and for Openstack
instances (:file:`vg_ext` -> :file:`lv_instances`). This is true for all
NREC compute hosts!

Hosts running Ceph backed instances
-----------------------------------

If the compute host is configured to store the instances in Ceph you only need
200-300 GB for :file:`vg_ext` to store the base images. If the instances are
running of big snapshots we might need more.

For these hypervisors you almost never need to do anything with the node config
in :file:`himlarcli` or hieradata in :file:`himlar`. The disk will always be
:file:`sda`.

There is an exception for old hosts not using UEFI. These hosts will have one less
boot partition and therefor need to use :file:`sda3` instead of :file:`sda4` for
:file:`vg_ext`. This usually needs to be done in the node file for the instance.

Host running locally stored instances
-------------------------------------

Some compute hosts also stores the whole instance disk locally on the compute host.
These hosts usually have 2 or more disk. For newer linux distros including
Almalinux 9 there is an issue getting the disk in the same order on every boot.
The disk will appear in a random order :file:`sda`, :file:`sdb`, etc. This is
true both while installing with kickstart and every reboot after.

If the disk are of a different type (e.g. NVMe and SSD) they will show up as
:file:`nvme0n1` and :file:`sda`. Then you just have to set the correct
:file:`installdevice` in node config in :file:`himlarcli` and nothing more.

If the disk is called :file:`sda` and :file:`sdb` you need to fix this.

First we need to specify the :file:`wwn` path in for the :file:`installdevice`
in :file:`himlarcli` node config. E.g.
:file:`disk/by-id/wwn-0x64cd98f09c7cdd007615dee4bfc50161`. This will make sure
we install the OS on the correct disk.

The second is to make sure puppet use the correct disk to create :file:`vg_ext`.
To fix this there is two options and the first is the best:

#. As long ad the disks do not use the same kernel disk driver we can set the
  order the kernel modules are loaded to fix the issue. To see if this is possible
  first check if they are using the same disk controller. You can see this with::

    lsblk -S

  If they are using different controllers you can see the kernel module used with::

    lspci -k | less

  If one of them is :file:`ahci` you can use something like this in hieradata::

    profile::base::physical::load_ahci_first: true
    profile::base::physical::load_ahci_first_scsidrv: 'megaraid_sas'

  This will make sure the :file:`ahci` is loaded first.

#. If the disks use the same kernel driver you will need to use the :file:`wwn`
  number in hieradata to tell puppet which disk device you want to use::

    profile::base::lvm::physical_volume:
      '/dev/disk/by-id/wwn-0x64cd98f07c7cdd002d4fb2ffe3a37666':
        ensure: present
        force:  true
    profile::base::lvm::volume_group:
      'vg_ext':
        followsymlinks: true
        physical_volumes:
          - '/dev/disk/by-id/wwn-0x64cd98f07c7cdd002d4fb2ffe3a37666'
