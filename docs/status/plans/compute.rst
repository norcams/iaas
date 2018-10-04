==============
Ressurstilgang
==============

Last changed: 2018-10-04

Compute
=======

Vi begrenser tilgangen til compute noder ved å begrense tilgangen til host
aggregatet de står i. Hver availability zone (AZ) kan bestå av flere host
aggregat slik at dette ikke vil være synlig for brukere.

Pr prosjekt
-----------

Vi kan sette :file:`filter_tenant_id` i host aggregatet for å begrense tilgangen
til kun de prosjektene vi oppgir. Dette skalerer veldig dårlig å bruker når det
er flere enn et prosjekt som skal ha permanent tilgang.

Pr flavor
---------

Vi kan bruke :file:`AggregateInstanceExtraSpecsFilter` til å begrense tilgangen
til et aggregat til kun å de flavors vi ønsker.

Dette er nå satt opp for windows1 aggregatet i default-1 AZ.
Det løses på følgende måte:

Vi innfører en ny property, type, som settes på host aggregate og flavor.
For å kunne starte en instans må type være det samme i flavor som i aggregate.

Dersom vi ikke velger noe vil puppet/himlarcli sette :file:`type=standard`.
Dvs at alle flavors kan kjøres i alle host aggregates. Dette vil være et scheduler
filter som vil fungerer binært. Dvs. alle sjekker er true/false og vil ikke kunne
vektes.

Dersom vi ønsket å begrense tilgangen til et aggregate så kan vi sette type til
noe annet. Husk at kravet til match går begge veier. Dvs. at dersom `type=Z`
settes for aggregate `agg1` så vil du ikke kunne bruke det til noen av dagens
flavor (hvor type != Z). Samme gjelder for en ny flavor med `type=Y`.
Den vil aldri kunne startes før det finnes en aktiv host med ledig kapasitet i
et aggregate hvor også type=Y er satt (dette aggregatet vil heller ikke kunne
kjøre noe annet).

Konsekvenser
~~~~~~~~~~~~

* Vi vil ikke kunne teste alle flavors i `placeholder1` lenger.
* en flavor kan kun ha en type
* et aggregate kan kun ha en type
* dersom resize er mulig kan man endre flavor etter at instansen er startet og
  derfor kjøre instanser i andre aggregate enn tiltenkt

Eksempler
~~~~~~~~~

* vi kan løse windows linsensproblemet med å lage en `type=windows`
* vi kan begrense tilgangen til hcp-hoster med å lage `type=hpc`
