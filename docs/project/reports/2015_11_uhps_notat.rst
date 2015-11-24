================================
Notat om drift av IaaS-tjenesten
================================
av Jan Ivar Beddari, UH IaaS, 23.11.2015

.. contents:: :depth: 2

Introduksjon
============

IaaS-tjenesten som utvikles av UH IaaS-prosjektet er klar for produksjonssetting
15. desember 2015. Tjenestens omfang er beskrevet av `prosjektplanen`_
og omfatter utstyr plassert ved UiB, UiO og NTNU. Prosjektet har vært bemannet
med ressurser fra disse organisasjonene i utviklingsfasen.

Når tjenesten skal i bruk for produksjon er det nøvendig å diskutere felles
organisering og sette permisser for hva som skal gjelde videre. Dette
dokumentet fokuserer på hvordan vi per i dag mener dette bør fungere i praksis.

.. _prosjektplanen: http://iaas.readthedocs.org/en/latest/project/plan.html

UH Platform Services
====================

Vi foreslår å opprette en distribuert, delt driftsorganisasjon kalt *UH Platform
Services (UH PS)*. Organisasjonen sitt mål skal være å drifte, videreutvikle og
tilrettelegge tjenester i felles drift for hele sektoren innenfor rammer satt av
de deltakende organisasjonene. I første omgang begrenses dette til
IaaS-tjenesten.

I prosjektperioden har UH IaaS opparbeidet seg mye erfaring med distribuert
jobbing mellom organisasjonene. Prosjektgruppa er samlet enige om at å dedikere
utførende ressurser i 100% til UH PS er nødvendig for å opprettholde forsvarlig
leveransekvalitet i produksjon. Ressursene i UH PS bør formelt tilhøre
organisasjonene som deltar men med alle arbeidsoppgaver spesifisert av en
felles driftsorganisasjon. Et forslag til løsning kan være at en jobber mot en
modell med *utleie* av ressurser.

Oppgaver
--------

UH PS sin primære oppgave er drift og videreutvikling av en felles plattform
for IaaS som UH IaaS har lagt grunnlaget for. Slik prosjektplanen beskriver er
tre lokasjoner klare for produksjon, Bergen, Oslo og Trondheim.

UH PS vil med de ressursene som er beskrevet i dette forslaget kunne drifte
disse lokasjonene uten ytterligere tilførsel av personell til de når en
betraktelig størrelse. UH IaaS anslår at platformen kan utvides til minst 200
fysiske lagrings- og compute-noder per lokasjon uten merkostnader til
personell. I en situasjon hvor deler gjøres som forenklet leveranse (f.eks bare
compute) vil tallene være enda større.

UH PS vil også tilrettelegge og hjelpe til med gjenbruk av felles kode til mer
spesialiserte oppgaver. HPC ved UiT, compute-ressurser i SAFE (UiB) og TSD
(USIT) er eksempler på slike. UH PS vil etter avtale kunne hjelpe til med drift
og vedlikehold av disse og lignende tjenester innenfor tilgjengelige ressurser.

Support
-------

UH PS vil ha fullt ansvar for å utarbeide dokumentasjon og rutiner så de kan
fungere som 2/2.5 linje inn mot lokale organisasjoner sin support. En modell som
gjenbruker deler av metodikk og verktøy for support av HPC i sektoren er tenkt
som et utgangspunkt.

Vaktordning
-----------

UH PS ønsker ikke i utgangspunktet en egen førstelinje vaktordning. UH PS vil
ha en ordning med tilkalling hvis problemet når et visst eskalert nivå,
forsøksvis mellom kl 0800-2200.

UH PS vil jobbe mot å få til enkel integrasjon og varsling inn mot de lokale
organisasjonene sine eksisterende varslingssystemer. UH PS skal selv levere alle
nødvendige data for dette.

En tenker seg en modell med hospitering av denne varslingsfunksjonen, på
rundgang mellom organisasjonene. Det gjøres en kontinuerlig vurdering av av
denne tilnærmingen. Om erfaringene blir negative gjøres en revurdering av
behovet for egen vaktordning og varsling. I såfall vil ressursbehovet rundt
dette øke.

Organisering og ressurser
=========================

Vi mener mye av den praktiske modellen fra UH IaaS kan videreføres mens den
administrative siden må styrkes. UH PS sin daglige ledelse består av to roller,
en *teknisk leder* og en merkantil/administrativ *teamleder*. Disse skal
rapportere til de aktuelle lokale linjeorganisasjonene og til
UHsky-organisasjonen.

Personellressurser
------------------

UH PS sin initielle bemanning for drift av IaaS og støttefunksjoner som
beskrevet i dette forslaget vil være 5,4 stillinger.

Teamleder (40%)
^^^^^^^^^^^^^^^

*Teamleder* er en mindre stilling (anslått 40%) som skal være hovedkontakt
mellom UH PS og de deltakende organisasjonene for ressurser (personell) og
tjenester som UH PS har ansvaret for. Teamleder skal aktivt delta i all intern
planlegging og møtevirksomhet i UH PS og det er derfor nødvendig å ha en
ressurs med teknisk innsikt i denne rollen.

Teamleder har *delegert lederansvar* for ressursene i UH PS. Hvis en benytter en
modell med utleie, som foreslått ovenfor, vil teamleder ha ansvaret for å følge
opp at utleiekontrakter blir overholdt.

Teknisk leder (100%)
^^^^^^^^^^^^^^^^^^^^

*Teknisk leder* er en stilling på linje med dagens prosjektlederrolle i UH IaaS.
Teknisk leder har hovedansvar for drift og utvikling og skal også aktivt bidra
til at UH PS blir et attraktivt, utadrettet felles fagmiljø til nytte for hele
sektoren.

4 ingeniører (4x100%)
^^^^^^^^^^^^^^^^^^^^^
UH PS trenger fire ingeniører med seinornivå kompetanseprofiler på OpenStack,
Linux operativsystem-drift, automatisering/programmering, lagring og nettverk.

Prosjektgruppa for UH IaaS hadde ingen ressurser i 100% med hovedvekt på
nettverkskompetanse. USIT bidro med en stilling på 40% som ble en veldig viktig
nøkkelressurs i prosjektet men samtidig en flaskehals med tanke på tilgjengelig
tid. I UH PS vil det være spesielt viktig å ha en 100% stilling med en slik
kompetanseprofil.

Det anbefales at minst en 100% ressurs er fysisk plassert på hver av de tre
eksisterende IaaS-lokasjonene.

Risiko ved minimumsbemanning
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Ressursene beskrevet her er et absolutt minimum for å kunne ha en forsvarlig
driftssituasjon. Hvis en ønsker å redusere risiko for ikke-planlagt nedetid ved
f.eks sykdom eller andre uforutsette hendelser må bemanningen økes med
ytterligere en person. Dette vil gi rom for å fordele ansvaret bredere og dermed
øke tryggheten.

Budsjett til reiser og kurs
---------------------------

I dette forslaget administrerer UH PS ved teamleder sine egne personellressurser
og bør få ansvaret for kurs og reising. Det bør bli et uttalt krav at
reisevirksomhet skal holdes på et forsvarlig nivå. Erfaringene fra UH IaaS gir
oss et bilde på hva vi bør forvente av kostnader til dette.

* En ansatt i UH PS vil anslagsvis delta på 4 samlinger og 4 kurs/konferanser
  per år. Dette anslås til ca kr 80 000.

* Teknisk leder deltar på det samme pluss fire ekstra besøk hos lokale
  organisasjoner per år. Ca kr 100 000.

* Teamleder deltar på samlinger og lokale møter, inntil 8 reiser per år, ca kr
  50 000.

Evaluering av UH PS
===================

Hvis UH PS realiseres bør organisasjonsformen og leveringsevnen jevnlig
evalueres av ledere og organisasjonene som har eierskapet. I en oppstartsfase
bør dette skje så ofte som hver tredje måned. Det er viktig at evalueringen er
strukturert, men samtidig enkel, så både de som utfører den og mottakerene ikke
føler at dette tar for mye tid.

Evalueringen bør dreie seg både om interne ting rundt organisering og
kommunikasjon, og om tjenesteleveransen. Kvalitet, brukerforventning og alle
aspekter ved UH PS sine funksjoner eller forventninger til de ønskes belyst.

Vi tror at i en distribuert organisasjonsmodell er ryddig rapportering fra eiere
*tilbake* til organisasjonen viktig.
