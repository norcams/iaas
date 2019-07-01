======
Uke 8
======

av Raymond Kristiansen, UH IaaS, 25. februar 2019

Oppdatert informasjon om status finnes alltid i
`Trello <https://trello.com/norcams>`_

.. contents::

Status
======

Mye tid de to siste uken har gått med til arbeid relatert til ny hardware.
Det er 9 nye compute i OSL og ca 50 nye storage, network og compute i BGO.

Vi har startet revidering av sikkerhetsdokumentet som forarbeid til en full
ROS analyse. Dokumentet vil gi oss en god start på det arbeidet.

Vi ser også på bruk av Ceph til object storage i Openstack. Den vil da bli satt
opp med samme støtte for API som swift, Swift API og S3 API, via keystone.

I forbindelse med en supportsak startet vi også å se litt mer på
retningslinjer for kreditering av publikasjoner som benytter seg av UH-IaaS.
Vi forhører oss med UB (UiB) om hva som må til for å f.eks. benytte CRISTIN
i forbindelse med registering av publikasjoner i sektoren.

Vi har nå også gold image for Windows 2019 (core og standard) i tillegg til 2016.

Samlingen i vår blir i Oslo 6. og 7. mars.

Utfordringer
============

Vi vil snart gå tom for public IP-addresser. Vi har idag 2 C-nett i hver region.
Vi har nytt et ledig C-nett som idag rutes til OSL, men som ikke er i bruk.
Dette er tenkt å bruke til testing av redundant uplink, men kan etter det
brukes av instanser i OSL.


Planlagte aktiviteter
=====================

- Montering og installasjon ny hardware
- Sikkerhetsgjennomgang/ROS
- Testing av vGPU
- Fortsette å hjelpe brukere med å ta i bruk tjenesten
- Pilot objektlagring

Annet
=====

- Se https://trello.com/norcams for oppdaterte planer.
