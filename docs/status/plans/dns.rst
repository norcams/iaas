===
DNS
===

Sist endret: 2017-03-06

Dette er den planen vi nå bruker for DNS til interne og offentlige tjenester.

Offentlig (uh-iaas.no)
======================

Felles
------
* **www.uh-iaas.no**: i første omgang en enkel landingside med linker til alt
  annet
* **docs.uh-iaas.no**: samme som uh-iaas.readthedocs.org
* **status.uh-iaas.no**: status på tjenestene og hvilke organisasjoner som er
  med.
* **access.uh-iaas.no**: dpapp for provisjonering
* **dashboard.uh-iaas.no**: Openstack horizon
* **api.uh-iaas.no**: identity public endpoint

Per lokasjon
------------

* **identity.api.<loc>.uh-iaas.no**: identity public endpoint
* **compute.api.<loc>.uh-iaas.no**: compute public endpoints
* **network.api.<loc>.uh-iaas.no**: network public endpoints
* **image.api.<loc>.uh-iaas.no**: image public endpoints
* **volume.api.<loc>.uh-iaas.no**: volume public endpoints
* **console.<loc>.uh-iaas.no**: Openstack consoleproxy
* (**dashboard-<loc>.uh-iaas.no**: intern dashboard)

Instanser
---------

Vi kan f.eks. legge dem under et eget subdomene under uh-iaas.no

Test regioner
-------------

Vi kan ersatte uh-iaas.no med test.iaas.uib.no (test01) og test.iaas.uio.no
(test02). F.eks. dashboard.test.iaas.uio.no.

Intern (uhdc.no)
================

Management
----------

Hostname blir `<host>.mgmt.<loc>.uhdc.no`

Transport (trp)
---------------

Tjenester blir `<service>.<loc>.uhdc.no`
