UH IaaS status 2015-06
======================
Rapport til UH-sky styringsgruppe av prosjektleder Jan Ivar Beddari, den 15.6.2015

.. contents:: Oversikt

Innledning
----------

15. juni var sluttdato for UH IaaS-prosjektet slik det ble vedtatt av UH-sky
styringsgruppa i juni 2014. Dette dokumentet oppsummerer status per sluttdato med
utgangspunkt i målene i den `vedtatte prosjektplanen`_.

.. _vedtatte prosjektplanen: http://iaas.readthedocs.org/en/latest/project/plan.html

Mål som ikke er leveringsklare
------------------------------

Leveransemålene er beskrevet i prosjektplanen som aktiviteter. Akvititet 1 og 2
ble vedtatt gjennomført og tilført ressurser.

1. Develop, document and deliver a base IaaS platform
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

*Ca 75% av målene er nådd.*

Hovedlinja i arbeidet som gjenstår er å koble sammen lokasjonene slik at
brukeren ser en helhetlig, sammenkoblet tjeneste. Dette er et av hovedkravene
for en funksjonell løsning.

Utestående oppgaver i den underliggede infrastrukturen:

* Nettverksinfrastrukturen som kobler IaaS-lokasjonene sammen med er planlagt
  men ikke ferdig implementert. IP-adresser har vært et diskusjonstema som nå
  ser ut til å løse seg ved at UH IaaS får adresser fra UNINETT.

* Prosjektet har ikke nok operativ erfaring med lagringssystemet, per juni
  2015. Denne erfaringen trenger vi mer tid for å bygge opp.

2. Integration of authentication and authorization
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

*Ikke påbegynt.*

Omfatter integrasjon av Feide med UH IaaS for å gi påloggingsmulighet til alle
brukere i sektoren. I prosjektplanen ble dette arbeidet estimert til mellom 200
og 300 timer for en *enklest mulig fungerende løsning* med Feide-tilknyttet
pålogging.

Underveis i prosjektet har en kommet fram til at en Feide Connect pilot og
integrasjon er sterkt ønsket. Dette vil være i størrelsesorden ca 600 timer.

Årsaker
-------

Ressurstilgang
^^^^^^^^^^^^^^

Hovedårsak til at prosjektet ved sluttdato ikke kan levere i den grad
prosjektplanen forutsetter er ressursmangel gjennom hele prosjektperioden.

* I prosjektplanen forutsettes det 5 stillinger pluss prosjektleder i ett år,
  totalt 6 stillinger. Prosjektet har i praksis manglet 1/3 av dette og hatt 4
  stillinger:

  * Prosjektleder Jan Ivar Beddari (100%)

  * Tor Lædre (UIB, 100%)

  * Erlend Midttun (NTNU, 100%)

  * Mikael Dalsgard (USIT, 60%)

  * Hege Trosvik (USIT, 40%)

* UNINETT har ikke bidratt som forutsatt i prosjektplanen.

* De lokale organisasjonene har hatt vanskeligheter med å "omdirigere" eget
  ressursbehov bort fra personene som har fått prosjektansvar. Dette har ført til
  at det har vært problematisk å få arbeidsro.

* Universitetet i Tromsø bidro ved prosjektstart med to personer i 50% som del
  av prosjektgruppa. Dessverre skiftet begge arbeidsgiver halvveis i
  prosjektperioden og prosjektet fikk et "dobbelt-tap" av både opplæringstid og
  kompetanse. Gitt situasjonen var det ikke å forvente at UIT skulle greie å
  erstatte disse ressursene for prosjektets siste 6 måneder.

Manglende samkjøring av IaaS-strategi
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

UH IaaS som planlagt "virtuelt datarom" er en integrert tjeneste som berører og
setter krav til mange deler av organisasjonene i samarbeidet. Prosjektet har
opplevd mangelen på en sektor-felles forståelse av UH-sky og IaaS som en sterk
bremsekloss. Mange gode initativer og muligheter går tapt på grunn av dette. UH
IaaS som ide for framtida er avhengig av å kunne "bygge seg inn i" alle
organisasjonene i samarbeidet. Vi har ikke nok ressurser totalt sett til å
kunne drive to så like tjeneste-initiativ - IPnett IaaS og UH IaaS - samtidig.

I en periode hvor det å bygge samarbeid burde være det viktigste fokuset har
det for prosjektet vært svært frustrerende å oppleve dette. Mye ekstra tid går
tapt fordi en ikke har en samordnet forståelse av hva som er målet.

Sein oppstart
^^^^^^^^^^^^^

Det tok lengere tid enn forutsatt å identifisere og frigjøre ressurser til
prosjektet. Prosjektet var ikke operativt før i oktober 2014.

Tiltak for ferdigstilling
-------------------------

For å fredigstille UH IaaS og levere plattformen som beskrevet i aktivitet #1
og #2 i prosjektplanen foreslår vi følgende tiltak.

1. Utsettelse av produksjonsdato til 31.12.2015
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Hvis prosjektet bemannes videre på samme måte (4 personer) vil tjenesten kunne
leveres som beskrevet under aktivitet #1 i prosjektplanen innen 31.12.2015.

Tjenesten vil leveres som pilot for et mindre utvalg brukere og felles systemer
fra ca september 2015. Prosjektet er i kontakt med flere interesserte
pilotbrukere og vil følge disse opp.

2. Nye ressurser knyttes til prosjektet for å jobbe med Feide og Connect
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Aktivitet #2 i prosjektplanen vil ikke kunne gjennomføres uten tilføresel av
ressurser. Feide Connect framstår for prosjektet som er en svært interessant
mulighet for gjennomføring av kravene vi har satt. Å sette Connect sin pilot i
sammeheng med UH IaaS vil gi gode effekter både for samarbeidet i UH-sky og
lokalt for de organisasjonene som eventuelt avgir ressuser.

Connect sin pilot er planlagt avsluttet 15. november 2015 men trolig vil det
være mulig å avtale fortsatt bruk av plattformen. Dette må avklares med
UNINETT av UH-sky styringsgruppa.

UH IaaS ber om en ressurs på 600 timer fram til ny produksjonsdato 31.12.2015
for å utføre dette arbeidet. Tilstrekkelig utviklings- og
infrastrukturkompetanse til å kunne jobbe i kommunikasjon med Connect sine
utviklere, implementere løsninga og innlemme den i UH IaaS er en forutsetning.

Spørsmål om rapportering og styring
-----------------------------------

Burde prosjektet rapportert mer i detalj om underbemanning og mangel på ressurser?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Det ble i februar gjort en vurdering og diskusjon internt på om det var
nødvendig å kreve prosjektet stoppet til ressursene forelå som forutsatt. På
dette tidspunktet var det klart at underbemannningen på minus 2 personer ikke
uten stor innsats ville la seg løse før prosjektets sluttdato.

Prosjektleder valgte å ikke stoppe prosjektet av følgende årsaker

* Verdien av det som ble produsert av de som var daglig produktive i prosjektet
  var økende og positiv. Rutiner som gav arbeidsro og arbeidstid var i ferd med å
  etableres skikkelig. En stopp av prosjektet og eventuell seinere igangsetting
  ville rive vekk mye av dette.

* Å stoppe prosjektet ville virke svært negativt utad. Kostnaden ved stopp og
  en uviss periode venting til manglede ressurser ble frigitt og en ny
  igangsetting virket for store.

Fungerer teknisk styringsgruppe slik som planlagt?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

I løpet av det siste halvåret av prosjektet har ideen om en "teknisk
styringsgruppe" beveget seg et godt stykke fra den opprinnelige ideen.
Arbeidsflyten teknisk styringsgruppe var ment å støtte kan beskrives slik:

1. Tekniske behov og krav settes *i prosjektet* basert på prosjektplanen

2. Utfordringer kan oppstå når behov og krav møter lokal organisasjon og policy

3. Prosjektet gjør bruk av teknisk styringsgruppe for å løse dette konkret

`Mandatet`_ til teknisk styringsgruppe ble utformet for å fungere i en slik
arbeidsflyt. Etter at det både fra lokale organisasjoner og UH-sky
prosjektkoordinator ble stilt spørsmål rundt rapportering og andre formelle
prosesskrav fikk teknisk styringsgruppe en utvidet rolle. Hva den rollen nå er
blitt er nokså uklart.

Teknisk styringsgruppe kan muligens fortsatt ha oppgavene som følger av det
opprinnelige mandatet. Den er samtidig nå i ferd med å også få en annen,
bredere "UH-sky styringsfunksjon" som det også er stort behov for - men som bør
være et annet bord og en annen prosess.

.. _Mandatet: http://iaas.readthedocs.org/en/latest/project/meetings/teknisk_styringsgruppe_mandat.html

Hvordan bør et UH-sky prosjekt med felles ressurspool rapportere?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

UH IaaS sin erfaring så langt med *teknisk, operativ utvikling av infrastruktur
på kryss av linjeorganisasjonene* tilsier at rapportering bør skje på to måter:

* Ukentlig mot hele gruppen av nærmeste ledere for prosjektressursene

* Månedtlig, skriftlig rapport til alle interesserte ledernivåer i alle
  organisasjonene

Vi har ikke fått dette til så godt som ønskelig så langt. UH IaaS vil be om at
organisasjonene setter av mer tid til daglig oppfølging.

Referanser
----------

* UH IaaS sin prosjektplan: http://iaas.readthedocs.org/en/latest/project/plan.html
  (versjon med kapittel om ressurser og budsjett ligger i Agora)

* Feide Connect: http://feideconnect.no/prosjekt/

* UH IaaS daglig planlegging (trello): https://trello.com/b/m7tD31zU/iaas


