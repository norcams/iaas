============
SSL overview
============

Last changed: 2020-02-17

nrec.no
=======

=========================== ======== =================== =======================
 Domain                      Type     Termination         Certificate
=========================== ======== =================== =======================
access.nrec.no               A        bgo-api-01          `*.nrec.no`
access-bgo.nrec.no           A        bgo-api-01          `*.nrec.no`
access-osl.nrec.no           A        osl-api-01          `*.nrec.no`

report.nrec.no               CNAME    bgo-api-01          `*.nrec.no`
report-osl.nrec.no           A        bgo-api-01          `*.nrec.no`
report-bgo.nrec.no           A        osl-api-01          `*.nrec.no`

status.nrec.no               CNAME    bgo-api-01          `*.nrec.no`
status-bgo.nrec.no           A        bgo-api-01          `*.nrec.no`
status-osl.nrec.no           A        osl-api-01          `*.nrec.no`

request.nrec.no              A        bgo-api-01          `*.nrec.no`
api.nrec.no                  A        bgo-api-01          `*.nrec.no`
api-osl.nrec.no              A        osl-api-01          `*.nrec.no`

docs.nrec.no                 CNAME    sslproxy.ha.uib.no  `docs.nrec.no`
www.nrec.no                  CNAME    sslproxy.ha.uib.no  `www.nrec.no`
nrec.no                      A        129.177.6.241       `nrec.no`

dashboard.nrec.no            A        bgo-dashboard-01    `dashboard.nrec.no`
dashboard-osl.nrec.no        A        osl-dashboard-01    NA
dashboard-bgo.nrec.no        A        bgo-dashboard-01    NA

console.osl.nrec.no          A        osl-api-01          `console.osl.nrec.no`
compute.api.osl.nrec.no      A        osl-api-01          `*.api.osl.nrec.no`
identity.api.osl.nrec.no     A        osl-api-01          `*.api.osl.nrec.no`
network.api.osl.nrec.no      A        osl-api-01          `*.api.osl.nrec.no`
image.api.osl.nrec.no        A        osl-api-01          `*.api.osl.nrec.no`
volume.api.osl.nrec.no       A        osl-api-01          `*.api.osl.nrec.no`
placement.api.osl.nrec.no    A        osl-api-01          `*.api.osl.nrec.no`
metric.api.osl.nrec.no       A        osl-api-01          `*.api.osl.nrec.no`
dns.api.osl.nrec.no          A        osl-api-01          `*.api.osl.nrec.no`
resolver.osl.nrec.no         A        NA                  NA

console.bgo.nrec.no          A        bgo-api-01          `console.bgo.nrec.no`
compute.api.bgo.nrec.no      A        bgo-api-01          `*.api.bgo.nrec.no`
identity.api.bgo.nrec.no     A        bgo-api-01          `*.api.bgo.nrec.no`
network.api.bgo.nrec.no      A        bgo-api-01          `*.api.bgo.nrec.no`
image.api.bgo.nrec.no        A        bgo-api-01          `*.api.bgo.nrec.no`
volume.api.bgo.nrec.no       A        bgo-api-01          `*.api.bgo.nrec.no`
placement.api.bgo.nrec.no    A        bgo-api-01          `*.api.bgo.nrec.no`
metric.api.bgo.nrec.no       A        bgo-api-01          `*.api.bgo.nrec.no`
dns.api.bgo.nrec.no          A        bgo-api-01          `*.api.bgo.nrec.no`
object.api.bgo.nrec.no       A        bgo-api-01          `*.api.bgo.nrec.no`
resolver.bgo.nrec.no         A        NA                  NA
=========================== ======== =================== =======================
