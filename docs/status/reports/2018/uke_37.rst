======
Uke 37
======

av Raymond Kristiansen, UH IaaS, 17.september 2018

Oppdatert informasjon om status finnes alltid i
`Trello <https://trello.com/norcams>`_

.. contents::

Status
======

Lørdag 15. september var det brudd planlagt vedlikehold ved UiB. Det medførte
et varslet mindre brudd i nettverket til tjenester og instanser i BGO. Det mest
kritiske var database-clusteret som vi stoppet manuelt for å unngå 'split brain'.
Et større problem oppstod ved testing av UPS som medførte at 4 compute noder i
BGO mistet strømme. Disse var nede i ca 30 minutter. 68 kjørende instanser
gikk også ned i denne perioden. Disse kom opp igjen når compute nodene kom tilbake.

I forbindelse med oppgradering av Ceph fikk vi litt problemer med OSL. Antall
OSDer (disker) er for få etter at vi bygget om med SSD til OS-disker.
Dette medførte problemer ved oppgradering og reinstallasjon. Brukere
opplevde at volumet de hadde på instansen ikke lenger var responsivt.
OS-disken ble ikke berørt og stikkprøver vi utførte klarte ikke å gjenskape
problemet brukere opplevde. Problemene var størst 7. september når vi tok
den første storage noden i OSL. Tiltak ble tatt for de resterende nodene slik at
problemene for brukerne ble mindre eller fraværende på de andre storage-nodene.

SELinux er nå satt til enforcing på på alle noder som er eksponert mot internett.
Vi tester det nå på compute og vil etter hvert også skrue det på på de resterende
nodene (interne noder som logger, monitor, foreman, etc).

Vi har brukt litt tid på å lage et system for å varsle brukere. Vi kan nå varsle
brukere på både Twitter og Slack enkelt når det oppstår problemer. Vi lagrer også
alle varsler i egen database som er tilgjengelig for alle via et API.

Det har til tider vært treg respons på enkelte API. Vi har jobbet med å øke
ressursene og skalere opp tjenestene. Vi samler også inn metrics og kommer til
å jobbe med å forbedre dette kontinuerlig.

Vi bruker nå egne DNS-servere som resolver på alle instanser.

Det blir samling i Bergen for hele teamet denne uken, 19. og 20. september.
Vi skal da lage en grov plan for arbeidet de neste 6 månedene.

Utfordringer
============

Vi begynner å gå tom for compute ressurser, spesielt i OSL. Der har vi nå gikk
vekk ca 3 ganger så mange VCPUs som vi har logiske kjerner (6 ganger mot fysiske
kjerner). Vi kan forsatt overprovisjonere litt mer, men i løpet av høsten må vi
ha flere compute hoster.

Vi ser også at vi også sliter litt med Ceph i OSL. Vi trenger 2 nye storage noder
slik at OSL blir like stor som BGO. Vi har rammer til Dell servere og 2 TB disker
vi kan bruke til disse.

Planlagte aktiviteter
=====================

- Fortsette å hjelpe brukere med å ta i bruk tjenesten
- Oppgradere til ny Openstack-versjon: **Pike**
- testing av DNSaaS med Designate
- Pilot objektlagring

Annet
=====

- Se https://trello.com/norcams for oppdaterte planer.
