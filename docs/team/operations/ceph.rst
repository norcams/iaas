
=========================
Practical ceph operations
=========================

This document aims to describe ceph-related operations in NREC, without detracting from the magic of ceph.

It is always interesting to keep an eye on the state of ceph, use ``ceph -w`` or ``watch ceph status``.

Replace a borked drive
----------------------

At this stage we assume that the OSD is in the "down" state, puppet is disabled on the storage host, and the cluster is stable without any degraded PGs - all data is rebuilt on other OSDs.

.. code:: bash

  # not really necessary, but can prevent small accidents from developing into suboptimal and murky chain reactions
  ceph osd set noout
  # if the drive is marked as down and in the cluster, do not rebalance the cluster untill a new drive is ready
  ceph osd set norebalance
  puppet agent -t   # check if puppet is disabled (it should be)

Need to find the /dev-name and the physical device matching the osd.

#. Find volume group and device (take notes)::

    ceph-volume lvm list <osd-id>

#. Find the physical device, On iDrac, use the filter functionality found in the storage overview to find the pysical location of the drive. Storage -> Physical Disks -> Filter Drives/Options::

    hdparm -I /dev/<device from step 1>    

#. Delete osd::

    ceph osd purge <osd-id> --yes-i-really-mean-it

#. Check if volume groupe is removed, if not, remove the volume group::

    vgscan | grep <volume group from step 1.>
    vgremove ceph-aaaabbbb-1234-5678-abcd-fefefafaffff

#. Check if the OSDs service is enabled, if not, disable it::

    systemctl list-units | grep <osd-id>
    systemctl disable ceph-osd@<osd-id>.service

#. Now it is time to physically replace the drive. Summon your minions.

#. If the new disk has a new /dev/-name, usually the last alphabetically of all your drives, the server needs a reboot. *noout* must be set before restarting.::

    rescan-scsi-bus.sh
    lsblk

#. After a reboot, when the cluster is stable, or if no reboot was necessary::

    puppet agent --enable; puppet agent -t
    ceph osd unset norebalance
    ceph osd unset noout


backfill backfill_tofull
------------------------

To avoid this hopelessness in the long run – add more storage when possible and plan for balanced pools.

Hovewer, in the short term:

Find the fullest OSDs, and if the storage capacity on these is less than the average drive in the pool, try doing some reweig:

.. code:: bash

  # list tofull SSDs
  ceph osd df |grep ssd |grep -v down | awk '{ if ($17>80) {print $17 "%, osd." $1 } }'
  # for current REWEIGHT
  cehp osd tree
  ceph osd reweight <full osd.id> <value less than current>



inconsistent PGs
----------------

Find the pg and repair it.

.. code:: bash

  cephmon# ceph health detail
  HEALTH_ERR 1 scrub errors; Possible data damage: 1 pg inconsistent
  [ERR] OSD_SCRUB_ERRORS: 1 scrub errors
  [ERR] PG_DAMAGED: Possible data damage: 1 pg inconsistent
     pg 49.f47 is active+clean+inconsistent, acting [446,214,1071,503,598,781,1045,110,993,997]

  cephmon# ceph pg repair 49.f47

If this does not work - restart the primary OSD. In pg 49.f47 the primary osd is 446 - ref ``ceph health detail``. Use ``ceph osd find 446``. And on the host ``systemctl restart ceph-osd@446``

If that doesn't solve the problem. Dig a rabbit hole. Start by digging into the log of the primary OSD
