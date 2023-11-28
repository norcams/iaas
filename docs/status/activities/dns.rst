===
DNS
===

Sist endret: 2023-11-27

Dette er den planen vi nå bruker for DNS til interne og offentlige tjenester.

Offentlig (nrec.no)
======================

Felles
------
* **www.nrec.no**: i første omgang en enkel landingside med linker til alt
  annet
* **docs.nrec.no**: samme som uh-iaas.readthedocs.org
* **status.nrec.no**: status på tjenestene og hvilke organisasjoner som er
  med.
* **access.nrec.no**: dpapp for provisjonering
* **dashboard.nrec.no**: Openstack horizon
* **api.nrec.no**: identity public endpoint

Per lokasjon
------------

* **identity.api.<loc>.nrec.no**: identity public endpoint
* **compute.api.<loc>.nrec.no**: compute public endpoints
* **network.api.<loc>.nrec.no**: network public endpoints
* **image.api.<loc>.nrec.no**: image public endpoints
* **volume.api.<loc>.nrec.no**: volume public endpoints
* **console.<loc>.nrec.no**: Openstack consoleproxy
* (**dashboard-<loc>.nrec.no**: intern dashboard)

Instanser
---------

Vi kan f.eks. legge dem under et eget subdomene under nrec.no

Test regioner
-------------

Vi kan ersatte nrec.no med test.iaas.uib.no (test01) og test.iaas.uio.no
(test02). F.eks. dashboard.test.iaas.uio.no.

Intern (uhdc.no)
================

Management
----------

Hostname blir `<host>.mgmt.<loc>.uhdc.no`

Transport (trp)
---------------

Tjenester blir `<service>.<loc>.uhdc.no`
