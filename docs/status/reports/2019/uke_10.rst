======
Uke 10
======

av Raymond Kristiansen, UH IaaS, 11. mars 2018

Oppdatert informasjon om status finnes alltid i
`Trello <https://trello.com/norcams>`_

.. contents::

Status
======

Arbeidet med nye hardware forsetter. Vi er straks klar med alle de nye compute
nodene (minus vGPU noden) i OSL og all ny hardware for CERN Alice T1 er straks
ferdig montert og kablet i BGO.

Vi nærmere oss en løsning med eget Ceph cluster for object storage og planen er
å ha klar en pilot av med S3 og swift i BGO denne uken.

Samling 6. og 7. mars hos USIT. Referat blir publisert her når det er klart.
Vi brukte her tid på å forbedrede en spørreundersøkelse som vi planlegger å
sende ut i løpet av de neste ukene.

Vi planlegger et kort avbrudd neste tirsdag 19. mars for å patche alle noder
(med unntak av legacy zonen).

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
