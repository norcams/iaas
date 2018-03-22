=================
Workshop 1 - 2018
=================

Samling i ved USIT 6. og 7. mars 2018.

Agenda og referat ble ført i Trello. Siden alt som ligger i Trello er i konstant
endring ligger det en kopi av alt som ble diskutert under.

.. contents:: Innhold

Arbeidsplan vår 2018
====================

Mindre oppgaver
---------------

* Anycast for DNS mot resolver-noder
* Sette opp twitter-konto for varsling
  (ink prøve å lage et varslingsystem som oppdaterer alt samtidig)
* Oppgradering til pike før sommeren
* Reset API password
  Vi kan legge inn en knapp i access som kjører en reset api passord
* Ceph dashboard
  Setter det opp på mgmt og via haproxy på api

Tilgang til andre enn FEIDE-konto
---------------------------------

Mulig løsning:

* brukere lager ad-hoc gruppe i dataporten først
* oppgir id til gruppen ved bestilling
* vi legger inn gruppe id som metadata til prosjekt
* cronjob som sjekker dataporten api og gir tilgang til dem som ligger i gruppen (vi må sjekke om vi kan se medlemmer i en gruppe med dataporten api)


Uprioriterte oppgaver:
----------------------

* Heat
* Manilla (med CephFS backend)
* Grafana dashboard på status (ekstern) og monitor (intern):

  * (status) flytte driftsmeldinger og nyheter ut av grafana på status
  * (status) legg inn mer statistikk om bruk på status (f.eks. brukte cores i az/region)
  * (monitor)lage dashboard for vakt med så mye info som mulig
  * (monitor) all info om host

Oppgaver til fremtidig plan
===========================

Trove
-----

Trenger db-folk til å sette opp.

Krav til tjenesten:

* geo-redundant
* transaksjonsstøtte (RDB)
