===
DNS
===

We use the domains `uh-iaas.no` and `uhdc.no`.

CNAME uh-iaas.no
================

uh-iaas.no are only used for production locations.

============================= ========================
Domain                         CNAME
============================= ========================
www.uh-iaas.no                norcams.github.io
docs.uh-iaas.no               uh-iaas.readthedocs.io
status.uh-iaas.no             uh-status-front.iaas.uib.no
status-osl.uh-iaas.no         uh-status.iaas.uio.no
status-bgo.uh-iaas.no         uh-status.iaas.uib.no
access.uh-iaas.no             uh-access-front.iaas.uib.no
access-osl.uh-iaas.no         uh-access.iaas.uio.no
access-bgo.uh-iaas.no         uh-access.iaas.uib.no
dashboard.uh-iaas.no          uh-dboard-front.iaas.uib.no
dashboard-osl.uh-iaas.no      uh-dboard.iaas.uio.no
dashboard-bgo.uh-iaas.no      uh-dboard.iaas.uib.no
console.osl.uh-iaas.no        uh-console.iaas.uio.no
console.bgo.uh-iaas.no        uh-console.iaas.uib.no
api.uh-iaas.no                uh-api-front.iaas.uib.no
compute.api.bgo.uh-iaas.no    uh-api.iaas.uib.no
identity.api.bgo.uh-iaas.no   uh-api.iaas.uib.no
network.api.bgo.uh-iaas.no    uh-api.iaas.uib.no
image.api.bgo.uh-iaas.no      uh-api.iaas.uib.no
volume.api.bgo.uh-iaas.no     uh-api.iaas.uib.no
compute.api.osl.uh-iaas.no    uh-api.iaas.uio.no
identity.api.osl.uh-iaas.no   uh-api.iaas.uio.no
network.api.osl.uh-iaas.no    uh-api.iaas.uio.no
image.api.osl.uh-iaas.no      uh-api.iaas.uio.no
volume.api.osl.uh-iaas.no     uh-api.iaas.uio.no
============================= ========================

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
