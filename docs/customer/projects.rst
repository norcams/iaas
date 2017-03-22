========
Prosjekt
========

Sist endret: 2017-03-22

.. NOTE::
  Under arbeid. Dette er et utkast og ikke et endelig dokument.

Prosjekt er den arbeidsflaten man har i UH-IaaS for å konsumere ressurser.
Hvert prosjekt har sin egen kvote og kan få tilgang til egne flavors.
Tilgang til et prosjekt blir gitt via grupper av brukere. Prosjekter kan
nøstes, men har ingen arv.

Alle ressurser i prosjektet, det kan være instanser, lagring eller image,
er kun tilgjengelig i prosjektet og kan ikke flyttes eller deles med andre
prosjekter.

Prosjekttyper
=============

Demo
----

Alle brukere får tilgang til et demoprosjekt som har en minimal kvote:

* Instanser: 1
* vCPU: 1
* Minne: 2 GB

Dette er ment å kunne brukes til testing og vi kan ikke garantere lengre oppetid
for instanser som kjører i demoprosjekt. Ved teknisk- eller ressursproblemer vil
instanser kunne blir skrudd av eller slettet. Prosjektene merkes med hvilke bruker
de tilhører og ordet DEMO. Organisasjonene betaler en årlig avgift for å dekke
bruk av demoprosjekter. Disse vil bli slettet når brukeren slutter.

Personlig
---------

Dersom det ikke er aktuelt å jobbe sammen med andre eller dele ressurser med andre
kan man få opprettet et personlig prosjekt. Dette vil typisk være aktuelt for
studenter som trenger de samme ressursene gjennom hele studietiden. Disse vil bli
slettet når brukeren slutter.

Bestilling, kvoter og flavors kan bli gitt etter henvendelse fra
lokale administratorer eller via integrering med FS/LMS.

Felles
------

Dette er den vanligste form for prosjekter hvor man deler på ressursene i et
prosjekt med flere brukere. Dette vil være aktuelt for forskningsgrupper,
studentforeninger eller andre typer team som jobber sammen.

Bestilling, tilganger, kvoter og flavors kan bli gitt etter henvendelse fra
lokale administratorer.

Kurs
----

Kursprosjekt er midlertidige prosjekter som blir brukt i forbindelse med
undervisning. Hver deltaker, undervisere og studenter, vil få sitt eget prosjekt.
Prosjekt vil bli slettet når undervisningen er over.

Denne produkttypen vil kunne administreres via integrering mot FS/LMS.

Kvote og betaling
=================

Betaling vil skje ved at hver organisasjon blir fakturert for all bruk i
sine prosjekter (med unntak av demoprosjekt). Priser er per måned og vi vil
faktuere hver 6. måned.

Fakturagrunnlaget vil bli hente ved å telle kjørende instanser på X, Y, eller Z.

For å gjøre det lettere å planlegge ressursbruk er det mulig å sette kvoter på
prosjektene som vil begrense hvor mye ressurser et prosjekt kan bruke.
