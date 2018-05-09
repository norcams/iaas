======
Uke 18
======

av Raymond Kristiansen, UH IaaS, 9.mai 2018

Oppdatert informasjon om status finnes alltid i
`Trello <https://trello.com/norcams>`_

.. contents::

Status
======

Pga ferie og fridager har fremdriften de siste uken ikke vært like stor som
vi skulle ha håpet. Resten av mai blir nok ikke stort bedre, men vi regner
med å være tilbake for fult noen uker i juni/juli før sommerferien starter for
de fleste.

Oppgraderingen til ocata går videre og vi regner med å kjøre det ut i test i
løpet av de neste uken. Oppgradering av bgo og osl vil bli tatt i juni når jeg
og Tor er tilbake fra Openstack summit.

Vi har fått byttet PSUer i bgo slik at vi nå har 10 compute noder der (2 av dem
er ikke tatt i bruk enda).

Utfordringer
~~~~~~~~~~~~

Vi fikk rapporter om problemer med dashboard (openstack horizon) i vår. Det
tok endel tid og ressurser å feilsøke siden det kun oppstod med enkelte nettlesere.
Problemet hadde med sesjonshåndteringen å gjøre, og vi lagrer nå sesjonsdata i
en egen database for å unngå problemet helt.

Vi fikk også problemer med en hard limit i nettverksutstyret vårt. Siden vi
kjørte flest instanser i osl oppdaget vi problemet der først. Grensen er på 256
host-ruter som medførte at vi ikke fikk IPv6 på nye instanser når antallet
ruter oversteg 256 (ca 220 instanser). IPv6 blir bl.a. brukt til DNS så for
alle praktiske formål var instansen ubrukelig. Vi løste det akutte problemet
med å slette demo instanser og oppfordre alle brukere om å benytte bgo til nye
instanser. Det ble bestilt nye rutere i osl og vi hadde 2 rutere som kunne settes
inn i bgo. Vi bytte rutere i bgo torsdag 3.mai og i osl tirsdag 8.mai for en
permanent løsning. Både feilesøkingen og forberedelser til bytte har tatt mye
resurser siden det ble oppdaget i uke 16. Det jobbes også med å få en redundant
uplink i osl.

Pga ferie og konferanser blir det begrenset bemanning i mai. Vi regner med at
vi skal klare å ha minst en på jobb hver dag.

Planlagte aktiviteter
=====================

- Fortsette å hjelpe brukere med å ta i bruk tjenesten
- Jobbe videre med Designate
- Pilot objektlagring
- Oppgradere til ny Openstack-versjon: **Ocata**

Annet
=====

- Se https://trello.com/norcams for oppdaterte planer.
