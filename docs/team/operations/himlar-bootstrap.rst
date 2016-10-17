How to boostrap Himlar
======================

This document describes the procedure to initialize a new environment from a
single login node. The systems to be used are all physically installed
(including configuration of `BIOS`/`iDrac`) but otherwise untouched.

loc=[**bgo|osl|test01|test02|local1|local2|local3|...**]


Prerequisites
-------------

- A login node (with an up-to-date */opt/[himlar|repo]* hiearchy) which is
  maintained by `Puppet`
- No management-node installed (`controller`)
- *hieradata/${loc}/common.yaml*, *hieradata/common/common.yaml*, *hieradata/nodes/${loc}/...*
  etc. are populated with relevant data
- All commands run as the admin user (`root`) unless noted
  (consult the document `2FA on jumphosts (login nodes) <https://iaas.readthedocs.io/en/latest/team/getting_started/two-factor-authentication.html>`_)
- The new controller node (and all further controller and compute nodes) must
  have CPU virtualization extentions enabled in BIOS

.. IMPORTANT::
   When doing a complete reinstall make sure `peerdns: 'no'`
   is in the network configuration for the nodes controller-01 and admin-01.
   
   Also make sure gateway and DNS points to the login node or wherever there is
   a connection out and/or a resolverreachable. This might require toggling
   of data in 'common.yaml' or the relevant node files.
   
   This should be manipulated on the code activated on the login node from where
   the bootstrap process is initialized befoe the run. Changes after installation
   of the controller node should be activated on the node itself
   ("/opt/himlar/hieradata").

Procedure
---------

1. Make sure the dhcp and tftp services are allowed through the firewall, if
   RHEL 7/Centos 7:
   
   **firewall-cmd --list-services**

   If *tftp* and *dhcp* is not amongst the permitted services on that list, add
   the ones missing, for instance:
   
   **firewall-cmd --add-service dhcp**

#. Enable NAT of relevant mgmt interface on the login node out through the public facing interface

#. On the login node:
   
   **/usr/local/sbin/bootstrap-$loc-controller-01.sh**

   .. NOTE::
      The error message "curl: (33) HTTP server doesn't seem to support byte
      ranges. Cannot resume." is harmless when the script has been previously
      run. If so this is just an indication that the files to be fetched are
      already in place. But please make sure the files nevertheless are recent!

#. Boot the relevant physical node using the web GUI on the `iDrac` or with this command on the login node:
   
   **idracadm -r <idrac-IP for $loc-controller-01 to be installed> -u gaussian -p <idrac-pw> serveraction powercycle**

   .. NOTE::
      Make sure the system is configured to PXE boot on the relevant (mgmt)
      interface on first attempt! Might require BIOS setup.

   .. IMPORTANT::
      When the new controller is fully installed, the script started in 1) must be
      quit if the new system is set to primarly attempt PXE boot, otherwise
      it will enter an endless installation loop!

#. Log on to the freshly installed controller node:
   
   (**sudo**) **ssh iaas@$loc-controller-01**

#. Run puppet in boostrap mode:
   
   **bash /root/puppet_bootstrap.sh**

#. Run puppet normally:
   
   **/opt/himlar/provision/puppetrun.sh**

#. Punch a hole in the firewall for traffic to port 8000:

   **iptables -I INPUT 1 -p tcp --dport 8000 -j ACCEPT**

#. Initiate installation of the admin node/Foreman:
   
   **/usr/local/sbin/bootstrap-$loc-admin.sh**

   1. **virsh list** should now report the foreman instance as running
   #. The install can be monitored with **vncviewer $loc-controller.01**,
      **virt-manager** connected to *$loc-controller-01* or your preferred
      vnc viewer application
   #. When the message 
      
      "*Domain creation completed.
      Restarting guest.*"
      
      is written to the terminal from where the script was started, the system
      is installed and ready for use.

   #. The new controller node can be logged on to from the login node:
      
      **ssh iaas@$loc-admin-01...**.

#. When controller node installation is complete the firewall can be restored:

   **iptables -D INPUT 1**

#. Log on to the new ``admin`` system from the login node, optionally check
   the install log: */root/install.post.log*

#. ensure the system time is correct 

#. Distribute relevant *rndc.key*:

   run the ``ansible`` job **push_secrets.yaml**
   (check tasks.md for syntax, use correct host)

   NB: the `secrets` repo must already have the key installed

#. Run puppet in bootstrap mode:
   
   **bash /root/puppet_bootstrap.sh**

#. Run puppet again:
  
   **HIMLAR_CERTNAME=<certname> /opt/himlar/provision/puppetrun.sh**

   This command may be run several times.

#. Configure Foreman:

   a. **/opt/himlar/provision/foreman-settings.sh**
   #. run the ``himlarcli`` command **foreman_setup.py**
      (remember to use the appropriate configuration file for the environment)

#. Log on to the Foreman instance now running on the address *https://foreman.<mgmt domain>*.

#. Sign the certificate request from the controlelr node:

   **Infrastructure --> Smartproxies --> $loc-admin-01.<mgmt domain> --> Puppet CA --> Sign (Action)** for *$loc-controller-01.<mgmt domain>*

#. Set up autosigning of future certificate requests:

   From location of previous action: **Autosign entries --> New --> Name: *.<mgmt domain> --> Save**

#. After 15 minutes (or after a manual puppet run on the node)
   *$loc-controller-01* should be listed under **Hosts --> All hosts**

#. Install the rest of the nodes in the environment:

   - Install either through the *Foreman GUI* or using he *himlarcli* command **node.py -c config.ini.$loc <node> install**
   - Using the *himlarcli* command the nodes will iautomatically be set up according to the
     nodes file for the environment.
   - Recommended sequence:

     a. proxy-01
     #. ...
     #. Remaining nodes, may be done by running:

        **node.py -c config.ini.$loc xxx full**

        This will install all nodes in the list ``<himlarcli top dir>/config/nodes/$loc.yaml``. Exisiting nodes
        will be skipped.

  .. NOTE::
     Physical hosts may have to be rebooted or powered on manually. Make sure
     they are configured to PXE boot on the managment interface on their first boot.

