======
Uke 37
======

av Raymond Kristiansen, UH IaaS, 18.september 2017

Oppdatert informasjon om status finnes alltid i
`Trello <https://trello.com/norcams>`_

.. contents::

Status
======

Oppgradering til newton fullføres i uke 38 med oppgradering av horizon
(dashboard). Dette er den komponenten brukere vil oppleve størst endring med.
Vi varsler på `status.uh-iaas.no <https://status.uh-iaas.no>`_ og Slack.

I forbindelse med test av sentral OS-disk har vi funnet ut at det først bør
oppgraderes til neste LTS-versjon av Ceph (luminious). Planen er å ta inn
det vi taper i tid på oppgraderingen med at sentral OS-disk blir mindre
omfattende.

Vi hadde samling 6. og 7. september. I tillegg til fokus på de oppgavene vi
allerede er i gang med så vil vi også prioritere oppgradering til Puppet 4
i løpet av høsten 2017.

Vi jobber med å sette opp flere backend-noder av Openstack-tjenestene.
Dette vil bidra til til at vi kan takler høyere last (LB) og at tjenestene
blir mer redundant (HA). Dette vil være et pågående arbeid som vil strekke
seg ut i 2018, med mål om å kunne gjøre vedlikehold uten nedetid for brukere.

Vi vil starte arbeidet med avvikling av personlig prosjekt i uke 38. Alle
brukere vil bli varslet på epost om endringene. Vi vil også lage et nettskjema
for å forenkle bestilling av nye prosjekt.

Planlagte aktiviteter
=====================

- Fullføre oppgradering til Openstack Newton
- IPv6 til instanser
- Oppgradere Ceph
- Fortsette å hjelpe brukere med å ta i bruk tjenesten
- Jobbe videre med Designate og Ceilometer

Utfordringer
============

- Pga forsinkelse med å få ansatt en ekstra person ved USIT medføret det
  at de planlagte leveransene knyttet til avtalen med UNINETT for 1. juli 2017
  ikke ble levert. Vi har forsatt mål om å levere pilot for objektlagring i
  løpet av 2017.

Annet
=====

- Se https://trello.com/norcams for oppdaterte planer.
