======
Uke 12
======

av Raymond Kristiansen, UH IaaS, 25. mars 2019

Oppdatert informasjon om status finnes alltid i
`Trello <https://trello.com/norcams>`_

.. contents::

Status
======

Onsdag 20. mars hadde vi nedetid på tjenestene i rundt 2 timer for patching.
Arbeidet ble annonsert i de vanlige kanalene og ble gjennomført i det varslede
vinduet.

I forbindelse med utvidelse av BGO til en sekundærhall (HIB) måtte vi oppdatere
lag 2 nettet med to nye switcher. I forbindelse med dette hadde vi
i en periode om kvelden onsdag 20. mars enkelte brudd og svekket
ytelse i nettet BGO. Det inkluderer nettet til instansene. Dette arbeidet var
kritisk for å kunne komme videre med CERN-nodene som er montert på HIB.
Sekundærhallen på HIB er planlagt ny primærhall for BGO i løpet av 2019/2020.

De nye compute-nodene i OSL er klar til bruk, og arbeidet forsetter med CERN
Alice T1 nodene i BGO. Disse ble installert i uke 12. Vi jobber med med testing
av utstyret.

Vi har nå klar en pilot av med S3 og swift i BGO. Vi tester litt først i det
stille før vi annonserer en åpen pilot.

I uke 12 gikk vi tom for offentlig IPv4-addresser i OSL. Vi har nå tatt i bruk
et ekstra C-nett i OSL. Dette er den vi fikk i starten til bruk i TRD.
Dette var tenkt brukt til testing av ny uplink i OSL. Vi trenger
derfor en ny blokk (helst permanet, men iallefall til låns) før vi kan fullføre
bytte av uplink fra USIT til Uninett.

Utfordringer
============

Vi vil snart gå tom for public IP-addresser. Vi har løst det midlertidig i OSL
med en 3. C-nett, men i BGO vil vi snart også være tom.


Planlagte aktiviteter
=====================

- Installasjon ny hardware
- Sikkerhetsgjennomgang/ROS
- Testing av vGPU
- Fortsette å hjelpe brukere med å ta i bruk tjenesten
- Teste pilot objektlagring

Annet
=====

- Se https://trello.com/norcams for oppdaterte planer.
