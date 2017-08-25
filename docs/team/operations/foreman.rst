=======
Foreman
=======

Runs on :file:`<loc>-admin-01` and is the DHCP-server, puppetmaster and is used to
install new hosts (nodes, compute and storage). It can also be used as DNS-server in dev.

Kickstart templates
-------------------

The templates used to install new nodes are found on:
https://github.com/norcams/community-templates.git

If this repo is updated you will need to update all admin nodes manually.
Run as root on the admin server::

  foreman-rake templates:sync \
    repo="https://github.com/norcams/community-templates.git" \
    branch="norcams" associate="always"
