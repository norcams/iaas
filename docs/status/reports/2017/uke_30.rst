======
Uke 30
======

av Raymond Kristiansen, UH IaaS, 31.juli 2017

Oppdatert informasjon om status finnes alltid i
`Trello <https://trello.com/norcams>`_

.. contents::

Status
======

Samlerapport for sommeren. De fleste har vært på ferie så aktivitetsnivået
har vært lavt i perioden.

Vi er ferdig med imagebuilder, et verktøy for å bygge egne image, som er
tilgjengelig for alle å bruke her https://github.com/norcams/imagebuilder

I tillegg til imagebuilder har vi også skrevet om hvordan vi håndterer de
imagene vi tilbyr (GOLD). Dette gjør at vi har mye bedre kontroll på disse og
kan letter gjøre tilpassinger i fremtiden.

Vi er i gang med oppgradering av Openstack til versjon newton. Vi vil gjøre
selve oppgraderingen i flere steg, og vil starte med keystone i begynnelsen
av august.

Demo-prosjekt er nå implementert for alle nye som registrerer seg og vi har
oppdatert brukerdokumentasjonen (les mer `om demo-prosjekt <../../plans/demo.html>`_).

Vi er også i sluttfasen med å få klargjort IPv6 for instanser. Vi regner med
at vi kan tilby IPv6 i løpet av august.

Vi hadde endringsuke i uke 27. Det vil si at vi både oppdaterte tjenestene
rundt UH-IaaS og migrerte instanser for å oppdater compute nodene. Denne gangen
gikk dette mye bedre. Vi fikk som før litt lenger nedetid på tjenestene enn
varslet under oppgradering, men ellers gikk det greit. Migreringen gikk uten
feil denne gangen og alle instanser kom tilbake etter en reboot som varslet.

Vi planlegger en samling i begynnelsen på september.

Planlagte aktiviteter
=====================

- Oppgradere til Openstack Newton
- IPv6 til instanser
- Teste oppsettet med sentral OS-disk
- Fortsette å hjelpe brukere med å ta i bruk tjenesten
- Jobbe videre med Designate og Ceilometer

Utfordringer
============

- Vi jobber med en plan for å bygge om Ceph-clusteret til å kunne også
  håndtere OS-disk. Det har vist seg problematisk å få bestilt disker fra Dell.
  Dette vil bli et akutt problem dersom vi får mange nye brukere
  i UH-IaaS før vi får mer disk.

- Pga forsinkelse med å få ansatt en ekstra person ved USIT vil det medføre
  at de planlagte leveransene knyttet til avtalen med UNINETT for 1. juli 2017
  ikke vil bli levert. Dette vil først og fremst ramme object storage.

Annet
=====

- Se https://trello.com/norcams for oppdaterte planer.
