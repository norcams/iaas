======
Uke 35
======

av Raymond Kristiansen, UH IaaS, 3.september 2018

Oppdatert informasjon om status finnes alltid i
`Trello <https://trello.com/norcams>`_

.. contents::

Status
======

Alle noder med unntak av compute for legacy-1 ble patchet og bootet i uke 32.
Det gikk etter planen og uten overraskelser selv om vi oppgraderte fra CentOS
7.4 til 7.5.

Vi kjører nå egne navnetjenere for uh-iaas.no og sonene <loc>.uhdc.no. Dette
gjør at vi kan oppdatere alle DNS-navn vi bruker uten avhengighet til andre.

Vi samler nå også inn litt ekstra informasjon om instanser som kjører i UH-IaaS.
I første omgang er det kun snakk om oppetid og antall pakker som ikke er
installert. Antall pakker som ikke er installert vil enten være
sikkerhetsoppdateringer eller vanlige pakker som kan oppdateres.

Vi har jobbet med en del endringer som har kjørt i test en stund og vil bli
rullet ut i prod de neste ukene:

* oppgradering av Ceph (inkludert reinstall av storage noder)
* skru på SElinux på alle tjenster som er eksponert mot Internett
* ta i bruk egne DNS-tjenere for alle instanser

Vi kommer til å prøve å få skrudd av instanser som kjører i availability zone (AZ)
legacy-1 slik at vi kan flytte compute noder til AZ default-1 som sliter med høyt
minnebruk. I førte omgang vil vi prøve å få brukere til å skru av frivillig samt
terminere demo-instanser her.

Det er planlagt en ny samling i Bergen i høst. Vi jobber med å få til noe i uke 38.

Utfordringer
============

Vi begynner å gå tom for compute ressurser, spesielt i OSL. Der har vi nå gikk
vekk ca 3 ganger så mange VCPUs som vi har logiske kjerner (6 ganger mot fysiske
kjerner). Vi kan forsatt overprovisjonere litt mer, men i løpet av høsten må vi
ha flere compute hoster.

Planlagte aktiviteter
=====================

- Fortsette å hjelpe brukere med å ta i bruk tjenesten
- Oppgradere til ny Openstack-versjon: **Pike**
- Jobbe videre med Designate
- Pilot objektlagring

Annet
=====

- Se https://trello.com/norcams for oppdaterte planer.
