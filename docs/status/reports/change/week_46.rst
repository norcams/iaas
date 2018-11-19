=================
Pike oppgradering
=================

2018-10-17 keystone
===================

Vi oppgraderte alle identity noder i bgo og osl uten nedetid på tjenesten
mellom 08:00 og 09:00 17.oktober. Oppgraderingen var automatisert med ansible
og gikk som planlagt med kun et par sekunder med nedetid på involverte tjenster.

2018-10-31 horizon
==================

Dashboard (horizon) ble oppgradert med minimal nedetid for brukere, total ca
10 minutter. Igjen ble ansible brukt og oppgradering gikk etter planen.

2018-11-13 Full oppgradering
============================

Resten av tjenstene ble oppgradert med en planlagt full nedetid 13. november
mellom 14:00-16:00

Utfordringer under oppgradering
-------------------------------

Ansible jobbene
~~~~~~~~~~~~~~~
De fleste ansible-jobbene inneholdt enten ting som ikke fungerte eller inneholdt
jobber som ikke skulle ha vært der. De ble rettet under generalprøven (test02)
og under oppgradering av prod. Dette var hovedgrunnen til at vi ble ca 1 time
forsinket.

osl-compute-01
~~~~~~~~~~~~~~

Denne ønsket å forbli på ocata, mens alt annet ble oppgradert. Dette medførte at
man i osl-legacy-1 ikke kun starte en ny instans her og legge til et volume
(volume attach feilet). Feilen viste seg å være en syntaks feil i nodefilen.
Dette resultert i at puppet run via ansible valgte å bruke en gammel cached
catalog som da gav oss tilbake ocata. Dersom man kjørte puppet agent -t så fikk
man den forventede feilmeldingen som ville gjort at dette ble oppdaget under
oppgraderingen. Feilen ble oppdaget under testing onsdag formiddag og rettet.

nova service i osl
~~~~~~~~~~~~~~~~~~

Etter oppgradering var det ikke lenger mulig å bruke nova api til f.eks å liste
ut instanser. openstack server list gav følgende feilmelding:

.. code:: bash

  This service is older (v15) than the minimum (v16) version of the rest of the
  deployment. Unable to continue.

Problemet viste seg å være gamle servicer med lavere versjon som lå igjen i database.
Det lå mange gamle der, men det var kun to av dem som måtte slettes. Det ble gjort
manuelt i databasen og problemet løste seg.

Oppsummering
------------

Planen var å ha nedetid fra 14-16. Det gikk ellers greit. Vi brukte ca 2 timer
totalt som også var planlagt, men vi begynte ca 1 time etter planen og ble derfor
også ikke ferdig før rundt 17. Vi fant et par feil som oppstod siden vi hadde
blokkert api for andre enn oss selv. Vi trenger nok å legge inn flere tilganger
fra system slik at vi kan teste uten å slippe alle inn.

Endel av feilene i ansible og problemet på osl-compute-01 er relatert til hvordan
vi kjører puppet via ansible. Dette krever en nye gjennomgang før neste
oppgradering.

Etter oppgradering
------------------

Nettverk til instanser i bgo
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I løpet av onsdag formiddag så vi at bgo begynte å slite med å få IP på nye
instanser og IPv6 forsvant fra eksisterende. Problemet begynte med enkeltinstanser,
men etter at vi begynte feilsøking og stoppet puppet på bgo-network-0[1-3] så
ble begynte alle å slite. Synderen etter en dag med feilsøking viste seg å være
puppetrun på osl-network-0[1-3]. Disse endret gateway i bgo til osl sin gateway
slik at instansene ikke lenger fikk nett. Det viste seg at neutron-modulen leser
region_name fra en annen seksjon i pike enn i ocata. I ocata brukes det som
settes under [keystone_authtoken], mens i pike forventer den å finne region_name
i [neutron] (en seksjon som ikke finnes eller opprettes av puppet). Løsningen
ble å sette dette som en custom config i hieradata.

**Merarbeid:** ca 1 dag (to personer) for å forhindre at feilen oppstod.
Deretter ca 1 dag (1 person) å finne ut hvorfor det skjedde og finne en
løsning på det.

Tilgang til access
~~~~~~~~~~~~~~~~~~

Etter oppgradering begynte access å gi Internal server error når man prøvde å
provisjonere et nytt prosjekt. Feilen oppstod ikke før man kom tilbake fra
Dataporten og ble ikke oppdaget under testing etter oppgraderingen eller i test.
Problemet så ut til å skyldes selinux så ved å stoppe puppet og sette selinux til
permissive fungerte tjenesten igjen. Vi oppdaget feilen først selv, men glemte å
stoppe puppet slikt at feil kom tilbake og ble rapportert inn av en bruker.
