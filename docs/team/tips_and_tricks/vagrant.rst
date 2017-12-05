=================================
Patch the compute node in vagrant
=================================

Remember to patch the compute node after running "vagrant up" for the first time.

- ssh <user>@<loc>-login-01.<domain>
  
- cd ansible/files/patches/
   
Check the *"MIN_QEMU_DISCARD_VERSION"* version in *python-nova-newton-centos-something.diff*
 
Log into the compute node in vagrant   

- cd /usr/lib/python2.7/site-packages/nova/virt/libvirt/
   
Update the *"MIN_QEMU_DISCARD_VERSION"* version in *driver.py* 
   

Finally, remember to restart nova:

- systemctl restart openstack-nova-compute.service


