How to boostrap a Foreman-instance
==================================

This document describes the procedure to initialize a new environment from a
single login node. The systems to be used are all physically installed
(including configuration of `BIOS`/`iDrac`) but otherwise untouched.


Prerequisites
-------------

- a functioning login node (with an up-to-date */opt/[himlar|repo]* hiearchy)
- the system is configured by `Puppet`
- no management-node are installed (`controller`)
- *hieradata/<loc>/common.yaml*  is populated with relevant network data
- all commands run as the admin user (`root`)
  (log in using normal login procedure: `iaas` user from login node, then *sudo*)

Procedure
---------

1. On the login node: **/usr/local/sbin/bootstrap-<loc>-controller-01.sh**
   
   .. NOTE::
      The error message "curl: (33) HTTP server doesn't seem to support byte
      ranges. Cannot resume." is harmless when the script has been previously
      run. If so this is just an indication that the files to be fetched are
      already in place.

#. Boot the relevant physical node
   For instance by using the web GUI on the `iDrac` or with this command on the
   login node:

        **idracadm -r <idrac-IP for <loc>-controller-01 to be installed> -u gaussian -p <idrac-pw> serveraction powercycle**

   .. NOTE::
      Make sure the system is configured to PXE boot on first attempt!

   .. IMPORTANT::
      When the new controller is fully installed, the script started in 1) must be
      quit if the new system is set to primarly attempt PXE boot, otherwise
      it will enter an endless installation loop!

#. Log on to the freshly installed controller node

#. run **/opt/himlar/provision/puppetrun.sh**

#. Punch a hole in the firewall for traffic to port 8000:

   **iptables -I INPUT 1 -p tcp --dport 8000 -j ACCEPT**

#. run **/usr/local/sbin/bootstrap-<loc>-foreman-01.sh**

   1. **virsh list** should now report the foreman instance as running
   #. The install can be monitored with **vncviewer <loc>-controller.01....**
      (or your preferred vnc viewer application))
   #. When the message "*Guest installation complete... restarting guest.*" is
      written to the terminal from where the script was started, the system
      is installed and ready for use.

   #. The new controller node can be logged on to from the login node:
      **ssh iaas@<loc>-foreman-01...**.

#. When controller node installation is complete the firewall can be restored:
   **iptables -D INPUT 1**

#. Sync */opt/repo* from login node to foreman node (**NB**: fix/repair
   ownership if necessary, should be `root:root`)

#. Log on to the new ``foreman`` system from the login node, optionally check
   the install log: */root/install.post.log*

#. run **HIMLAR_CERTNAME=<certname> /opt/himlar/provision/puppetrun.sh**

   This command can be run several times.

#. run **/opt/himlar/provision/foreman-settings.sh**

At this point there should be a working Foreman instance running which can be
logged in to through the web GUI (http/https). This system is then running in an
libvirt instance on the physical controller node.


Additional steps after Foreman installation
-------------------------------------------

It is beneficial to get the controller node registered in Foreman and listed as
a *compute resource*. This way it is possible to install other systems, like the
OpenStack master node, in addition to get the Foreman node itself connected to
this libvirt resource.

1. On the controller node, run **puppet apply --test** a couple of times
#. In Foreman GUI sign relevant pending certificate requests if any
#. On Foreman node (cli) run **/etc/puppet/node.rb --push-facts** (is this
   necessary?)
#. In Foreman GUI register a libvirt resource:

   a. ``Infrastructure -> Compute resources``
   #. ``New compute resource``
   #. :Name: whatever descriptive
      :Provider: Libvirt
      :URL: qemu+tcp://<loc>-controller-01.iaas.uio.no:16509/system
      :Display type: VNC

   #. Check the configured connection: ``Test connection``
   #. ``Submit``

#. Select the new resource in the GUI and then the `Virtual machines` tab;
   the Foreman node should now be automatically registered here.

