=======
Lagring
=======

Sist endret: 2017-04-21

Dagens situasjon
================

Vi har idag et Ceph-cluster per region med følgende oppsett:

* Antall noder: 5
* Antall disker (OSD) per node: 10
* Størrelse disk: 2TB
* Kopier: 3
* Antall pool: 1 (Openstack Cinder)

Det gir oss ca 32TB per region som brukes i sin helhet til volum-tjenesten
som er block storage som kan monteres på instanser som vanlige disker.

Fremtidig mål
=============

Vi ønkser å kunne tilby to forskjellige lagringsløsninger til sluttebrukere,
samt benytte sentral lagring til OS-diskene (den disken som følger med instansen).

Kravene til de forskjellige lagringsløsningene vil være forskjellig så det mest
økonomiske på sikt er å ha det på separat hardware.

De tre largringsløsningene:

* **Rask lagring (SSD)**: intern bruk til sentral lagring av OS-disk
* **Standard lagring:** volum-tjenesten som idag
* **Masselagring:** object storage

Rask lagring
------------

Dette er den som haster aller mest. Vi lagrer idag OS-disken lokal på compute,
og vi ser at bruken av den disken er raskt økende og vil møte en fysisk
begrensning i løpet av 2017 (ikke plass til mer disk). Bruken er heller ikke
likt fordelt mellom compute hoster.

Standard lagring
----------------

Denne er lite brukt og dersom vi skal prise denne basert på lagringsplass og
innkjøpskostnad vil det ikke være en attraktiv lagringsløsning for noen.

Dette er per idag i teorien kun en tjeneste for veldig spesielt interesserte,
og er kun en `proof of concept` for at den teknologien vi har valgt ser ut til
å fungere som planlagt. Vi ser ingen hast i å utvide denne.

Masselagring
------------

Som en del av prosjektsøknaden til UH-Sky så er planen å kunne levere object
storage i løpet av året. Hvorvidt det blir snakk om full produksjon eller en
pilot vil avhenge av investeringsmidler.

Plan
====

Rask lagring
------------

Dette arbeidet er prioritert. Vi har litt penger igjen fra 2016 som gjør at vi
kan få dette til relativt raskt.

Planen er følgende:

* Vi kjøper inn 5 x 800GB disk til hver av storage nodene og erstatter halvparten
  av dagens 2TB disker.
* Lager et nytt pool kun på SSD med 2 kopier (mot 3 for de andre poolene)
* Vi får da et pool til OS-disk på 5 x 5 x 800 GB / 2 = 10TB
  (dagens løsning er ca 580GB per compute host, som gir ca 3,5TB)
* Pris per lokasjon blir ca 125K med de samme prisene vi fikk i januar
* På sikt kan vi doble antall SSD og også kapasiteten til 20TB og avvikle/flytte
  volum-tjenesten

Standard lagring
----------------

Som et resultat av endringen over vil kapasiteten her bli halvert. Ellers
ingen planer.

Masselagring
------------

Det tekniske arbeidet med å sette opp object storage var først satt til våren 2017,
men pga manglende personell blitt utsatt til høsten 2017.

De kravene vi så langt har satt for tjenesten er:

* Vi trenger å lage et HW plan som gir konkurransedyktige priser
* Pris på HW kan avgjøre valg av software
* Tilby snapshot
* Openstack Keystone som IDP
* To releaser en intern og en ekstern (kan være en pilot)
* Vi ønsker å teste både Openstack swift og ceph

Det er satt av rundt 400K ved UiB som kan brukes på HW til en pilot.
