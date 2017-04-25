======
Uke 16
======

av Raymond Kristiansen, UH IaaS, 25.april 2017

Oppdatert informasjon om status finnes alltid i
`Trello <https://trello.com/norcams>`_

.. contents::

Status
======

Pga. påske ble det ikke laget rapport for uke 15.

Vi har jobbet litt med å automatisere prosjektadministrasjon, blant annet
personer som bytter epost-adresse og derfor mister tilgangen til ressursene
i UH-IaaS.

Det er laget planer for `demo-prosjekt <../../plans/demo.html>`_ og
`lagring <../../plans/storage.html>`_

Ellers har har endel tid forsvunnet til andre ting enn UH-IaaS.

Resten av tiden har blitt brukt i all hovedsak på pågående arbeid med

* designate
* ceilometer
* imagebuilder
* NAT og IPv6

Planlagte aktiviteter
=====================

- Ferdigstille image builder
- Fortsette å hjelpe brukere med å ta i bruk tjenesten
- Jobbe videre med Designate og Ceilometer
- IPv6 til instanser
- Vaktordning i arbeidstiden for RT, Slack (brukersupport) og Sensu (monitorering)

Utfordringer
============

- Mangel på SSD gjør at diskene vi har bestilt til OSL ikke kommer før i juni.
  Vi ser på muligheten for bruke andre disker midlertidig for å unngå at alt
  stopper opp før diskene ankommer.

- Dersom diskbruken for OS i instanser forsetter å øke vil vi om ikke altfor
  lenge trenge mer disk. Vi har penger igjen fra i fjor til å kjøpe mer disk.
  Vi ligger nå i BGO på 50-60% bruk på de aktive compute nodene. Vi jobber med
  en plan for å bygge om Ceph-clusteret til å kunne også håndtere OS-disk.

- Pga forsinkelse med å få ansatt en ekstra person ved USIT vil det medføre
  at de planlagte leveransene knyttet til avtalen med UNINETT for 1. juli 2017
  ikke vil bli levert. Dette vil først og fremst ramme object storage.

- Det vil kreve midler til hardware for å øke kapasiteten og videreutvikle
  tjenesten. Dette behovet vil det med høy sannsynlighet komme allerede i 2017.
  Det vi ser nå at vi vil trenge midler til er mer compute, langvarig løsning på
  diskutfordringene nevnt over og object storage. Vi jobber med å tallfeste
  kortsiktige og langsiktige løsninger.

Annet
=====

- Se https://trello.com/norcams for oppdaterte planer.
