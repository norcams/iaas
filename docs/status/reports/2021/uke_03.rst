
======
Uke 03
======

av Raymond Kristiansen, NREC, 22. januar 2021

Status opprydding etter strømbrudd
==================================

Lørdag 16. januar ble det utført vedlikeholdsarbeid på strømtilførselen til
NREC sitt utstyr i datahallen til UiB. Det gikk ikke etter planen og
resulterte i at vi mistet all strøm flere ganger i løpet av
dagen. Dette resultert bl.a. til følgene problemer i ettertid:

* en management switch fikk korrupt disk og måtte reinstallers on site
* enkelte maskiner kom ikke opp i rett tilstand og måtte manuelt fikses
* vi mistet 65 objekter i Ceph-lagringen (primærlagringen til NREC)

Det siste punktet er kritisk og berørte data til NREC sine brukere. Vi tror
vi vet hvorfor Ceph fikk problemer og skal implementere tiltak for å unngå at
dette skjer igjen.

Manglende objekter i Ceph
-------------------------

Objektene i Ceph som var tapt påvirket i alt 33 volum i NREC. Disse volumene
var brukt av 12 forskjellige prosjekter. Vi varslet først eier av prosjektene
direkte om problemene på mandag 18. og ba dem ikke bruke disse mens vi
undersøkte problemene.

Vi kopierte så ut alle berørte volum fra Ceph og undersøkte tilstanden. Det
viste seg at filsystemet som ble brukt er avgjørende er avgjørende for
hvor skadet volumet ble. For de aller fleste ext4 systemene (totalt 19)
var det ingen tilsynelatende datatap. Mens for xfs var det kun 1 av 14 som
ikke var skadet i en eller annen form.

Det tok tid å gå igjennom alle volum, men onsdag 20. ble det sendt en ny epost
til de berørte prosjekteierne om resultat av våre undersøkelse og forslag til
tiltak de kunne gjøre.
