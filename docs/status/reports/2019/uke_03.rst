======
Uke 3
======

av Raymond Kristiansen, UH IaaS, 18.januar 2019

Oppdatert informasjon om status finnes alltid i
`Trello <https://trello.com/norcams>`_

.. contents::

Status
======

Vi hadde vedlikeholdsvindu 18. des (BGO) og 19. des (OSL) mellom 15-16. Vinduet
ble brukt til å oppgradere de fleste nodene til CentOS 7.6. Selve oppgradering
gikk etter planen og stort sett innenfor det varslede vinduet.

16. januar ble kaldmigreing av instanser i availability zone (AZ) legacy for
å kunne patch compute noder i group3 (to noder). Instansene ble migrert over på
en compute node i group2 slik at vi fikk frigitt en node og flyttet til AZ
default. Brukere av berørte instanser ble varslet direkte med informasjon om at
instansen ville bli bootet. Det ble problemer med å utføre migreringen slik at
tidspunktet ikke ble helt som varslet (nedetiden per instans ble som varslet).
Problemene medførte at vi måtte deaktivere de andre compute nodene når vi
migrerte for å være sikker på at instansene havnet på rett compute node.
Deaktiveringen skjedde en liten periode i hver region mellom 16:30 og 18:00.

Vi har startet en test med erasure coding (EC) av pool i Ceph clusteret. Vi har
et prosjekt som tester med et 5 TB stort volume i BGO og vi vil følge med på
hvordan det påvirker ytelsen i resten av clusteret.

Hardware for å kjøre CERN Alice workloads i BGO er nå bestilt. Totalt er det
snakk om over 50 servere og 3 nye rack.

Vi har også fått noen nye compute noder med GPU i OSL for testing. Disse vil
bli satt opp og installert når vi får den nye mgmt-switchen som er bestilt.

Vi har også bytte logo for UH-IaaS. Samtidig har vi endret fargeprofiler
tilsvarende den nye logoen.


Utfordringer
============

Vi begynner å gå tom for compute ressurser, spesielt i OSL. Vi har flyttet en
compute node fra availability zone legacy til default som vil avhjelpe på kort
sikt. Men vi trenger flere compute noder dersom vi ikke skal begynne å slette
instanser.

Planlagte aktiviteter
=====================

- Fortsette å hjelpe brukere med å ta i bruk tjenesten
- Oppgradere til ny Openstack-versjon: **Queens**
- testing av DNSaaS med Designate
- Pilot objektlagring

Annet
=====

- Se https://trello.com/norcams for oppdaterte planer.
