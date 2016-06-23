=================
Workshop 2 - 2016
=================

**Tid og sted**: Avholdt 22.juni i Bergen

**Tilstede**: Trond, Mikael, Øyvind, Tor og Raymond

Agenda for samlingen var å diskutere endelig nettverksdesign og plan for
produksjonssetting til høsten.


.. contents:: Innhold

Nettverksdesign
===============

- konsensus om å gå for "KISS-modell" (se under)
- undersøke om cumulus støtter aktiv-aktiv LACP TODO
- mgmt, oob og public nett med calico ligger fast og ble ikke diskutert
- vi skal kjøre puppet på leaf
- undersøke muligheten for å koble leaf rett på uninett på hver lokasjon TODO


"KISS"-modulen
--------------

Fra epost til Tor 2016-06-21 12:24::

  En logisk sett enklere modell er å fjerne service-nett-overlayet og alle
  ruterne (bortsett fra på compute). Man bonder da transport-interfacene,
  og all kommunikasjon mellom tjenestene går direkte på L2 med
  transport-IPer. Logisk sett får man da:

  - transport

Tilbakemeldinger fra brukere
============================

- få brukere ved UiB. Her har vi en jobb å gjøre TODO
- folk venter på at det skal være i produksjon før de vil ta det i bruk
- vi trenger eksempel på use case TODO
- spørreskjema til brukere i august TODO


Veien fra pilot til produksjon
==============================

Valg av platform
----------------

Server OS: CentOS 7
Openstack: RDO

Vurdere om vi skal bytte RDO med egenpakking.

På leaf ønsker vi cumulus linux.

Ceph: kjører vi CentOS 7 og open source ceph repo

Alle repo skal ha et lokalt repo slik at vi har kontroll på pakkinstallsjonene.


Hardware
--------

Vi må tenke litt mer på hvordan vi ønsker å ha det i forhold til os-disker.

- diskutere os disk til instanser, live migrate
- teste lokalt cache av image på compute TODO
- mer storage?

Felles keystone (to regioner)
-----------------------------

Planen er forsatt å slå sammen bgo og osl til en openstack installasjon med
felles keystone. Vi vil da får to regioner.

- Teste MariaDB med Galera (multi-master) TODO
- Alternativ er en master (skriv) med multiple read, en på hver lokasjon


Hvilke tjenester må være på plass?
----------------------------------

- DNS TODO
- Privatnett TODO
- Golden images (vedlikeholdt) TODO

Fellesprosjekter
----------------

Må være på plass, men spørs om det må gjøres via Dataporten eller om det i en
tidlig fase kan gjøres via semimanuelle scripts. Fellesprosjektene må ha
tilgang til dashboard og api.

SLA
---

Begynne på SLA og terms of service for prod. TODO

Sikkerhet
---------

Jobben må fullføres. Oppfølgingsmøte med IT-sikkerhet@UIO når vi er nærmere produksjon.

Driftsplan
----------

Hvordan drifte uten at brukere merker det?

Hovedkonsepter:

- Redundans på komponenter
- Mulighet for live migration (usikkert, må testes og utredes) TODO
- Nedetid på fysiske hoster m.m. uten at brukere merker det
- Kontinuerlig forbedring
- Kontinuerlig utrulling
- Kontinuerlig patching
- Kontinuerlig alt


Overvåkning og trending
=======================

Raymond sjekker ut DataDog for dette. Det koster penger pr host.


Etter møte
==========

TODO gjøres om til kort i trello.
