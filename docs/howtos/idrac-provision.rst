Configure iDRAC-settings on Dell 13g servers with USB stick
===========================================================

With Dell PowerEdge 13g servers the iDRAC base management
controller can be configured automatically by reading
settings from an xml file located on a USB stick. The USB
port to be used is labelled with a wrench icon.

Create USB stick and copy files to it
-------------------------------------

You will need a USB stick formatted with fat32 and a
directory called::

  System_Configuration_XML

Two files are needed::

  config.xml
  control.xml

These xml files can be exported from an already configured
server, or better still, git cloned from

https://github.com/norcams/dell-idracdirect

Apply profile to server iDRAC
-----------------------------

Provide power to the server, but *do not* insert the USB stick
just yet. Power on the server, and wait for the POST process to
finish. After POST has finished, insert the USB stick to the
port in front of the server with the wrench label. If the
server provides a display, it will show first *importing*, then
*applying*. After some odd 10 seconds the server will reboot.
You will notice, as all lights will go out. Remove the USB stick
and proceed to the next server.