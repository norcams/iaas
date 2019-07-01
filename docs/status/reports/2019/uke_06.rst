======
Uke 6
======

av Raymond Kristiansen, UH IaaS, 8. februar 2019

Oppdatert informasjon om status finnes alltid i
`Trello <https://trello.com/norcams>`_

.. contents::

Status
======

Vi oppgraderte UH-IaaS til Openstack versjon `queens` onsdag 6. februar. Selve
oppgraderingen gikk uten problemer i det avsatte vinduet som ble varslet.
I forbindelse med oppgraderingen av keystone, måtte vi gjøre endre i måten vi
bruker Dataporten til federerte brukere. Dette medførte at vi under testing
fikk ny bruker i dashboard og dermed mistet bl.a. SSH-nøklene til den gamle brukeren. Dette ble
løst under oppgradering ved å manuelt oppdatere database slik at alle beholdt
den gamle federerte brukeren i UH-IaaS.

I forbindelse med utvidelse i OSL har vi bestemt oss for å flytte test02 slik at
vi får frigjort et rack ved siden av det utstyret vi har idag. Planen er å
flytte test02 tirsdag 12. februar. Vi vil da kunne montere de nye compute nodene
som er kjøpt inn til CERN Atlas workloads i dette racket.

UH-IaaS har nå lansert DNS som en tjeneste. Alle som har et eget domene
(eller kontrollerer et subdomene) kan nå bruke UH-IasS til å administrere det.
Vi bruker Openstack Designate som både kan brukes via dashboard eller via API.

Det er bestilt inn to nye compute noder til OSL for å avlaste her.

Hardware til CERN workload i BGO har begynt å dukke opp, men vi har forsatt ikke
fått rack slik at vi kan starte monteringen.

Utfordringer
============

Vi vil snart gå tom for public IP-addresser. Vi har idag 2 C-nett i hver region.
Vi har nytt et ledig C-nett som idag rutes til OSL, men som ikke er i bruk.
Dette er tenkt å bruke til testing av redundant uplink, men kan etter det
brukes av instanser i OSL.


Planlagte aktiviteter
=====================

- Montering og flytting av ny hardware
- Testing av vGPU
- Fortsette å hjelpe brukere med å ta i bruk tjenesten
- Pilot objektlagring

Annet
=====

- Se https://trello.com/norcams for oppdaterte planer.
