.. |date| date::

.. |W| image:: images/16x16_warning.png
.. |Y| image:: images/16x16_yes.png
.. |N| image:: images/16x16_no.png

==============
UH-IaaS Status
==============

Last changed: |date|

Make sure to read both the :doc:`/enduser/index` and :doc:`/enduser/pilot`
before you start.

Current service status
======================

============== ==== ====
Component      BGO  OSL
============== ==== ====
Access         |Y|  |Y|
Dashboard      |Y|  |Y|
API            |W|  |W|
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

API access doesn't work with Dataporten authentication
------------------------------------------------------

Due to current limitations with tokenized authentication through the
Dataporten service, API access is only possible with local users. If
you need API access, please contact us. We will provide a local user
account for you to use with API, which will be a member of your
personal project. This is a temporary workaround.


Changelog
=========

Important changes that affect users will be logged here.

**2016-05-06**
  Removed some networking related GUI elements in dashboard, which by
  design doesn't work in our setup. This includes Floating IPs,
  Networks and Routers.

**2016-05-02**
  Corrected an error in the OS network stack on compute nodes, which
  prevented the OSL location from working properly. Both locations are
  now up and running.


Getting help
============

We have a public chat room at https://uhps.slack.com

Reporting issues
================

Issues should be reported via the GitHub project norcams/iaas:
https://github.com/norcams/iaas/issues
