.. |date| date::

.. |W| image:: images/16x16_warning.png
.. |Y| image:: images/16x16_yes.png
.. |N| image:: images/16x16_no.png

==============
UH-IaaS Status
==============

Last changed: |date|

.. WARNING::
   **9. November - Domain change:** We will change the domain for UH-IaaS services.
   Updated URLs can be found below.

.. WARNING::
   **20th October - Complete reinstall:** In preparation of the end of pilot and start
   of production in November we have done a complete reinstall of both locations.
   All users will now be able to continue testing the new production setup.
   **All existing instances, images, volumes, snapshots and users have been deleted.**

Make sure to read both the :doc:`/enduser/index` and :doc:`/enduser/pilot`
before you start.

Current service status
======================

========= ======
Component Status
========= ======
Access     |Y|
Dashboard  |Y|
========= ======

============== ==== ====
Component      BGO  OSL
============== ==== ====
API            |Y|  |Y|
Compute        |Y|  |Y|
Block storage  |Y|  |Y|
Image          |Y|  |Y|
============== ==== ====

Both BGO and OSL:

- Dashboard: https://dashboard.uh-iaas.no

- Access: https://access.uh-iaas.no

- API: https://api.uh-iaas.no:5000/v3

Known issues
============

OSL and BGO location
--------------------
There are now one UH-Iaas cloud with two regions: BGO and OSL. Provision is
done once at https://access.uh-iaas.no. In the dashboard you will have access
to both regions. For API access remember to set REGION_NAME in rc-file.

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
