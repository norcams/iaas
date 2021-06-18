==========
Report API
==========

Last updated: 2020-06-17

.. _report design: ../../_static/report_design/index.html
.. _Archimate: https://en.wikipedia.org/wiki/ArchiMate

We are running a REST API on https://report.nrec.no with internally developed
endpoints for a few utilities needed. This is setup with python-flask and
Swagger (now `OpenAPI <https://en.wikipedia.org/wiki/OpenAPI_Specification>`_).

The DB backend is running on db-global node with master-master replication
between BGO and OSL.

A quick HTML overview of the `report design`_ in `Archimate`_.

:download:`Original archimate file <../../files/report_design.archimate>`

Endpoints
=========

See documentation of all endpoints `here <https://report.nrec.no/api/ui/>`_.

Instance
--------

Used to collect instance information (POST) using `report-utils
<report-utils.html>`_ and to read instances owner and
information (GET).


Status
------

Used to store NREC status messages. This is used to view status messages
at https://status.nrec.no and will be posted by notification scripts in
`himlarcli <himlarcli/index.html>`_.

Security
========

The API has also implemented a simple OAuth2 Bearer token authentication.
The tokens are manually created and deleted (revoked) and is stored hashed
with bcrypt in the DB backend.

Scopes
------

* **read** = used to access get instance api
* **admin** = used to access post status api
