==============================================
Extend disk in libvirt
==============================================

Start with finding out disk device and current size on the VM and if it is a LVM disk then also check LV name.
This to corelate with later step. 


Then on the host (e.g. bgo-controller.08) check if libguestfs-tools is installed, if not snag it. 

.. code:: bash

   yum install libguestfs-tools

You'll need the disk image name for the VM disk you want to extend. 

Check the disk size and names in the image

.. code:: bash 

   virt-filesystems --long --parts --blkdevs -h -a /var/lib/libvirt/images/bgo-admin-01.qcow2

   Name       Type       MBR  Size  Parent                                                                                                                                                                                                                                                   
   /dev/sda1  partition  83   512M  /dev/sda                                                                                                                                                                                                                                                 /dev/sda2  partition  8e   10G   /dev/sda                                                                                                                                                                                                                                                 /dev/sda3  partition  8e   9.5G  /dev/sda                                                                                                                                                                                                                                                 /dev/sda   device     -    30G   -

Even if the device is named e.g. /dev/vda in the VM use the names from the prevoius command. 

Time do the magic, we want 10GB more disk on the /dev/vg_root/lv_root disk. 

.. code:: bash 
   
   qemu-img resize /var/lib/libvirt/images/bgo-admin-01.qcow2 +10G

   cd /var/lib/libvirt/images/ 

   virt-resize --expand /dev/sda2 --LV-expand /dev/vg_root/lv_root bgo-admin-01.qcow2 bgo-admin-01-newdisk.qcow2


   mv bgo-admin-01.qcow2 bgo-admin-01.qcow2.old; mv bgo-admin-01-newdisk.qcow2 bgo-admin-01.qcow2


If everyting went smootly then start the VM anew. 
