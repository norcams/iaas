======
Uke 39
======

av Raymond Kristiansen, UH IaaS, 9.oktober 2017
(en uke forsinket pga ferie)

Oppdatert informasjon om status finnes alltid i
`Trello <https://trello.com/norcams>`_

.. contents::

Status
======

Vi er nå ferdig med oppgradering av Openstack til newton og Ceph til
luminious. Oppgraderingen gikk uten store problemer.

Vi hadde endringsuke i uke 39 (26. OSL og 27. BGO). I tillegg til vanlig patching
og restart av alle bokser (med unntak av compute) har vi
nå satt opp lastbalansering av netverks API (kjører nå 3 backends i prod).
Vi har tidligere hatt problemer med ytelsen her, men etter endringer ser det ut til
at disse problemene er løst. Selve patchingen gikk også mye bedre en tidligere,
og alle systemer fungerte som normal når tjenestene kom opp igjen. Total ble
vinduet for nedetid rundt 60 min.

Vi har laget et nettskjema for å forenkle bestilling av prosjekter i UH-IaaS:

  `https://skjema.uio.no/iaas-project <https://skjema.uio.no/iaas-project>`_

Oppdatering av default kvote og demo prosjekt for all ble utført 29. september.
Alle brukere skal også ha fått epost om endringen. I ettertid ser det ut til at
flere ønsker å bruke UH-IaaS til mer enn testing og vi har sett en økning i
bestilling av nye prosjekt via nettskjema. Dette vil nok medføre at vi må bruke
litt mer tid på oppretting av prosjekt og brukerstøtte de neste ukene.


Planlagte aktiviteter
=====================

- Oppgradere til CentOS 7.4
- IPv6 til instanser
- Fortsette å hjelpe brukere med å ta i bruk tjenesten
- Jobbe videre med Designate og Ceilometer

Utfordringer
============

- Vi må oppgradere til CentOS 7.4 for å kunne ta i bruk de nye serverne som ble
  kjøpt til compute (OSL) og objektlagring (BGO). Maskinene er for ny til å
  fungere med 7.3 drivere.

- Pga forsinkelse med å få ansatt en ekstra person ved USIT medføret det
  at de planlagte leveransene knyttet til avtalen med UNINETT for 1. juli 2017
  ikke ble levert. Vi har forsatt mål om å levere pilot for objektlagring i
  løpet av 2017.

Annet
=====

- Se https://trello.com/norcams for oppdaterte planer.
