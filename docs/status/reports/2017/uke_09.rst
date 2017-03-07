======
Uke 9
======

av Raymond Kristiansen, UH IaaS, 07.mars 2017

Dette er en samlerapport over 2017 frem til og med uke 9.

Oppdatert informasjon om status finnes alltid i
`Trello <https://trello.com/norcams>`_

.. contents::

Status
======

- Hovedfokus siden november 2016 har vært å få flere brukere. Vi har nå ca
  250 brukere, 10 prosjekter og ca 300 kjørende instanser.
  Oppdaterte tall på https://status.uh-iaas.no

- I januar 2017 fikk UiA tilgang til UH-IaaS og ble lovet inntil 200 instanser
  i en pilot for å dekke studentinstanser for 3 emner. Dette har økt bruken
  betraktelig i 2017.

- I tillegg til å finne brukere har vi brukt endel tid på å hjelpe brukere å
  ta i bruk UH-IaaS. Dette gjelder bl.a. tilpassing av image og prosjekter.

- Vi har også brukt tid på å lage egne image slik at vi kan frigjøre diskbruk
  over tid. Filer som blir slettet på en instans blir ikke automatisk frigitt
  på den underliggende lagringen. Det vil føre til at diskbruken for instanser
  som lever lenge vil gradvis øke til maks selv som disken er tynnprovisjonert.
  Vi har gjort endringer i Openstack og jobber nå med å få satt opp en egen
  imagebuilder.

- Videreutvikling av tjenesten blitt nedprioritet etter vi gikk i produksjon i
  november 2016 og frem til nå. Vi jobber nå med en utviklingsplan for 2017.
  Denne er ikke klar enda siden prioriteringen vil være avhengig av
  eksternfinansierte oppgaver. Det vil komme en mer detaljert plan i
  `Trello <https://trello.com/norcams>`_

- De to utviklingsløpene vi har for tiden er Designate (DNS) og Ceilometer
  (telemetri og forbruksdata). Designate er ikke langt unna produksjon, mens
  Ceilometer vil kreve mer tid før den er klar.

- Vi har fått tilgang til RT (Request Tracker) hos UNINETT slik at vi kan
  ta imot support-henvendelser på epost (support@uh-iaas.no).

Planlagte aktiviteter
=====================

- Fortsette å hjelpe brukere med å ta i bruk tjenesten
- Jobbe videre med Designate og Ceilometer
- Vaktordning i arbeidstiden for RT, Slack (brukersupport) og Sensu (monitorering)
- Lage halvårsplan for våren 2017

Utfordringer
============

- Vi har IP-addresser til ca 480 instanser. Per nå har vi ca 300. Vi er i dialog
  med UNINETT om tilgang til flere adresser og har også fått hjelp av nettgruppen
  ved USIT i dialogen med UNINETT.

- Dersom diskbruken for OS i instanser forsetter å øke vil vi om ikke altfor
  lenge trenge mer disk. Vi har penger igjen fra i fjor til å kjøpe mer disk.
  Vi ligger nå i BGO på 20-40% bruk på de aktive compute nodene.

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

- Planen er å lage en kort rapport hver uke (klar sense mandag morgen).
  For mer detaljert oppfølging vil man bruke Trello. Tilgang til lukkede tavler
  vil bli gitt til dem som trenger det utenfor teamet.
