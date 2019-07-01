======
Uke 26
======

av Raymond Kristiansen, UH IaaS, 01. juli 2019

Oppdatert informasjon om status finnes alltid i
`Trello <https://trello.com/norcams>`_

.. contents::

Status
======

Veldig lenge siden forrige rapport. Vi har brukt omtrent all tid på å klargjøre
og hjelpe til med få kjørt Atlas og Alice på UH-IaaS. Begge deler har tatt
lenger tid enn planlagt, men vi tror vi nærmer oss nå.

Onsdag 26. juni hadde vi nedetid på tjenestene i rundt 3 timer for patching og
oppgradering. Arbeidet ble annonsert i de vanlige kanalene. I forbindelse med
oppgradering av Calico fikk vi et problem med multiregion som medførte at det
ikke var mulig å starte nye instanser i OSL før etter ca 2 timer etter varslet
nedetid. Siden det var sent på dagen og sommer antar vi at få brukere var berørt.

Vi har satt opp en compute host med en GPU som kan tilby vgpu til instanser. Vi
har for øyeblikket et prosjekt som tester dette (de samme som har betalt for
hosten).

Vi håper å få oppgradert til Rocky i løpet av juli. Planen er kjøre en test i
uke 27 og oppgradere i uke 28/29.

Utfordringer
============

Vi vil snart gå tom for public IP-addresser. Vi har løst det midlertidig i OSL
med en 3. C-nett, men i BGO vil vi snart også være tom.


Planlagte aktiviteter
=====================

- Oppgradere til Rocky
- Sikkerhetsgjennomgang/ROS
- Fortsette å hjelpe brukere med å ta i bruk tjenesten
- Teste pilot objektlagring

Annet
=====

- Se https://trello.com/norcams for oppdaterte planer.
