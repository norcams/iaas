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

