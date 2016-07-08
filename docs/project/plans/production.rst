========================
Fra pilot til produksjon
========================

.. IMPORTANT::
   Dette dokumentet er kun et internt utkast

Dette dokumentet beskiver hvilke funksjonaliet vil vil tilby, når vi lanserer
og hva som trengs for å kunne sette UH IaaS i produksjon.

Funksjonalitet
==============

Dette er en liste over ønsket funksjonalitet når vi går i produksjon:

- brukerkonto og tilgang til personlig prosjekt via Dataporten

- tilgang til to regioner fra dashboard og API

- opprette og administrere instanser via dashboard og API

- snapshot av instanser til sentral lagring

- sentral blokklagring knyttet til instanser

- felles prosjekt for en grupper av brukere

- tilgang til oppdaterte image for et utvalg av linux distroer

Leveranser
==========

Intern leveranseplan:

======== ===================================================
 Frist    Leveranse
======== ===================================================
 1.sept   Oppgradere til mitaka
 26.sept  Felles keystone og full reinstall av bgo og osl
 01.nov   Produksjonsklar bgo og osl
 14.nov   Lansering
======== ===================================================

Det endelige målet er å være produksjonsklar 1.nov og lansere 14. november 2016


Ressurser
=========

Personell
---------

Vi vil trenge 4 årsverk ut året.

Hardware
--------

Hardware ved lansering per lokasjon:

Compute
~~~~~~~

Trenger å doble antall compute noder ved lansering.

**3 ekstra maskiner:** 3 x 125K = 375K

Storage
~~~~~~~

Dersom vi ønsker å tilby sentral lagring av OS-disk trenger vi 5 nye maskiner.

**Alt 1:** 5 x SSD maskiner 500K = 2500K

**Alt 2:** 5 x NL SAS 120K = ca 600K


Alle priser er budsjettpriser fra Dell.

Usikkerhet
==========

- avtaler (vilkår for bruk) og jus

- sikkerheten må godkjennes

- antall ipv4 adresser vi har tilgjengelig kan begrense antall instanser


Utvidet funksjonalitet
======================

Vi ønsker også å kunne tilby en tjeneste for objektlagring og IPv6.

Ressurser
----------

- 2 årsverk i 6 mnd
- storage: 600K NOK per lokasjon
- api server: 125K NOK per lokasjon
