==============
Endringsuke 22
==============

Mandag 29.mai
=============

Patching av alle tjenester mellom 12 og 14.

Avvik:
------

* Peker for prod-repo ble ikke endret slik at ingen nye pakker kom inn.

* Vi kunne ikke starte nye instanser etterpå

* bgo-storage sluttet å fungere etter reboot.

Resultat:
---------

Selve patcherutinen gikk bra, men vi opplevde at vi ikke kunne starte nye instanser etterpå.

Alle noder bortsett fra compute ble rebootet i forbindelse med patching.
I OSL ble problemet løst kl 14:30, mens det i BGO så ut til at feilen kom
tilbake rundt 15:00, og ble ikke løst før vi rebootet bgo-novactrl-01 tirsdag
kl 13:15.

Vi er usikre på hvor problemet lå men i OSL løste det seg med en restart
av nova-scheduler, mens i BGO endte man opp med å reboote hele novactrl-01.

Problemet så ut til å være knyttet til at openstack-tjenestene på novactrl-01
ikke fikk snakke med AMQP, men det var ikke noe problem på bgo-mq-01 som hele
tiden snakket med compute.

Det så i tillegg ut til at storage i BGO sluttet å fungere etter reboot.
Mens i OSL var 20 OSD ikke tilgjengelig for Ceph.

Tirsdag 30.mai
--------------

Migrering av instanser i host aggregate group1 til group3.

Avvik:
------

* bgo-compute-06 var ikke reinstallert etter endringsuken i april og måtte
  reinstalleres rett før migrering ble igangsatt

* bgo-compute-03 og bgo-compute-06 manglet begge 2 kritiske patcher

* bgo-image-01 hadde ikke lagring og API-kall som trenger storage
  medførte at hele API gikk i heng.

* group3 ble ikke aktivert før vi startet i BGO slik at 40 instanser gikk til
  group2 i stedet for group3.

* osl-network-01 fikk for mye å gjøre og gikk ned under migreringen.
  8 instanser endte opp i error state.

* Migrering i OSL tok ikke med seg disk-delta fra gammel til ny
  compute-node. Det medførte at alle instaner ble resatt til slik
  de var ved installasjon.

Resultat
--------

Resultatet av migreringen ble at kun de instanser i BGO som ble migrert til
feil gruppe (group2) fungerte. Resten måtte fikses manuelt og ble ikke ferdig
før kl 22. Disk til instansene måtte flyttes manuelt med rsync og alle
instansene måtte skrus av og på manuelt.

Forbedringer
============

* Sjekkliste for om en compute-node er klar til å taes i bruk
* Ikke reinstaller de tomme compute-nodene før (rett i forkant av) neste migrering
* aggregate.py: --sleep >= 180 sek pluss sleep(2) mellom hver instans
* aggregate.py: --hard-limit feature som stopper etter --limit noder
* Dokumentere migrerings-rutinene bedre
