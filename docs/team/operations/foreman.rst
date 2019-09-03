=======
Foreman
=======

Runs on :file:`<loc>-admin-01` and is the DHCP-server, puppetmaster and is used to
install new hosts (nodes, compute and storage).

Kickstart templates
-------------------

The templates used to install new nodes are found on the master branch of:
https://github.com/norcams/community-templates.git

Included here are only the templates that diverge from upstream.

If this repo is updated, you will need to update all admin nodes manually.
Run as root on the admin server::

  foreman-rake templates:sync \
    repo="https://github.com/norcams/community-templates.git" \
    branch="master" associate="always" prefix="norcams ""

or run::

  /opt/himlar/provision/foreman-settings.sh

Upgrade
-------

Foreman are upgraded by changing the :file:`foreman_version` i himlar and
running the foreman upgrade playbook in `ansible <ansible/index.html>`_.

Also remember to rebase our community templates fork against upstream. Upstream
has tags corresponding to the Foreman version.
