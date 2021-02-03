=========================================
(KLADD) Tags og properties for prosjekter
=========================================

Sist endret: 2020-09-09

Tilknyttet institusjon
======================

**Bakgrunn**: Tilknyttet institusjon er noe vi allerede spør etter i
bestillingsskjemaet for prosjekter. Årsaken til at vi spør er for å
kunne sette et fornuftig navn på prosjektet. Navnet skal normalt
inneholde forkortelsen til institusjonen. Innføring av dette er en
forutsetning for god automatikk rundt deling av spesialiserte images
basert på tilknyttet institusjon.

Forslag
-------

Gjelder alle prosjekter i domain Dataporten, inkludert PRIVATE og
DEMO.

Vi setter institusjon som en **property** med navn **org**, dvs. at
feltet kan kun ha én enkelt verdi. Eksempler:

===========  ===============================================
Forkortelse  Institusjon
===========  ===============================================
uio          Universitetet i Oslo
uib          Universitetet i Bergen
uit          Universitetet i Tromsø
ntnu         Norges teknisk-naturvitenskapelige universitet
nmbu         Norges miljø- og biovitenskapelige universitet
nrec         NREC interne prosjekter
===========  ===============================================

Sette property::

  openstack project set --property org=uio test-project

Hva må gjøres:

#. Eksisterende shared-prosjekter må få satt property **org**, basert
   hovedsakelig på prosjektets navn, som i de fleste tilfeller skal
   inneholde riktig institusjon. Dette gjøres manuelt.

#. Himlarcli-scriptet **project.py** må skrives om til å kunne sette
   property **org** ved prosjektets opprettelse.

#. Det bør lages en alarm eller annen varsling dersom det finnes
   prosjekter i Dataporten-domenet (unntatt PRIVATE og DEMO) som
   mangler property org.

#. Himlarcli-scriptet **image.py** må skrives om til å kunne dele ut
   shared images basert på property **org**


Kontaktinfo
===========

**Bakgrunn**: I en del tilfeller er det upraktisk å bruke admin som
kontaktpunkt for prosjekter. Det kan være ønskelig med muligheten til
å sette et alternativt kontaktpunkt, f.eks. en e-postliste, for et
prosjekt.

Forslag
-------

Gjelder kun shared-prosjekter, dvs. ikke PRIVATE eller DEMO.

Vi setter kontakt som en **property** med navn **contact**, dvs. at
feltet kan kun ha én enkelt verdi. Dette skal ikke være obligatorisk,
men valgfritt og skal kunne brukes for de som ønsker å ha en
e-postliste som kontaktpunkt for prosjektet, istedenfor en privat
e-postadresse.

Sette property::

  openstack project set --property contact=mail-liste@usit.uio.no test-project

Hva må gjøres:

#. Himlarcli-scriptet **project.py** må skrives om til å kunne sette
   property **contact** ved prosjektets opprettelse.

#. Oppdatere bestillingsskjemaet for prosjekter

#. Varsle brukere om at denne muligheten finnes

#. Oppdatere automatikk (f.eks. script som varsler admin) til å bruke
   contact-feltet dersom det eksisterer


Admin
=====

Navnet "admin" er villedende idet admin ikke har ekstra privilegier,
det er kun en kontaktadresse for den som bestilte prosjektet i
utgangspunktet.

Forslag
-------

Endre "admin" til "owner".

Hva må gjøres:

#. Himlarcli-scriptet **project.py** må skrives om til å sette
   property **owner** istedenfor admin ved prosjektets opprettelse.

#. Oppdatere automatikk som i dag bruker admin-feltet

#. Endre **admin** --> **owner** for alle eksisterende prosjekter.

#. Oppdatere bestillingsskjemaet dersom dette refererer til admin


