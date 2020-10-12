==============================================
NREC instance with root device larger than 2TB
==============================================

For the time being it is not possible to configure instances with UEFI boot. For example, the
GOLD images would need to have an EFI partition for UEFI boot to work. For corner cases where
we need a root device larger than 2TB, it's possible to do a one time job in a newly launched
instance in order to get a large root partition.

First, launch an instance with a flavor with large instance disk, then log into the instance
and perform the following (this example is for CentOS 7):

.. code:: bash

    yum install -y gdisk
    gdisk /dev/sda

The following commands must be done manually:

.. code:: bash

    n (for "new partition")
    enter (for Partition number)
    34 (for "First sector")
    enter (for "Last sector")
    ef02 (for "Hex code or GUID")
    w (in order to save changes)
    y (to proceed)

then the following commands must be executed:

.. code:: bash

    partprobe /dev/sda
    grub2-install /dev/sda
    shutdown -r now

After rebooting the instance, log into it again and observe the now large root file system.
