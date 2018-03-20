======
Uke 11
======

av Raymond Kristiansen, UH IaaS, 20.mars 2018

Oppdatert informasjon om status finnes alltid i
`Trello <https://trello.com/norcams>`_

.. contents::

Status
======

Vi hadde teamsamling ved USIT 6. og 7. mars. Det vil bli skrevet
`et kort referat <../workshop/2018_workshop_1.html>`_.

Vi holder på å legge om DNS slik at vi selv kan håndtere både
uh-iaas.no og uhdc.no. Vi har lagt om test01 og verifisert at
oppsettet vårt fungerer. Planen er å rulle det ut i prod de neste ukene.

Vi har også laget et oppsett for objektlagring med begrenset støtte for S3-API.
Dette vil bli testet ut de neste ukene før vi klargjør en pilot.

Uforutsette hendelser
---------------------

I uke 11 hadde vi to hendelser ved UiB som var utenfor vår kontroll og som
medførte nedetid for tjenestene våre og stopp av instanser for endel brukere.

Del 1
~~~~~

Onsdag 14.mars kl 14:50 mistet BGO sin uplink pga problemer med en gateway ved UiB.
Vi har ikke redundante uplink så det medførte at hele BGO mistet nettet. Dette
inkluderte alle felles tjenester som API, dashboard, status og access. Alle
kjørende instanser i OSL ble ikke berørt. Vi har også en tredje lokasjon for
quorum i database-clusteret som forsatt var oppe. Det medførte at med en gang
nettet kom tilbake så fungerte alt igjen. Nettet kom og gikk frem til rundt
16:30 når problemene ble løst. Kjørende instanser i BGO ble ikke påvirket på
andre måter enn at nettet var vekke en stund.

Tiltak for å unngå dette i fremtiden er redundante uplink i begge lokasjoner.
Det har vært jobbet med å koble oss direkte til UNINETT over lengre tid, men
det ser ikke ut som det blir en løsning her med det første. Vi vurderer å gjøre
andre tiltak i mellomtiden. Vi har også planer om å benytte en ekstern HA-løsning
for å gjøre felles tjenester mindre avhengig av en lokasjon som idag (BGO).

Del 2
~~~~~

Fredag 16.mars kl 10:25 gikk strømmen i store deler av Bergen sentrum inkludert
UiB sin datahall hvor BGO står. Sikringen til UPS gikk også og hele BGO mistet
strømmen og stoppet opp. Dette medførte at alle fellestjenester og alle instanser
i BGO ble stoppet. Etter 10-15 min fikk man UPS og aggregate opp og BGO fikk
igjen strøm. Instanser i bgo-legacy-1 startet automatisk og var tilgjengelig i
løpet av kort tid. Nedetiden hadde ført til problemer med database-clusteret så
det tok ca 1 time før alle fellestjenester var oppe. Største problemet var med
instanser i bgo-default-1 som bruker sentral disk. For det første startet ikke
en av compute nodene opp av seg selv etter strømbruddet og måtte manuelt startes.
Det andre problemet var at alle instanser i bgo-default-1 ikke klarte å fullføre
oppstart og ble hengende uten et kjørende OS. Problemet ble lokalisert til å være
med den sentral lagringen (Ceph). Problemet ble løst kl 16:00. Deretter ble alle
instanser i bgo-default-1 manuelt sjekket og fikk en kald restart. Alle instanser
og tjenester fungerte tilsynelatende igjen fra ca kl 17:15. Det var ca 80 kjørende
instanser i bgo-default-1 som ble berørt.

Vi vet forsatt ikke nøyaktig hvorfor lagringen fikk problemer etter strømstansen.

Det er litt begrenset med tiltak vi kan gjøre her. Men vi ser på å gjøre
database-clusteret mer robust samt å benytte en ekstern HA-løsning
for å gjøre felles tjenester mindre avhengig av en lokasjon som idag (BGO).

Planlagte aktiviteter
=====================

- Fortsette å hjelpe brukere med å ta i bruk tjenesten
- Jobbe videre med Designate
- Pilot objektlagring
- Oppgradere til ny Openstack versjon ocata

Utfordringer
============

* Vi har slitt med å få nok strøm til de 4 "nye" compute-nodene i BGO. Vi har
  nå fått ny PSU, men for å ta den i bruk må alle 4 skrues av. 2 av dem er idag
  default zone i BGO og har kjørende instanser.

Annet
=====

- Se https://trello.com/norcams for oppdaterte planer.
