======
Uke 47
======

av Raymond Kristiansen, UH IaaS, 27.november 2017
(sykdom og ferieavvikling har medført hull i rapporteringen)

Oppdatert informasjon om status finnes alltid i
`Trello <https://trello.com/norcams>`_

.. contents::

Status
======

IPv6 ble rullet ut i slutten av oktober. Alle nye instanser vil nå også få
offentlig IPv6-adresser (dualstack). Vi vil også tilby et eget nett med
privat IPv4 (med NAT) og offentlig IPv6 (IPv6).

Vi har bygget om Ceph-cluster vårt til også å kunne brukes til sentral OS-disk
for instanser. Planen er først å gjøre en intern test med de nye compute-hostene.
Det er ikke avgjort om vi ønsker å flytte eksisterende instanser inn i den nye
lagringen eller om vi kun skal tilby det for nye instanser.

Vi hadde endringsuke i uke 47. Patching og omstart av tjenester ble utført i
OSL tirsdag mellom 15-16 uten problemer. Onsdag fikk vi problemer med en pakke
som medførte at database-klusteret ikke kom tilbake. IDP-tjensten (keystone)
var derfor nede til rundt kl 19:00. Resten av tjenestene kom tilbake som normalt
til kl 16. Vi har nå oppgradert til CentOS 7.4.


Planlagte aktiviteter
=====================

- Fortsette å hjelpe brukere med å ta i bruk tjenesten
- Jobbe videre med Designate og Ceilometer
- Teste sentral OS-disk
- Oppgradering til Puppet versjon 4
- Objektlagring


Utfordringer
============

- Pga forsinkelse med å få ansatt en ekstra person ved USIT medføret det
  at de planlagte leveransene knyttet til avtalen med UNINETT for 1. juli 2017
  ikke ble levert. Vi har forsatt mål om å levere pilot for objektlagring i
  løpet av 2017.

Annet
=====

- Se https://trello.com/norcams for oppdaterte planer.
