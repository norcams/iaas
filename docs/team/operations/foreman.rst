=======
Foreman
=======

Runs on :file:`<loc>-admin-01` and is the DHCP-server, puppetmaster and is used to
install new hosts (nodes, compute and storage).

Kickstart templates
-------------------

The templates used to install new nodes are found on:
https://github.com/norcams/community-templates.git

If this repo is updated, you will need to update all admin nodes manually.
Run as root on the admin server::

  foreman-rake templates:sync \
    repo="https://github.com/norcams/community-templates.git" \
    branch="norcams" associate="always"

Upgrade
-------

Foreman are upgraded by changing the :file:`foreman_version` i himlar and
running the foreman upgrade playbook in `ansible <ansible/index.html>`_.
