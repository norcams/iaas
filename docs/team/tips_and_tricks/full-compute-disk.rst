=========================================
NREC compute host with full instance disk
=========================================

Can only happen on compute node with instances with local os-disk,
e.g. atlas, alice, shpc, vgpu, etc

#. backup the smalles disk to cephfs
#. delete the disk for the instance with disk backup
#. run :file:`virsh destroy <dom>`
#. resume the rest of the instances
#. fstrim (ansible or virsh domfstrim) the rest of the instances
#. copy back the disk from cephfs
#. start the destroyed instance with openstack cli

It will take 1-2 hours to fix a alice compute node with 180GB os-disk.

Alternative approach
--------------------

There is a 10G swapfile in /var/lib/nova/instances. Free up some space with:

.. code:: bash

    puppet agent --disable "temp remove swap"
    swapoff -v /var/lib/nova/instances/swapfile
    rm -f /var/lib/nova/instances/swapfile

fstrim instances to free up space

.. code:: bash

      dd if=/dev/zero of=/var/lib/nova/instances/swapfile bs=1024 count=10485760
      chmod 600 /var/lib/nova/instances/swapfile
      mkswap /var/lib/nova/instances/swapfile
      swapon /var/lib/nova/instances/swapfile
      swapon --show
      puppet agent --enable
