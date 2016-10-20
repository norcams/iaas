.. |date| date::

.. |W| image:: images/16x16_warning.png
.. |Y| image:: images/16x16_yes.png
.. |N| image:: images/16x16_no.png

==============
UH-IaaS Status
==============

Last changed: |date|

.. WARNING::
   **Both OSL and BGO are down for testing**

.. WARNING::
   **Complete reinstall:** In preparation of the end of pilot and start
   of production in November we will do a complete reinstall of both locations.
   After the reinstall all users will be able to continue testing the new
   production setup. This page and the slack channel will be updated during the reinstall.
   **All existing instances, images, volumes, snapshots and users will be delete.**
   (There is an option to use Openstack CLI to save and download images.)

Make sure to read both the :doc:`/enduser/index` and :doc:`/enduser/pilot`
before you start.

Current service status
======================

============== ==== ====
Component      BGO  OSL
============== ==== ====
Access         |N|  |N|
Dashboard      |N|  |N|
API            |N|  |N|
Compute        |N|  |N|
Block storage  |N|  |N|
Image          |N|  |N|
============== ==== ====

Location OSL:

- Dashboard: https://dashboard.iaas.uio.no

- Access: https://access.iaas.uio.no

Location BGO:

- Dashboard: https://dashboard.iaas.uib.no

- Access: https://access.iaas.uib.no


Known issues
============

API access
----------

All new users will get a pass phrase to use with API when they provision
a personal project (see :doc:`enduser/login`). Existing users
please contact us. We will provide a pass phrase for you to use with the API.

See :doc:`enduser/api` for more information about use of API.

Only personal projects
----------------------

We currently have a limitation on projects, in which only personal
projects are supported.

Console limitation
------------------

There is a limitation which requires the environment (e.x. X) to run
in one of the EN locales to get a correct key mapping (whatever the
locale active inside the instance)!


Getting help
============

We have a public chat room at https://uhps.slack.com

Reporting issues
================

Issues should be reported via the GitHub project norcams/iaas:
https://github.com/norcams/iaas/issues
