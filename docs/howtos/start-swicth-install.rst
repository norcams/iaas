How to initiate installation with or without OS access
========================================================

.. NOTE::
   All this s just some quck notes just to remember the basics.
   Guaranteed to be errors or inaccuracies!

This describes how to initiate a new installation of Dell
switches, also when there is no access to the current OS
(or there isn't any).

The description assumes the provisioning system is set up and prepared
the machine.


Trigger install from running OS
-------------------------------

With full access to Cumulus Linux
*********************************

As *root*, run::

  # onie-select -i

This will start a PXE installation on next run.


Without any access to operating system
**************************************

Preparation
\\\\\\\\\\\

You will need a laptop with serial console cable. Connect the
cable to the rs232 port in front of the switch. Open a console
to ttyUSBx/ttyS0 etc. using minicom, screen, tmux, putty or
other useable software.

Then power on or reset the switch (i.e. by removing an reinserting power cables)

Proecdure
\\\\\\\\\

Press a key when there is a message about pressing `<F2>`, `<F11>` etc. or the
text ``Hit any key to stop autoboot``.
Either a menu or a prompt appear.

- If a prompt appear:

  1. Start an ONIE shell ("rescue"):

     *accton_as4610-54 ->* **run onie_rescue**

  2. After a request to press *Enter*:

     *ONIE#* **onie-nos-install http://repo.mgmt.osl.uhdc.no/images/cumuluslinux/onie-installer-arm**

  Adjust URL according to the setting.

- If the *onie* menu appears, select **onie installation**


Debugging provisioning script
-----------------------------

After the basic installation, the default provisioning attempts to retrive a
"program" if the relevant DHCP option is set (``cumulus-provision-url`` or
``ztd-provision-url`` for Cumulus Linux or OPX respectively). We provide a
script at::

  /provision/switch.sh

This ensure the clock and date is correct (to facilitate package installations),
set up additional basic repositories and installs and executes `puppet`.

Tips if the installation does not set the system up as expected:

1. The script takes some time, and eventually reboots. In the meantime (after
   reboot after basic OS installation) the console shows just a standard login
   prompt.

2. Consult the web server log on `admin` and confirm the script has been
   downloaded

3. If the script is executed but does not perform what is expected from it,
   temporarily adjust the script to write to file. One possible strategy, is to
   use *#!/bin/bash -x* (or something to a similar effect), and then redirect
   everything to a file like this::

     exec >/root/debug.txt
