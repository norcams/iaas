======
Uke 39
======

av Raymond Kristiansen, UH IaaS, 1.oktober 2018

Oppdatert informasjon om status finnes alltid i
`Trello <https://trello.com/norcams>`_

.. contents::

Status
======

Vi hadde samling i Bergen 19. og 20. september. Egen rapport blir skrevet fra
samlingen.

Vi har brukt litt tid på å forbedre oppsettet av noder for kontrollplanet. Vi
har laget nye noder og endret navn på gamle. Dette er et kontinuerlig arbeid
som vil forsette i tiden fremover.

Vi er ferdig med forarbeidet for oppgradering til Openstack Pike. Vi ønsker
først å oppgradere identity (keystone) i fart uten nedetid. Oppgraderingen
vil derfor denne gangen kreve litt mer planlegging enn tidligere. Deretter tar vi
oppgraderingen av resten som normalt med planlagt nedetid på tjenestene.

Det er bestilt 2 nye storage noder i OSL for å avhjelpe utfordringene vi har hatt
med for få OSDer.

SELinux er nå også i drift på compute.

Utfordringer
============

Vi begynner å gå tom for compute ressurser, spesielt i OSL. Der har vi nå gikk
vekk ca 3 ganger så mange vCPUs som vi har logiske kjerner (6 ganger mot fysiske
kjerner). Vi kan forsatt overprovisjonere litt mer, men i løpet av høsten må vi
ha flere compute hoster.

Planlagte aktiviteter
=====================

- Fortsette å hjelpe brukere med å ta i bruk tjenesten
- Oppgradere til ny Openstack-versjon: **Pike**
- testing av DNSaaS med Designate
- Pilot objektlagring

Annet
=====

- Se https://trello.com/norcams for oppdaterte planer.
