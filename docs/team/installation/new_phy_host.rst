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
