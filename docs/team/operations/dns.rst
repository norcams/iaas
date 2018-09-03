===
DNS
===

We use the domains `uh-iaas.no` and `uhdc.no`.

Architecture
============

.. image:: images/dns.png


Zone: uh-iaas.no
================

This zone is delegated to:

* ns1.uh-iaas.no (master - located in OSL)
* ns2.uh-iaas.no (slave - located in BGO)

In this zone we have the following records:

============================= ====== ===========================================
Record                        TYPE   VALUE
============================= ====== ===========================================
access.uh-iaas.no             A      ``158.39.77.250``
access-bgo.uh-iaas.no         A      ``158.39.77.250``
access-osl.uh-iaas.no         A      ``158.37.63.250``
api.uh-iaas.no                A      ``158.39.77.250``
dashboard.uh-iaas.no          A      ``158.39.77.254``
dashboard-bgo.uh-iaas.no      A      ``158.39.77.254``
dashboard-osl.uh-iaas.no      A      ``158.37.63.254``
ns1.uh-iaas.no                A      ``158.37.63.251``
ns2.uh-iaas.no                A      ``158.39.77.251``
report.uh-iaas.no             A      ``158.39.77.250``
report-bgo.uh-iaas.no         A      ``158.39.77.250``
report-osl.uh-iaas.no         A      ``158.37.63.250``
request.uh-iaas.no            A      ``158.39.77.250``
status.uh-iaas.no             A      ``158.39.77.250``
status-bgo.uh-iaas.no         A      ``158.39.77.250``
status-osl.uh-iaas.no         A      ``158.37.63.250``
ns1.uh-iaas.no                AAAA   ``2001:700:2:82ff::251``
ns2.uh-iaas.no                AAAA   ``2001:700:2:83ff::251``
docs.uh-iaas.no               CNAME  ``uh-iaas.readthedocs.io``
www.uh-iaas.no                CNAME  ``norcams.github.io``
uh-iaas.no                    MX     ``10 uninett-no.mx1.staysecuregroup.com``
uh-iaas.no                    MX     ``20 uninett-no.mx2.staysecuregroup.net``
============================= ====== ===========================================


Delegated zone: osl.uh-iaas.no
------------------------------

This zone is delegated to:

* ns1.uh-iaas.no (master - located in OSL)
* ns2.uh-iaas.no (slave - located in BGO)

In this zone we have the following records:

============================= ====== ===========================================
Record                        TYPE   VALUE
============================= ====== ===========================================
compute.api.osl.uh-iaas.no    A      ``158.37.63.250``
identity.api.osl.uh-iaas.no   A      ``158.37.63.250``
image.api.osl.uh-iaas.no      A      ``158.37.63.250``
metric.api.osl.uh-iaas.no     A      ``158.37.63.250``
network.api.osl.uh-iaas.no    A      ``158.37.63.250``
placement.api.osl.uh-iaas.no  A      ``158.37.63.250``
volume.api.osl.uh-iaas.no     A      ``158.37.63.250``
console.osl.uh-iaas.no        A      ``158.37.63.250``
resolver.osl.uh-iaas.no       A      ``158.37.63.252``
resolver.osl.uh-iaas.no       AAAA   ``2001:700:2:82ff::252``
============================= ====== ===========================================


Delegated zone: bgo.uh-iaas.no
------------------------------

This zone is delegated to:

* ns1.uh-iaas.no (slave - located in OSL)
* ns2.uh-iaas.no (master - located in BGO)

In this zone we have the following records:

============================= ====== ===========================================
Record                        TYPE   VALUE
============================= ====== ===========================================
compute.api.bgo.uh-iaas.no    A      ``158.39.77.250``
identity.api.bgo.uh-iaas.no   A      ``158.39.77.250``
image.api.bgo.uh-iaas.no      A      ``158.39.77.250``
metric.api.bgo.uh-iaas.no     A      ``158.39.77.250``
network.api.bgo.uh-iaas.no    A      ``158.39.77.250``
placement.api.bgo.uh-iaas.no  A      ``158.39.77.250``
volume.api.bgo.uh-iaas.no     A      ``158.39.77.250``
console.bgo.uh-iaas.no        A      ``158.39.77.250``
resolver.bgo.uh-iaas.no       A      ``158.39.77.252``
resolver.bgo.uh-iaas.no       AAAA   ``2001:700:2:83ff::252``
============================= ====== ===========================================


.. # CNAME uh-iaas.no
.. # ================
.. # 
.. # uh-iaas.no are only used for production locations.
.. # 
.. # ============================= ========================
.. # Domain                         CNAME
.. # ============================= ========================
.. # www.uh-iaas.no                norcams.github.io
.. # docs.uh-iaas.no               uh-iaas.readthedocs.io
.. # status.uh-iaas.no             uh-status-front.iaas.uib.no
.. # status-osl.uh-iaas.no         uh-status.iaas.uio.no
.. # status-bgo.uh-iaas.no         uh-status.iaas.uib.no
.. # access.uh-iaas.no             uh-access-front.iaas.uib.no
.. # access-osl.uh-iaas.no         uh-access.iaas.uio.no
.. # access-bgo.uh-iaas.no         uh-access.iaas.uib.no
.. # request.uh-iaas.no            uh-request-front.iaas.uib.no *
.. # report.uh-iaas.no             uh-report-front.iaas.uib.no
.. # report-osl.uh-iaas.no         uh-report.iaas.uio.no
.. # report-bgo.uh-iaas.no         uh-report.iaas.uib.no
.. # dashboard.uh-iaas.no          uh-dboard-front.iaas.uib.no
.. # dashboard-osl.uh-iaas.no      uh-dboard.iaas.uio.no
.. # dashboard-bgo.uh-iaas.no      uh-dboard.iaas.uib.no
.. # console.osl.uh-iaas.no        uh-console.iaas.uio.no
.. # console.bgo.uh-iaas.no        uh-console.iaas.uib.no
.. # api.uh-iaas.no                uh-api-front.iaas.uib.no
.. # compute.api.bgo.uh-iaas.no    uh-api.iaas.uib.no
.. # identity.api.bgo.uh-iaas.no   uh-api.iaas.uib.no
.. # network.api.bgo.uh-iaas.no    uh-api.iaas.uib.no
.. # image.api.bgo.uh-iaas.no      uh-api.iaas.uib.no
.. # volume.api.bgo.uh-iaas.no     uh-api.iaas.uib.no
.. # placement.api.bgo.uh-iaas.no  uh-api.iaas.uib.no
.. # metric.api.bgo.uh-iaas.no     uh-api.iaas.uib.no
.. # compute.api.osl.uh-iaas.no    uh-api.iaas.uio.no
.. # identity.api.osl.uh-iaas.no   uh-api.iaas.uio.no
.. # network.api.osl.uh-iaas.no    uh-api.iaas.uio.no
.. # image.api.osl.uh-iaas.no      uh-api.iaas.uio.no
.. # volume.api.osl.uh-iaas.no     uh-api.iaas.uio.no
.. # placement.api.osl.uh-iaas.no  uh-api.iaas.uio.no
.. # metric.api.osl.uh-iaas.no     uh-api.iaas.uio.no
.. # ============================= ========================
.. # 
.. # *= redirect only to https://skjema.uio.no/iaas-project

Delegated zones
===============

================= ==================
Zone              NS
================= ==================
bgo.uhdc.no       alf.uib.no
                  begonia.uib.no
osl.uhdc.no       ns1.uio.no
                  ns2.uio.no
test01.uhdc.no    alf.uib.no
                  begonia.uib.no
test02.uhdc.no    ns1.uio.no
                  ns2.uio.no
================= ==================

Test domains
============

For public domain in test we have a delegated subdomains:

========= ===================
Region    Domain
========= ===================
test01    test.iaas.uib.no
test02    test.iaas.uio.no
========= ===================
