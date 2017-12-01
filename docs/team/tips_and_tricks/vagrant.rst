========================
Patch compute in vagrant
========================

Remember to patch the compute node after running "vagrant up" for the first time.

**1**::

   ssh <user>@<loc>-login-01.<domain>
  
**2**::

   cd ansible/files/patches/
   
**3**:

Check the *"MIN_QEMU_DISCARD_VERSION"* version in *python-nova-newton-centos-something.diff*
 
**4**:

Log into the compute node in vagrant   

**5**::
 
   cd /usr/lib/python2.7/site-packages/nova/virt/libvirt/
   
**6**:

Update the *"MIN_QEMU_DISCARD_VERSION"* version in *driver.py* 
   

**7**:

Finally, remember to restart nova::

   systemctl restart openstack-nova-compute.service


