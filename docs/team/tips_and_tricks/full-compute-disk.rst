=========================================
NREC compute host with full instance disk
=========================================

Can only happen on compute node with instances with local os-disk,
e.g. atlas, alice, shpc, vgpu, etc

Quick fix
---------

There is a 10G swapfile in /var/lib/nova/instances. Free up some space with and run fstrim with:

.. code:: bash

    puppet agent --disable "temp remove swap"
    swapoff -v /var/lib/nova/instances/swapfile
    rm -f /var/lib/nova/instances/swapfile
    virsh resume <instance-name>
    virsh domfstrim <instance-name>
    puppet agent --enable
    puppet agent -t

Puppet will fix swap for you. You will need to resume all other instances on the compute
node manually as well.

Alternative approach
--------------------

This will take some time to do.

#. backup the smalles disk to cephfs
#. delete the disk for the instance with disk backup
#. run :file:`virsh destroy <dom>`
#. resume the rest of the instances
#. fstrim (ansible or virsh domfstrim) the rest of the instances
#. copy back the disk from cephfs
#. start the destroyed instance with openstack cli

It will take 1-2 hours to fix a alice compute node with 180GB os-disk.
