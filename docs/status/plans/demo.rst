=============
Demo-prosjekt
=============

Sist endret: 2017-07-26

Konsept
=======

Vi har et mål om at alle brukere av UH-IaaS skal få mulighet til å teste det
uten å måtte betale eller gå via lokale godkjennere. Siden antall brukere er
alle med konto hos en tilsluttet organisasjon så vil denne bruken kunne utgjøre
en betydelig stor andel av den total bruke av UH-IaaS.

Demo-prosjekt er et forslag for å innfri målet, uten å risikere at denne bruken
blir så stor at det går utover betalende brukere.

Forventningavklaring (Terms of service)
=======================================

Resurser brukt av demo-prosjekt skal kun kjøre på ledig kapasitet. Det vil si
at ved kapasitetutfordringer vil alle resurser brukt av demo-prosjekt kunne bli
stoppet, flyttet eller slettet. Dersom dette inntreffer skal brukerne av
demo-prosjektet bli informert om hva som er endret.

Navn
====

Demo-prosjekt vil få navn **DEMO-<navn>-<org>** og merkes med :file:`type=demo`
Eksempel: **DEMO-raymond.kristiansen-uib.no**

Kvote
=====

Kvoter blir satt per region.

Compute:
--------

* **Antall instanser**: 2
* **vCPU**: 2
* **Minne**: 2GB

Storage:
--------

* **Antall volume:** 1
* **Snapshots**: 3
* **Lagringsplass:** 20GB

Innføring
=========

1. Oppdaterer brukerdokumentasjonen med terms of services for demo-prosjekt
2. Alle nye som registrerer seg får nå demo-prosjekt
3. Alle eksisterende brukere får opprettet et demo-prosjekt
4. Alle eksisterende brukere får epost om at de nå har fått et demo-prosjekt og
   at det personlige prosjektet vil bli avviklet på en dato. Godkjenner kan
   bestille videreføring av personlig prosjekt.

Fremdriftsplan
--------------

Steg 1. og 2. kan utføres med en gang. Steg 3. og 4. bør gjøres samtidig og krever
at man setter en dato for avslutting. Det krever også prismodell og en gjent
godkjenner ved alle tilsluttede organisasjoner.
