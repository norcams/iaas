======
Uke 10
======

av Raymond Kristiansen, UH IaaS, 22.mars 2017

Oppdatert informasjon om status finnes alltid i
`Trello <https://trello.com/norcams>`_

.. contents::

Status
======

UiA tok i UH-IaaS bruk i et nytt emne i uke 11, denne gangen med kursprosjekt.
Vi fikk da testet at skriptene våre for å opprette og gi tilgang til
kursprosjekt fungerte som det skulle. De fikk også tilgang til en egen flavor
slik at de kan kjøre et spesiallaget image for kurset.

Vi jobber også med å ferdigstille et image builder verktøy vi skal benytte for
å lage våre GOLD images. Dette er også planen at andre kan gjenbruke det til å
lage egne image.

Vi har fått tildelt to nye /24-blokker med IPv4-adresser så vi vil nå mest
sannsynlig klare oss til vi får på plass IPv6 støtte (planlagt leveranse juni
2017).

Oppdatert statistikk over bruk finnes på https://status.uh-iaas.no

Planlagte aktiviteter
=====================

- Ferdigstille image builder
- Fortsette å hjelpe brukere med å ta i bruk tjenesten
- Jobbe videre med Designate og Ceilometer
- Vaktordning i arbeidstiden for RT, Slack (brukersupport) og Sensu (monitorering)
- Lage halvårsplan for våren 2017

Utfordringer
============

Ingen endringer på dette siste uken. Så jeg lar det stå.

- Dersom diskbruken for OS i instanser forsetter å øke vil vi om ikke altfor
  lenge trenge mer disk. Vi har penger igjen fra i fjor til å kjøpe mer disk.
  Vi ligger nå i BGO på 20-40% bruk på de aktive compute nodene. Vi jobber med
  en plan for å bygge om Ceph-clusteret til å kunne også håndtere OS-disk.

- Vi har fått penger fra UNINETT for 2 ekstra stillinger i 2017. 1. februar
  fikk vi en ekstra person ved UiB, mens vi ikke har fått noen ekstra person
  ved UiO enda. Det vil medføre at de planlagte leveransene knyttet til avtalen
  med UNINETT for 1. juli 2017 med stor sannsynlighet ikke vil bli levert.
  Dette vil først og fremst ramme object storage.

- Det vil kreve midler til hardware for å øke kapasiteten og videreutvikle
  tjenesten. Dette behovet vil det med høy sannsynlighet komme allerede i 2017.
  Det vi ser nå at vi vil trenge midler til er mer compute, langvarig løsning på
  diskutfordringene nevnt over og object storage. Vi jobber med å tallfeste
  kortsiktige og langsiktige løsninger.

Annet
=====

- Se https://trello.com/norcams for oppdaterte planer.
