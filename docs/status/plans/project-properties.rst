=========================================
(KLADD) Tags og properties for prosjekter
=========================================

Sist endret: 2020-08-13

Tilknyttet institusjon
======================

Tilknyttet institusjon er noe vi allerede spør etter i
bestillingsskjemaet for prosjekter. Årsaken til at vi spør er for å
kunne sette et fornuftig navn på prosjektet. Navnet skal normalt
inneholde forkortelsen til institusjonen.

Forslag
-------

Gjelder kun shared-prosjekter, dvs. ikke PRIVATE eller DEMO.

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
   property.

#. Det bør lages en alarm eller annen varsling dersom det finnes
   prosjekter i Dataporten-domenet (unntatt PRIVATE og DEMO) som
   mangler property org.

