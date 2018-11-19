======
Uke 46
======

av Raymond Kristiansen, UH IaaS, 19.november 2018

Oppdatert informasjon om status finnes alltid i
`Trello <https://trello.com/norcams>`_

.. contents::

Status
======

Reiser og ferie har medført litt begrenset produktivitet de siste ukene.
Det gjelder også rapporteringen.

Oppgradering til Pike er nå fullført. `Det finnes en egen side som forklarer
hvordan det gikk <../change/week_46.html>`_.

ELK-stacken (elasticksearch, logstash og kibana) er nå oppgradert til nyeste
versjon. Vi har frem til å kjørt på en par år gammel versjon. Dette vil også
forhåpentligvis gjøre det enklere å bruke spesielt Kibana i feilsøking.

De nye storage nodene i OSL er nå installert og satt i produksjon. Vi har også
gjenbrukt disker fra ombyggingen til SSD slik ta kapasiteten for både volum (HDD)
og OS-disk (SSD) nå er større.

Vi har begynt å se på bruk av Redfish til hardware overvåkning og har satt det
opp i BGO og OSL. Vi har også testet litt med Dell sitt Open Manage til hardware
overvåkning.

Deler at teamet var også i Berlin i uke 46 og deltok på Openstack Summit.

`Referat for samlingen vi hadde i høst er nå lagt inn her også
<../workshop/2018_workshop_2.html>`_.

Utfordringer
============

Vi begynner å gå tom for compute ressurser, spesielt i OSL. Der har vi nå gikk
vekk ca 3 ganger så mange vCPUs som vi har logiske kjerner (6 ganger mot fysiske
kjerner). Vi kan forsatt overprovisjonere litt mer, men i løpet av høsten må vi
ha flere compute hoster.

Planlagte aktiviteter
=====================

- Fortsette å hjelpe brukere med å ta i bruk tjenesten
- Oppgradere til CentOS 7.6
- testing av DNSaaS med Designate
- Pilot objektlagring
- Oppgradere til ny Openstack-versjon: **Queens**

Annet
=====

- Se https://trello.com/norcams for oppdaterte planer.
