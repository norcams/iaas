======================
Prosjektadministrasjon
======================

Sist endret: 2017-03-06

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

Bruk :file:`project.py` i `himlarcli` for å opprette
prosjektet. Dersom `type` er definert i :file:`config/quotas.yaml` vil
det bli kvoten i den regionen scriptet kjøres i (f.eks. bgo). Kvoter
settes per region, mens prosjektet er felles for alle regioner. For å
sette kvote i andre regioner må scriptet kjøres på nytt i den aktuelle
regionen. Scriptet kan også brukes til å gi andre enn eier tilgang til
prosjektet (se under).

Gi tilgang
==========

Bruk :file:`project.py` i `himlarcli` for å gi tilgang til flere
brukere i prosjektet. Eksempel::

  ./project.py grant -u user@foo.bar -p foo-bar-project


Kurs
====

Det er laget et eget opplegg for administrasjon av kursprosjekter. Kort fortalt
fungerer det på følgende måte:

* foreleser og studenter får tilgang til sitt eget prosjekt med navn: <org>-<kurs>-<epost>
* foreleser får rollen superuser i sitt eget prosjekt og user i studentenes prosjekter
* foreleser kan lage public image i sitt prosjekt med superuser rollen


Verktøy
-------

Bruk :file:`course.py` i `himlarcli` for å opprett, liste ut eller slette
kursprosjekter. Når man kjører `create` må man huske på følgende:

* **name**: kursnavn må være på formen <org>-<kurs>. F.eks. uib-inf110
* **user**: er navn på foreleser som må ligge i system før man starter
* **file**: fil med liste over epostadressene til studentene (case sensitiv)

Studentene vil ikke få tilgang før skriptet er kjøret etter at de er i systemet.
Man kan gjenta scriptet så mange ganger man vil med samme input.
