.. |date| date::

.. |W| image:: images/16x16_warning.png
.. |Y| image:: images/16x16_yes.png
.. |N| image:: images/16x16_no.png

==============
UH-IaaS Status
==============

Last changed: |date|

 .. CAUTION::

    **10.aug OSL:** Scheduled downtime of all services.


Make sure to read both the :doc:`/enduser/index` and :doc:`/enduser/pilot`
before you start.

Current service status
======================

============== ==== ====
Component      BGO  OSL
============== ==== ====
Access         |Y|  |Y|
Dashboard      |Y|  |Y|
API            |Y|  |Y|
Compute        |Y|  |Y|
Block storage  |Y|  |Y|
Image          |Y|  |Y|
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
projects are supported. Work is on the way to build common projects
functionality (using groups) into Dataporten, which will be the
authoriative source for this type of metadata.

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
