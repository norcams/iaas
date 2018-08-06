======
Uke 31
======

av Raymond Kristiansen, UH IaaS, 6.august 2018

Oppdatert informasjon om status finnes alltid i
`Trello <https://trello.com/norcams>`_

.. contents::

Status
======

Lang tid siden forrige rapport så dette blir en kort oppsummering siden sist.

Vi har oppgradert Openstack versjon fra Newton til Ocata. Dette tok mye lenger
tid enn planlagt. Arbeidet ble påbegynt i april, mens selve oppgraderingen
ble utført 19. juli. Oppgraderingen ble varslet på forhånd og medførte nedetid
på tjenesten, mens kjørende instanser ikke ble påvirket. Arbeidet tok ca 2,5
time og det meste gikk etter planen. Vi fikk litt problemer med volum-tjenesten
i OSL, slik at den ikke var tilgjengelig før det var gått ca 4 timer.

Planen er å starte på oppgradering til Pike med en gang, og vi kommer til å
ta med oss erfaringene med Ocata når vi legger planen for Pike. Målet et at
tidsrammen fra start til fullføring nå blir 3-4 uker.

Telemetri-tjenesten er nå operativ slik at vi nå kan få rapporter om bruk
pr time. Dette kan senere brukes til fakturagrunnlag.

Det har blitt satt opp egne DNS-tjenere som skal brukes til instansene. Disse er
satt opp som to par slik at vi totalt får 4 DNS-tjenere. Vi bruke anycast slik
at det blir en IP-addresse pr par i hver lokasjon. Vi vil da kunne ta ned en
tjener per lokasjon uten at brukere blir påvirket og vi skal kunne kjøre med
mindre forstyrrelser med kun 1 av 4 kjørende. Disse vil bli satt i produksjon
i nær fremtid.

Vi har også satt opp egne NS-tjenere som skal være autorative for våre domener
(uh-iaas.no og uhdc.no). Vi vil da ha full kontroll på domenene våre, og er ikke
avhengig av tjenester hos UNINETT, UiO og UiB.

Det er også jobbet med å skru på SElinux på alle tjenester som er eksponert
mot Internett, med unntak av compute i første omgang. Vi har kjørt det i test i
noen måneder nå og kommer til å skru det på i prod om kort tid.

Det er planlagt en større patching av servere i uke 32 som også inkluderer
oppgradering fra CentOS 7.4 til 7.5.

Utfordringer
============

Vi begynner å gå tom for compute ressurser, spesielt i OSL. Der har vi delt ut
litt over 900 VCPUs og 2,7 TB RAM fordelt på 6 aktive compute hoster. Vi kan
forsatt overprovisjonere litt mer, men i løpet av høsten må vi ha flere
compute hoster.

Planlagte aktiviteter
=====================

- Fortsette å hjelpe brukere med å ta i bruk tjenesten
- Oppgradere til ny Openstack-versjon: **Pike**
- Jobbe videre med Designate
- Pilot objektlagring

Annet
=====

- Se https://trello.com/norcams for oppdaterte planer.
