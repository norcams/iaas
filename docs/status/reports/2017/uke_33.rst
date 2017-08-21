======
Uke 33
======

av Raymond Kristiansen, UH IaaS, 21.august 2017

Oppdatert informasjon om status finnes alltid i
`Trello <https://trello.com/norcams>`_

.. contents::

Status
======

Tannaz Navaie Roshandel startet i teamet ved USIT 15. august. Hun er
finansiert av UNINETT ved UH-sky og skal jobbe med UH-IaaS i et år.

Vi har oppgradert alle Openstack-komponenter til Newton bortsett fra
Nova (compute) og Horizon (dashboard). Så langt har det ikke vært store
overraskelser. Oppgraderingen har blitt gjort i fart, og har kun medført
nedetid på den aktuelle tjenesten på 2-3 minutter.

Planen er å starte med å måle bruk 1. september. Vi må før den tid lage en plan
for avvikling av personlig prosjekt og fullføring av implementasjonen av demo-
prosjekt (les mer `om demo-prosjekt <../../plans/demo.html>`_).

Vi planlegger en felles samling i Bergen 6. og 7. september. Vi vil da se på
planer for høsten 2017. Hovedfokus blir i høst blir objektlagring.

Hardware for piloten av objektlagring er bestilt ved UiB.

Planlagte aktiviteter
=====================

- Fullføre oppgradering til Openstack Newton
- IPv6 til instanser
- Teste oppsettet med sentral OS-disk
- Fortsette å hjelpe brukere med å ta i bruk tjenesten
- Jobbe videre med Designate og Ceilometer

Utfordringer
============

- Vi venter på eksterne for å få fullført implementering av IPv6.

- Vi jobber med en plan for å bygge om Ceph-clusteret til å kunne også
  håndtere OS-disk. Det har vist seg problematisk å få bestilt disker fra Dell.
  Dette vil bli et akutt problem dersom vi får mange nye brukere
  i UH-IaaS før vi får mer disk.

- Pga forsinkelse med å få ansatt en ekstra person ved USIT vil det medføre
  at de planlagte leveransene knyttet til avtalen med UNINETT for 1. juli 2017
  ikke vil bli levert. Dette vil først og fremst ramme object storage.

Annet
=====

- Se https://trello.com/norcams for oppdaterte planer.
