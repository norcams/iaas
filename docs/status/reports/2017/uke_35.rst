======
Uke 35
======

av Raymond Kristiansen, UH IaaS, 4.september 2017

Oppdatert informasjon om status finnes alltid i
`Trello <https://trello.com/norcams>`_

.. contents::

Status
======

Vi forsetter oppgraderingen av Openstack til newton. Vi hadde noen utfordringer
med oppgradering av Nova (compute), men jobber for å løse disse nå. Det medførte
at compute API var nede i ca 60 min i BGO. Oppgradering av OSL ble utsatt.

Planen er å fullføre oppgraderingen denne og neste uke. Brukere vil først og
fremst merke at dashboard (horizon) er blitt oppgradert og ting ser litt
forskjellig ut der.

Vi har nå fått montert gammel hardware i Bergen til å teste sentral OS-disk.
Når er ferdig med testingen vet vi om vi går for ombygging av dagens
Ceph-cluster eller må forsette med OS-disk på lokal disk på compute inntil
vi har penger til nytt Ceph-cluster.

I er nesten i mål med IPv6. Det som gjenstår er å legge til støtte i image og
teste.

Vi planlegger en felles samling i Bergen 6. og 7. september. Vi vil da se på
planer for høsten 2017. Hovedfokus blir i høst blir objektlagring.

Planlagte aktiviteter
=====================

- Fullføre oppgradering til Openstack Newton
- IPv6 til instanser
- Teste oppsettet med sentral OS-disk
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
