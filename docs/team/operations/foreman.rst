=======
Foreman
=======

Runs on :file:`<loc>-admin-01` and is the DHCP-server, puppetmaster and is used to
install new hosts (nodes, compute and storage).

Installation
-------------------

Since :file:`<loc>-admin-01` is the node used to install everything else we need to
bootstrap this node from a controller. See bootstrap documentation for more info.


Setup
-----

Puppet (norcams/himlar) will do the basic install and setup.

For the rest of the configruation and setup of foreman we use
https://github.com/norcams/foreman-setup

See readme in this repo for more info.
