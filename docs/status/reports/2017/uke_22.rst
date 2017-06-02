======
Uke 22
======

av Raymond Kristiansen, UH IaaS, 2.juni 2017

Oppdatert informasjon om status finnes alltid i
`Trello <https://trello.com/norcams>`_

.. contents::

Status
======

Vi bruker for tiden litt tid på å få bruk til UH-IaaS. Det vil si at vi deltar
på workshops og andre prosjekter som UNINETT sitt
`researchlab <https://www.uninett.no/researchlab>`_.

Hovedfokus de siste ukene er å jobbe med en løsning for sentral lagring av
instansene sin OS-disk. Vi jobber nå med å teste dette ut og håper å være
klar til innkjøp av flere SSD-disker om ikke lang tid. Mer informasjon ligger
i `lagringsplanen <../../plans/storage.html>`_.

Vi hadde endringsuke denne uken. Det vil si at vi både oppdaterte tjenestene
rundt UH-IaaS og migrerte instanser for å oppdater compute nodene. Det gikk
ikke helt etter planen. Det er skrevet en `full rapport med detaljer
om hva som gikk galt <../change/week_22.html>`_.

Ellers jobbes det videre med påbegynte oppgaver.


Planlagte aktiviteter
=====================

- Ferdigstille image builder
- Teste oppsettet med sentral OS-disk
- Fortsette å hjelpe brukere med å ta i bruk tjenesten
- Jobbe videre med Designate og Ceilometer
- IPv6 til instanser
- Oppgradere til Openstack Newton

Utfordringer
============

- Dersom diskbruken for OS i instanser forsetter å øke vil vi om ikke altfor
  lenge trenge mer disk. Vi har penger igjen fra i fjor til å kjøpe mer disk.
  Vi ligger nå i BGO på 70-80% bruk på de aktive compute nodene. Vi jobber med
  en plan for å bygge om Ceph-clusteret til å kunne også håndtere OS-disk.

- Pga forsinkelse med å få ansatt en ekstra person ved USIT vil det medføre
  at de planlagte leveransene knyttet til avtalen med UNINETT for 1. juli 2017
  ikke vil bli levert. Dette vil først og fremst ramme object storage.

Annet
=====

- Se https://trello.com/norcams for oppdaterte planer.
