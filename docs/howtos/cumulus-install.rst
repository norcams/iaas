Install cumulus linux on ONIE enabled Dell S4810
================================================

The project will be using Dell PowerConnect S4810
switches with ONIE installer enabled by default
instead of FTOS. This enables easy installation of
cumulus linux to the switches.

Configure dhcpd and http server 
-------------------------------

You will need a running http server with a copy of
the cumulus image::

  # ls /var/www/html
  CumulusLinux-2.5.0-powerpc.bin
  onie-installer-powerpc

"onie-installer-powerpc" is a symlink to the bin-file.
The symlink is used by ONIE to identify an image to
download. Read here about the order ONIE tries to
download the install file::

  http://opencomputeproject.github.io/onie/docs/user-guide/

Now, for the dhcp server to serve out an IP address
and URL for ONIE to download from dhcp option 114 (URL)
is used. This example utilizes ISC dhcpd::

  option default-url = "http://192.168.0.1/onie-installer-powerpc";

This option can be host, group, subnet or system wide.
Read more about different dhcp servers and other methods
here::

  https://support.cumulusnetworks.com/hc/en-us/articles/203771426-Using-ONIE-to-Install-Cumulus-Linux

When you power up the switch, it will by default
be a dhcp client and accept an offered IP address, after
which you can ssh to the ONIE installer with user root
without password. However, if option 114 is specified,
it will download the image and immediatly install it, and
then reboot the switch. When the installation is complete,
you can ssh to the switch using default cumulus login.