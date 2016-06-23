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

Only personal projects
----------------------

We currently have a limitation on projects, in which only personal
projects are supported. Work is on the way to build common projects
functionality (using groups) into Dataporten, which will be the
authoriative source for this type of metadata.

Console limitation
------------------

Console is now operational for all *new* instances (already existing with
non-functional console will not get any). There is for now a limitation which
requires the environment (e.x. X) to run in one of the EN locales to get
a correct key mapping (whatever the locale active inside the instance)!


Changelog
=========

Important changes that affect users will be logged here.

**2016-05-24**
  Nested virtualization is now enabled on the compute hosts.
  This should make it possible to run virtual machines inside an instance.

Getting help
============

We have a public chat room at https://uhps.slack.com

Reporting issues
================

Issues should be reported via the GitHub project norcams/iaas:
https://github.com/norcams/iaas/issues
