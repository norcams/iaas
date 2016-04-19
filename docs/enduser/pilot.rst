.. |date| date::

Pilot Phase -- Terms of Service
===============================

Last changed: |date|

.. contents::

.. WARNING::
   This document is under construction.


Who can use this service
------------------------

The UH-IaaS service will, in its pilot phase be available to all users
at UiB and UiO. The compute and storage resources, as well as IP
address pool available are limited, however. For this reason, we ask
that testers exercise restraint, and terminate instances that are no
longer needed.


Purpose of the pilot
--------------------

The main purpose of the pilot is to allow interrested users to
acclimate to this type of service. It also allows the administrators
and implementers to test the service using real customers. It is
important that testers report bugs, missing documentation etc.


Which data can you put here
---------------------------

Only insensitive data can be stored in the UH-IaaS cloud during its
pilot phase.


Uptime and SLAs
---------------

We do not guarantee anything during the pilot phase. We will try to
keep things up and running, but this is done on a best effort basis.

Every week we will reinstall a compute node that has been running for the last
three weeks. When this happens, all instances running on the compute node will
be terminated. The compute node used for new instances will always be running
for three weeks before scheduled reinstall. We will also *try* to notify users
running on a compute node scheduled for reinstall 24 hours before the reinstall.

Every four weeks, we will schedule a downtime window where all services
in the cloud will be unavailable. We will try to make running instances
available in this window.

Contact
-------

The administrators from UiB and UiO can be reached through the
channels listed below.

Chat room
~~~~~~~~~

We have a public chat rom at https://uhps.slack.com

Reporting issues
~~~~~~~~~~~~~~~~

Issues should be reported via the GitHub project norcams/iaas:
https://github.com/norcams/iaas/issues
