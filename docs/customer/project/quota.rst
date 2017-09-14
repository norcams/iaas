======
Kvoter
======

Sist endret: 2017-09-14

.. NOTE::
  Under arbeid. Dette er et utkast og ikke et endelig dokument.

Hvor mye ressurser det er mulig å bruke i et prosjekt er styrt av kvoter.
Kvoter blir satt per region, og dersom et prosjekt ikke har fått tildelt
en kvote vil den automatisk få default kvote (se under).

Default kvote
=============

Alle prosjekter som ikke har fått egen kvote i en region vil få tildelt
default kvote. Alle demo-prosjekt har også default kvote. Denne er lik for
alle og vil ikke bli endret.

==================== =========== =============
kvote                 navn        default
==================== =========== =============
Instanser             instances   2
vCPU                  cores       2
Minne                 ram         2048 MB
Volum antall          volumes     1
Volum størrelse       gigabytes   20 GB
Volum snapshot        snapshots   3
==================== =========== =============

Forklaring
==========

Alle kvoter gjelder summen av alle ressurser brukt i et prosjekt i en region.

Instanser
---------

Total antall instanser det er mulig å opprette i et prosjekt.

vCPU
----

Antall prosessorer (vCPU) det er mulig å tildele instanser.

Minne
-----

Størrelsen på minne det er mulig å tildele instanser.

Volum antall
------------

Volum er er benevnelse på blokklagringen i UH-IaaS. Volum antall sier hvor mange
volum det er mulig å lage i et prosjekt.

Volum størrelse
---------------

Total størrelse av alle volum i et prosjekt.

Volum snapshot
--------------

Totalt antall snapshot av alle volum i et prosjekt.
