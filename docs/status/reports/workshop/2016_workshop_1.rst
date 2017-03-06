=================
Workshop 1 - 2016
=================

.. toctree::
    :maxdepth: 1

    2016_agenda_1

**Tid og sted**: Avholdt i Oslo 15. og 16.mars.

**Tilstede**: Kjetil, Petter, Trond, Mikael, Hege (kun 15.) Jarle, Geir,
Øyvind, Tor og Raymond

**Disclaimer**: Referat basert på notatene til Petter og redigert av Raymond.
Om noen av dem som var tilstede oppfattet ting på en annen måte vennligst
gi beskjed til Raymond.

.. contents:: :depth: 3

Tirsdag 15. mars
================

Vi innledet med en rask presentasjon og diskusjon rundt dagens agenda.

Det ble avklart at USIT setter av ressurser i hele dager. Alle må føre inn i ressurs-planen.

Ansvaret for sikkerhetavklaringer ligger hos Kjetil Kirkebø

Det må avklares hvor det juridiske eierskapet ligger. Forslaget er at UiB tar eierskapet og at UiO skriver
databehandleravtale med UiB. Kjetil og Raymond tar dette videre.

Vi begynte med å tegne opp en skisse over prosjektet og forsøke å skape oss en felles oversikt.
Hege har tegning over nettverk og Raymond har begynt på en tegning over noder/tjenester.

Det må undersøkes hvordan SE-linux og Calico kan løse. Idag er må SE-linux disables. Calico ser ut til
være den beste løsningen pr. idag.

Dokumentasjon
-------------

Raymond har ansvaret for dokumentsjon:

* Trond skriver brukerdokumentasjonen

* Raymond skriver referat o.l

Teknisk dokumentasjonen skrives på engelsk og prosjektdokumentasjonen skrives på norsk.
Raymond omorganiserer dokumentasjonen noe.

github
------

Vi må bestemme hva som skal ligge ute på git-hub. Passord er fjernet, men må endres. De skal ikke ligge
på github. Passord-regime må forbedres.

Arkitektur ligger nå åpent og vi forsetter med det inntil videre.

Bruk av github må dokumenteres og det må lages felles rutiner. Vi tar en gjennomgang på onsdagen og
dokumenterer samtidig. Det er behov for å rydde i repo`er og automatisering.

Nye hieradata kan legges rett på master. Store hieradata endringer og alle
kodeendringer skal ikke legges direkte inn på master. Det er god rutine å
benytte pull-request for gjennomsyn. Det er ikke lov å ta egne pull-requests.

IRC-kanalen
-----------

Det er krevende å følge med på irc-kanalen. Ikke alle har kapasitet til å følge med daglig. Morgenmøte og
hovedpunkter på epostliste er steder for felles oppdateringer.

Trello
------

Vi forsetter med Trello av mangel på alternativ. Det er mulig vi bør se på en ny organiseringer av
oppgaver. Idag er det litt for mange saker og det er vanskelig å få oversikt. Raymond tar ansvar for en
omstrukturering. Trello har også en god mobilapp.

Lucidchart
----------

UiB har fått 10 lisenser (som Tor og Raymond bruker). Det er utfordring med at flere kan gjøre endringer.
Vi trenger å et alternativ hvor alle kan gjøre endringer og råfilene ligger på et felles sted.
yEd sees på som alternativ.

Møter
-----

Morgenmøter forsetter klokken 09:30. Lengre møter avtales ved behov på onsdager klokken 10:00. Det
må avklares innen morgenmøte på tirsdagen om det skal være onsdagsmøte.

Websider
--------

Vi fokuserer på leveranse og nedprioritere «markedsføring» på web.

Nytt dev-anlegg
---------------

Dev-anlegg er egentlig et testanlegg. Vi har et anlegge i Bergen (dev01) som fungerer, men vi trenger
også et i Oslo. Det bør være mulig, men vi trenger hardware. Trond går på skattejakt. Vi trenger disker for
å teste Ceph. Anlegget i Trondheim må avklares. Kjetil hører med Ola Ervik.

Lisenser
--------

Vi må avklare hvilken lisens vi skal bruke på IaaS-kode.

Kontotilganger
--------------

Kjetil sjekker hvem som har tilgang og kontoer. Det er behov for rydding.
(**Raymond**: denne er jeg usikker på hva gjelder)

Definisjoner
------------

* Instans = Virtuell maskin for sluttbruker på compute

* Node = Kjører tjenester i infrastrukturen. Kan være VM, container eller fysisk.

* Dashboard = kjører Openstack Horizon

Todo-liste
----------

Kjetil hadde en del ting han ønsket å få med her, det kom også flere forslag fra
deltakere.

**Raymond**: Ansvarlige er forslag fra møte, det vil nok bli endringer. Listen
er nok mer som en huskeliste enn noen endelig plan eller liste.


* Sikkerhet(Mikael/Trond)

  * Må på plass før 1.bruker

* Jus(Kan komme på sikt)

* Dok(Brukerdok=Trond og Tekniskdok=Raymond). Dokumentasjon av rutiner og
  enkle oppgaver med git-hub,puppet og vagrant eller andre rutineroppgaver

* SLA

* Definere tjenester

  * API

  * Portal/dashboard

  * Fakturering

* Teknisk:

  * Puppet(Raymond)

  * Data-porten(Øyvind)

  * Nett(Hege)

  * Lagring(Tor/Geir)

* Utenfor?:

  * DNS

  * Overvåking

  * Logging

Utestående for pilot
--------------------

* Service og public nett over transport

* Logging internt

* Sikkerhet må avklares

* Brukerdokumentasjon (Trond)

  * Tydelig oversikt over hva som kan forventes0

  * Hva får du/får du ikke

  * Hva er IaaS

* Overvåking (kan være aktuelt på sikt, men er da sannsynligvis bruk av UiOs løsninger)

SLA for piloten
---------------

* Det er et vedlikeholdvindu hver 4 uke for tjenester (API/Dashboard)

* Hver compute-instansene skal termineres hver 3 uke (en hver uke)
  Vi må være tydelige på at instansene ikke varer evig (de slettes når compute restartes)

* Best effort!

* Brukerhenvendelser går vi slack-kanalen uhps.slack.com direkte til oss

* Det er ingen backup.

* Alle data vil bli slettet i august/september når vi slår sammen keystone

Onsdag 16. mars
===============

Videre plan
-----------

* Pilot(20 april):

  * Vi setter en plan for produksjon av pilot til 20 april, med forbehold om at sikkerhet går som det skal

  * Første onsdagsmøte brukes til sikkerhet og legge en fremdriftsplan for sikkerhet

  * Vi trenger et par reinstallasjoner før vi er klar 20. april

  * Møte med Espen forsøkes 5 april

  * Raymond tar muligens en tur til Oslo den 15, samtidig med planlagt møte med Aryan fra UiS

  * Begynne å logging lokalt i IaaS

  * Sette opp dev-rigg i Oslo. Helst så lik som mulig

  * Tilgjengelig for alle ved UiO og UiB


* August/september:

  * Ønskes en full reinstallering når vi slår sammen keystone

  * Vi ønsker å samle inn behov og tilbakemeldinger via nettskjema

  * Det er ønske om en oversikt over hva løsningen gir i sammenheng med brukerdokumentasjonen

  * Finne brukere

  * Image bygging:

    * Base ordner prosjektet

    * Ekstern hjelp(HPC) hjelper til

  * Drift:

    * Hva og hvordan?

    * DNS

      * IP-adresse endrer seg etter 3 uker

      * Vi trenger en dynamisk løsning for kobling mot DNS

      * Noen må se på DNS rimelig raskt

      * Heat?

* Full produksjon 1 oktober 2016:

  * Ny SLA må på plass

  * Det må avklares om det skal være en tjeneste for "UH-sky"
    Inntil det er klart er dette en tjeneste for UiO og UiB

Annet
-----

* Object storage ønskes på planen frem i tid, men ikke i første fase og det må inn nye ressurser. Bør
  gjøres i innenfor dagens prosjektgruppe/rammer. Forventninger må tydeliggjøres av Raymond.

* UiB har lovet at det er ressurser utenfor prosjektet som vil lage og vedlikeholde images.
  UiO har også grupperinger som sannsynligvis kan delta. "Noen" må holde dette.
