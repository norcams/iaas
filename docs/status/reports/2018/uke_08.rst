======
Uke 8
======

av Raymond Kristiansen, UH IaaS, 26.februar 2018

Oppdatert informasjon om status finnes alltid i
`Trello <https://trello.com/norcams>`_

.. contents::

Status
======

Puppet 4 oppgraderingen er fullført og ble gjennomført uten annen nedetid enn
restart av noen tjenester (maks 1-2 minutter).

Vi har gjort fremskritt både når det gjelder Ceilometer og Designate. Vi jobber
nå med å sette opp Ceilometer i test og regner med at vi om kort tid bytter til
å bruke egne navnetjenere til å håndtere uh-iaas.no og uhdc.no.

I forbindelse med arbeidet med å sete opp Ceilometer så har vi nå også satt opp
en metric tjeneste (metric as a service). Vi er usikker på om dette er en
tjeneste vi også skal tilby sluttbrukere eller om dette skal være kun for intern
bruk.

Vi starter nå arbeidet med å oppgradere til neste version av Openstack. Dette
ble utsatt før nyttår for å kunne ta oppgraderingen av Puppet først.

Vi jobber også med å planlegge en samling for hele teamet i uke 10 hos USIT.


Planlagte aktiviteter
=====================

- Fortsette å hjelpe brukere med å ta i bruk tjenesten
- Jobbe videre med Designate og Ceilometer
- Objektlagring
- Oppgradere til ny Openstack versjon ocata

Utfordringer
============

* Vi har slitt med å få nok strøm til de 4 "nye" compute-nodene i BGO. Vi har
  nå fått ny PSU, men for å ta den i bruk må alle 4 skrues av. 2 av dem er idag
  default zone i BGO og har kjørende instanser.

Annet
=====

- Se https://trello.com/norcams for oppdaterte planer.
