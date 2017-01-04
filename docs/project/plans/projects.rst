.. |date| date::

======================
Prosjektadministrasjon
======================

Sist endret: |date|

All aktivitet som ikke kan utføres i personlige prosjekter krever at vi
oppretter et nytt prosjekt for oppgavene og tildeler kvoter til den.

Det er ønskelig at både oppretting av nye prosjekter og prosjektadminstrasjon
(legge til nye brukere til et prosjekt) kan skje ved selvbetjening, men
for øyeblikket er det en manuell prosess.

Navngiving
==========

Prosjektnavn bør være så informativt som mulig. Vi kan inkludere følgende
elementer i prosjektnavn:

* **org**: organisatorisk tilhørighet (f.eks. uninett, uio, uia)
* **type**: prosjekt type (f.eks. test, student, research, course)
* **navn**: hvem prosjektet tilhører, grupper eller person (f.eks. osys, inf110)

Kvote
=====

Så lenge det ikke koster penger så bør vi være restriktiv med kvotene. Utover
det så er det ingen formelle krav til størrelse eller hvem som kan få så lenge
det er kjent hva det skal brukes og formålet er innenfor kjerneområdene våre
(forskning, formidling og utdanning).

Oppretting
==========

Bruk :file:`project.py` i `himlarcli` for å opprette prosjektet. Dersom `type`
er definert i :file:`config/quotas.yaml` vil det bli kvoten i den regionen
scriptet kjøres i (f.eks. bgo). Kvoter settes per region, mens prosjektet er
felles for alle regioner. For å sette kvote i andre regioner må scriptet kjøres
på nytt i den aktuelle regionen. Scriptet kan også brukes til å gi andre enn
eier tilgang til prosjektet (grant).
