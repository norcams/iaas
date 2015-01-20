Configure a Dell S55 FTOS switch from scratch
=============================================

This describes how to build configure a Dell Powerconnect S55
switch as management switch for our iaas from scratch.

Initial config
--------------

You will need a laptop with serial console cable. Connect the
cable to the rs232 port in front of the switch. Open a console
to ttyUSBx using screen, tmux, putty or other useable software.

Then power on the switch.

After the switch has booted, you can now enter the enable state:

.. code:: bash

  > enable

The switch will default to jumpstart mode, trying to get a
config from a central repository. We will disable it by typing

.. code:: bash
  # reload-type normal

Now we need to provide an ip address, create user with a passord
and set enable password in order to provide ssh access:

.. code:: bash

  # configure
  (conf)# interface managementethernet 0/0
  (conf-if-ma-0/0)# ip address 10.0.0.2 /32
  (conf-if-ma-0/0)# no shutdown
  (conf-if-ma-0/0)# exit
  (conf)# management route 0.0.0.0 /0 10.0.0.1
  (conf)# username mylocaluser password 0 mysecretpassword
  (conf)# enable password 0 myverysecret
  (conf)# exit
  # write
  # copy running-config startup-config

Now you can ssh to the switch using your new user from a computer
with access to the switch's management network.

Configure the switch itself
---------------------------

Let's configure the rest! We start by shutting down all ports

.. code:: bash

  > enable
  # configure
  (conf)# interface range gigabitethernet 0/0-47
  (conf-if-range-gi-0/0-47)# switchport
  (conf-if-range-gi-0/0-47)# shutdown
  (conf-if-range-gi-0/0-47)# exit

If you want to use a port channel (with LACP) for redundant uplink
to core you can create one. If you don't, omit all references to it
later in the document:

.. code:: bash

  (conf)# interface port-channel 1
  (conf-if-po-1)# switchport
  (conf-if-po-1)# no shutdown
  (conf-if-po-1)# exit

Assign interfaces to the port channel group:

.. code:: bash

  (conf)# interface range gigabitethernet 0/42-43
  (conf-if-range-gi-0/42-43)# no switchport
  (conf-if-range-gi-0/42-43)# port-channel-protocol LACP
  (conf-if-range-gi-0/42-43)# port-channel 1 mode active
  (conf-if-range-gi-0/42-43)# no shutdown
  (conf-if-range-gi-0/42-43)# exit

Define in-band and out-of-band VLANs:

.. code:: bash

  (conf)# interface vlan 201
  (conf-if-vl-201)# description "iaas in-band mgmt"
  (conf-if-vl-201)# no ip address
  (conf-if-vl-201)# untagged GigabitEthernet 0/22-33,38-41
  (conf-if-vl-201)# tagged Port-channel 1
  (conf-if-vl-201)# exit
  (conf)# interface vlan 202
  (conf-if-vl-201)# description "iaas out-of-band mgmt"
  (conf-if-vl-201)# no ip address
  (conf-if-vl-201)# untagged GigabitEthernet 0/0-10
  (conf-if-vl-201)# tagged Port-channel 1
  (conf-if-vl-201)# exit
  (conf)# exit

Congratulations! Save the config and happy server provisioning:

.. code:: bash

  # write
  # copy running-config startup-config
