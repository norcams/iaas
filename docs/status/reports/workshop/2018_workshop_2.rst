=================
Workshop 2 - 2018
=================

Samling i ved UiB 19. og 20. septemver 2018.

Agenda og referat ble ført i Trello. Siden alt som ligger i Trello er i konstant
endring ligger det en kopi av alt som ble diskutert under.

.. contents:: Innhold

Diskusjon
=========

IP-adressering med CERN-workloads
---------------------------------

Hvis vi skal basere oss på public IPv4-adresser har vi et stort kapasitetsproblem.
Kan vi (de) bruke IPv6?

De skal prøve å bruke IPv6 network.

*Kommentar fra Raymond:* det viser seg at de kan bruke IPv6 for alt annet enn
slurm og det kan kjøres på innsiden med dualstack.


Driftede instanser
------------------

Vi lager felles system for image administrasjon, men lar hver org bestemme innholdet i imaget.

Forbedre brukeropplevelsen
--------------------------

* minimere planlagt nedetid (HA)
  lagsiktig plan (db, ekstern HA)
* responsivt API/GUI (LB)
  lager eget trello-board for tiltak og analyse
* forbedre kommunikasjon med brukere
* forbedre dokumentasjon
  se på forslag til forbedring
* spørre brukere (nettskjema)
   - hvordan fikk de høre om uh-iaas
   - hva savner du
   - hva fungerer ikke
   - hvem er brukeren (org ikke person)
   - begrensninger i uh-iaas
* eksempler
  lage et repo på github


Windows image-bygging - framdrift
---------------------------------

Vi tar en kickstart (trondham)
Se på problem med IPv6

Alternativ til cumulus
----------------------

Vi kan bruke OpenSwitch til det meste (unntatt spine og kanskje switchene til compute).

Nettverksdesign med CERN-rigg
-----------------------------

Det er kanskje rom for innkjøp av noe nettverksutstyr i forbindelse med CERN-riggene. Vi må (bør) bygge om nettverket, forhåpentligvis i en en leaf/spine-arkitektur.

Budsjett vil avgjøre hva vi får til. Vi ønsker 2 nye spine og kan bruke de 2 vi tok ut til storage.

Branding på dashboard
---------------------

Bytte OS-logo med UH-IaaS på dashboard-siden.

* Bytte til samme logo vi har på twitter
* lage logo uten nav

Forslag til å forbedre arbeidsmetoder
-------------------------------------

Er det ting vi kan gjøre for å forbedre kommunikasjonen i teamet og måten vi jobber på:

* trello (ink PR)
  vi dropper egne kort for PR, vi linker til trello i PR
* slack/irc
  slack vs irc: vi bruker slack til melding er som alle trenger å få med seg, ellers kan man bruke det man vil, endre ikke varsling på disse nå, kan vurder flere kanaler som alle er medlem av (kan spørre brukere)
* github
* hangout/videochat
* morgenmøte
  strenger på tidsbruk på runden, ta tekniske diskusjoner til slutt
* jobbe sammen to og to (uib/uio)
* deltid/fulltid
  ser ut til å fungere greit


Arbeidsplan høst 2018
=====================

Oppgaver
--------

* Fullføre oppgradering til Pike
* Oppgradere til Queens
* Object storage

Uprioriterte oppgaver:
----------------------

Manilla
~~~~~~~

Manila i Pike kan bruke CephFS som backend delt ut via NFS, som er den prefererte
metoden. Kan fungere som en pilot/beta.

Sannsynligvis er Openstack Queens det beste for prodsetting, med NFS-ganesha >2.7.
Da bør vi kunne oppnå HA på tjenesten, kanskje til og med A/A pNFS.
Bør være knall i padden.

Oppdatere status
~~~~~~~~~~~~~~~~

* vi skal bruke grafana
* vi lager en forsiden (som skal vises fint på mobil) og flere underside


* driftsmeldinger
* nyheter
* tilstand (alle api endpoint, dashboard, access) - grønn - (gul) - rød
* antall ipv4-addr i bruk/igjen
* ledige resurser (grønt/rød start ny instans)
* piwik / loganalyse??
* dager siden siste event
* eventlog
* responstid api

Datakilder

* himlarcli -> statsd
* statsd -> graphite eller gnocchi

GPU
~~~~

Om vi får mulighet det så se på vGPU eller PCI passthrough GPU.
Krever tilgang til hardware siden vi ikke har penger til å kjøpe dette selv.
