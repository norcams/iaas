=================
Workshop 2 - 2019
=================

Samling i Bergen ved UiB 1. og 2. oktober 2019.

Agenda og referat ble ført i Trello. Siden alt som ligger i Trello er i konstant
endring ligger det en kopi av alt som ble diskutert under.

.. contents:: Innhold

Arbeidsplan høst 2019
=====================

Ny oppgaver
-----------

* Bytte navn
* Uplink OSL
* Survey
* mistral - har vært spurt etter cron-tjeneste
* cloudkitty - krever gjennomgang av gnocchi

Dersom tid
----------

* Oppdatere/flere test anlegg
* Manila revisited
* Congress - kan kanskje brukes til å overvåke bruk av HPC ressurser
* rally - testing
* cyborg - venter til Train

Diskusjon
=========

Hardware
--------

**OSL og BGO**:

* garanti går ut nov 2019 på det første vi kjøpte inn i starten (3 ctrl, 3 compute, 4 leaf, 5 storage, 1 mgmt-switch)
* ctrl: 3 (4) nye controllere (utvide garantien)
* leaf: vi kan sende en ubrukt leaf fra osl til bgo som backup
* storage: kjøre uten garanti (iallefall ut 2020), vi vil avvikle volume/image i osl
* compute: compute-0[1-3] kan kjøre uten garanti

**BGO**:

* kommer kanskje penger til HPC og controllere i 2019

**OSL**:

* kanskje 7 nye storage noder
* kanskje 2 nye compute

**Avvik**

* mangler 2 spine (32 x 100 GBit)  i OSL (ca 300K ink mva + software)

Oppdatere TOS
-------------

**Metadata prosjekter:**

* Raymond lager forslag til nye felter/tags


**HPC prosjekter**:

* betalte dedikerte ressurser (f.eks. atlas og alice) - vi ser for oss et vist volum på dette
* HPC-aggregatet: overvåke bruk, begrenset med compute,
* HPC i shared (default-1): ok, for små instanser (m1) som kjører i mindre perioder (maks dager) - dette brukes i dag
* sette begrensninger i shared flavor (f.eks m1 og m2)?
* nedetid hver måned: 1. torsdag hver måned 14:00-16:00 (alle compute som ikke kan migreres)
* annen nedetid: gjøres ved behov og skal varsles

**DEMO-prosjekt**:

"As a result, we  see that we need to implement a policy change in the near future for demo
projects, which includes automatic termination of long running instances, in
order to meet the requirements of standard projects.
"

* hvor lenge kan en demo instans kjøre: 90 dager maks
* varsle etter 60 - 75 - 89
* sender første mail med 30 dagers frist (+ 24 før)
