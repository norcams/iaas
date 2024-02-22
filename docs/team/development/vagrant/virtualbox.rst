.. |date| date::

=======================
Vagrant with virtualbox
=======================

Last changed: 2024-02-22

You first will need to install the virutalbox and vagrant packages for
your operating system.

For version :file:`6.1.26+` you will need to update the privat networks
virtualbox can use. Edit :file:`/etc/vbox/networks.conf` and add::

  * 10.0.0.0/8 192.168.0.0/16 172.16.0.0/12

This have been tested on Ubuntu 20.04 and 22.04 and works without any other
configuration.
