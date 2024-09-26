============================
Installing new physical host
============================

.. contents::

A few steps are necessary in order to successfully configure new hardware

Baseboard Management Controller (BMC)
-------------------------------------

First, obtain the MAC address of the BMC, either visually or harvesting it
from the management switch. Most management switches run OpenSwitch (OPX) from
which obaining the MAC addresses are non-trivial. More often than not you
will have to take the oob bridge down and up in order for the switch to refresh
the MAC address table, for instance in osl region looking at port 27:

.. code:: bash

    ifdown br3378 && ifup br3378
    sleep 5
    bridge fdb | grep e101-027-0 | grep -v permanent

The MAC address shown should belong to the BMC.

.. code:: bash

    00:25:90:bc:ce:19 dev e101-027-0 master br3378

Next, add hieradata entry for an IP and MAC association in the regions admin role.
After a puppet run the BMC will be equipped with an IP address. BMCs from a certain
vendor (Dell) may now be provisioned by Zero Touch Provisioning (given that the server was
ordered with the feature enabled), otherwise configure the BMC manually after logging in
with default login. As a minimum, configure:

- user with password and admin privileges

- disable default user

- UEFI, and UEFI only, boot

- inband mgmt interfaces as primary boot device

- hard drive as secondary boot device


Basics on Zero Touch Provisioning (Dell hardware)
'''''''''''''''''''''''''''''''''''''''''''''''''

Dell systems using Zero Touch Provisioning can be initilized without manual
interventions. Details can be found in Dell documentation, for instance this
`ZERO-TOUCH BARE-METAL PROVISIONING document`_.

.. _ZERO-TOUCH BARE-METAL PROVISIONING document: https://downloads.dell.com/manuals/all-products/esuprt_software/esuprt_it_ops_datcentr_mgmt/dell-management-solution-resources_white-papers9_en-us.pdf


Flowchart
*********

- System has its 'DHCP Provisioning' attribute set to 'Enable once'
- Machine is turned on for the first time
- iDRAC sends vendor-class 'iDRAC'
- For these the DHCP server return option 43 containing information about filename and location
  of XML with configuration data
- iDRAC configures itself according to XML data
- iDRAC resets the 'DHCP Provisioning' attribute to 'Disabled'


Local configuration locations
*****************************

The DHCP configuration is in */etc/dhcp/dhcpd.conf* on the admin nodes:

.. code:: bash

   # out-of-band network definition
   subnet 172.17.32.0 netmask 255.255.248.0 {
     option routers 172.17.32.10;
     default-lease-time 43200;
     max-lease-time 86400;
     option domain-name-servers 172.17.32.10;

     # iDRAC will search for file in order <servicetag>-config.json,
   <model>-config.json, config.json
     # examples: 4U1BGM7-config.json, R740xd-config.json, config.json
     # Refer to the zero-touch, bare metal server provisioning document from Dell
   for options.
     option vendor-class-identifier "iDRAC";
     set vendor-string = option vendor-class-identifier;
     option idrac-provision-url "-i 172.17.32.9 -s http -t 500 -n osl/";
   }

This is for `OSL`, but very similar in all of the environments.

The files themselves are in */etc/repo/public/<location>*. The 'osl/' part above
is the last part of this. The naming of the files is descibed in the above
snippet and in the PDF linked above.

.. Note::
   If a machine is powered on and booted before its MAC address is set up, the
   provisioning attribute must be switched back to `Enabled once` again to get
   it to provision itself. On iDRAC9: *iDRAC Settings - Connectivity - Network - Auto Config*


Determine role and define hieradata
-----------------------------------

There is a common list for all regions so that role, number and addressing is consistent
for all regions. Check that list (in effect it is the list for the DNS entries), it may
already be defined if a similiar server is set up in another region.

If this server is to have a sub role, a CNAME must be created in the region's common settings.

For the more common roles as compute and storage the network interfaces will be automatically
configured during install, but that all depends on a correct definition of roles for the physical
interfaces. This is typically configured for the role (or sub role) or even on a host to host
basis, and varies with vendor and server model. This may be non-trivial to predict, but often
there are similar servers already installed making a prediction possible. Configure the
hieradata accordingly.

For more specialized roles, like controller, a host file with a complete network interfaces hash
is necessary.

Now deploy the configuration to the region's admin node.


Configuring transport switches
------------------------------

All physical hosts are dual connected using the team driver, so a LACP interface is necessary
on the switches. The LACP interfaces are named host[number], "number" corresponds to port number on
the switch. Switches with breakout ports are the exeption as there are four host interfaces pr physical
port. If not already configured, add hieradata for the switches, deploy code to admin node, and after a
puppet run bring the interface(s) up:

.. code:: bash

    ifup -a

on both switches. 

If the port is segmented (configured in **ports.conf**) the switch needs to be rebooted, it is not recommended to restart switchd to make the configuration in effect because it puts the switch in a non- or semi-configured state. 

    
.. note::
   You need to configure both leaf and spine, look at the compute-81/host17 realted commits for hints.
   e.g. The hostXX naming:  *Fix(bgo) clagid, there is logic at work here. ((Portnr - 1) x 4 )+ subport.*

Tip on how check link status:

.. code:: 
   ethtool NICname
   lldpctl NICname
   clagctl status (on switch)

BGP config
----------

Add the new hosts to BGP
in **hieradata/<region>/roles/spine.yaml**. Example::

  diff --git a/hieradata/osl/roles/spine.yaml b/hieradata/osl/roles/spine.yaml
  index ddc2162f7..50df5e2b8 100644
  --- a/hieradata/osl/roles/spine.yaml
  +++ b/hieradata/osl/roles/spine.yaml
  @@ -870,6 +870,9 @@ frrouting::frrouting::bgp_neighbor_groups:
         - '172.18.33.122'
         - '172.18.33.123'
         - '172.18.33.124'
  +      - '172.18.33.125' # compute-64
  +      - '172.18.33.126' # compute-65
  +      - '172.18.33.127' # compute-66
       'options6':
         - 'neighbor rr-clients route-reflector-client'
         - 'neighbor rr-clients soft-reconfiguration inbound'
  @@ -941,6 +944,9 @@ frrouting::frrouting::bgp_neighbor_groups:
         - 'fd32::1:122'
         - 'fd32::1:123'
         - 'fd32::1:124'
  +      - 'fd32::1:125' # compute-64
  +      - 'fd32::1:126' # compute-65
  +      - 'fd32::1:127' # compute-66
     'object_rgw':
       'options':
         - 'peer-group'



Instruct the Foreman to install server
--------------------------------------

Now we are ready to install the server. Harvest the MAC address for the inband management interface,
either from the management switch or the BMC and add a node entry in the "himlar CLI" inventory. From
a proxy node run

.. code:: bash

    ./node.py install -n [role]-[number]

This will instruct the Foreman to serve an operating system installation for the management interface
we have already instructed the server to boot from.

Grab some coffee and wait for the server(s) to complete the installation.


Activate new node in Openstack
--------------------------------------

Before the new node appears as a hypervisor it needs to be discoverd an put in a cell!
On e.g. novactl node run: 

.. code:: bash

    nova-manage cell_v2 discover_hosts
