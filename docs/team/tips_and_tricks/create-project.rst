====================
Create a new project
====================


- ssh <user>@<loc>-login-01.<domain>

- ssh iaas@<loc>-proxy-01.<domain>

- sudo -i
- source openrc

- cd /opt/himlarcli
- source bin/activate

- run ./project.py


Example
-------

.. code:: bash

   ./project.py create -t <type> -a <email> -q <small> --end <enddate> --desc <"description"> --rt <number> -m --dry-run --debug


Access to additional resources
------------------------------

Some projects need access to additional resources, like volumes backed by SSD drives, special flavors, images etc.

Grant access to a given volume type (for example, mass-storage-ssd), and set a specific quota for that volume type:

.. code:: bash

   openstack volume type set --project <project name> mass-storage-ssd
   openstack quota set --volume-type mass-storage-ssd --gigabytes 100 <project name>

*mass-storage-ssd* is an example of an additinal resource which may be added.
Change as appopriate.
