======
Uke 14
======

av Raymond Kristiansen, UH IaaS, 11.april 2017

Oppdatert informasjon om status finnes alltid i
`Trello <https://trello.com/norcams>`_

.. contents::

Status
======

Pga. ferie ble det ikke laget rapport for uke 12 og 13.

Onsdag 5. april flyttet vi ca 180 maskiner mellom to sett av compute hosts.
Dette er første gang vi migrerer så mange på en gang og første gang vi har
automatisert migreringen. For de første 150 instansene gikk alt som planlagt,
men for de siste 30 fikk vi problemer med netverks-APIet som medførte ekstra
nedetid på 5-10 min for disse instansene. Problemene med APIet har vi også
sett i test, men dette er første gang vi opplever det i produksjon. Det vil
bli en prioritert oppgave å løse dette.

Vi har også et stykke på vei med å sette opp en IPv4 NAT-tjeneste for IPv6 slik
at instanser også får en privat IPv4 adresse. Dette var mye mer komplisert enn
først antatt, men vi føler vi nå har en løsning som gjør at vi kan tilby IPv6 i
løpet av sommeren som planlagt.

Det meste av tiden har blitt brukt til feilsøking, drift og til å hjelpe
brukere.

Oppdatert statistikk over bruk finnes på https://status.uh-iaas.no

Planlagte aktiviteter
=====================

- Ferdigstille image builder
- Fortsette å hjelpe brukere med å ta i bruk tjenesten
- Jobbe videre med Designate og Ceilometer
- IPv6 til instanser
- Plan for å bygge om Ceph-clusteret
- Vaktordning i arbeidstiden for RT, Slack (brukersupport) og Sensu (monitorering)

Utfordringer
============

Ingen endringer på dette siste uken. Så jeg lar det stå.

- Dersom diskbruken for OS i instanser forsetter å øke vil vi om ikke altfor
  lenge trenge mer disk. Vi har penger igjen fra i fjor til å kjøpe mer disk.
  Vi ligger nå i BGO på 50-60% bruk på de aktive compute nodene. Vi jobber med
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
