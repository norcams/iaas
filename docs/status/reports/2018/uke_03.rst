======
Uke 3
======

av Raymond Kristiansen, UH IaaS, 22.januar 2018

Oppdatert informasjon om status finnes alltid i
`Trello <https://trello.com/norcams>`_

.. contents::

Status
======

Pga ferieavvikling i desember ble det endel færre arbeidstimer denne måneden.

I forbindelse med meltdown og specter tok vi en full runde med OS-patching
i uke 3. Mye av tiden så langt i januar har gått med til testing og
kunnskapsinnhenting i forbindelse med disse. Endringene ble utført i annonsert
tidsvindu etter planen.

Puppet 4
--------

De fleste har jobbet med dette siden desember og vi nærmer oss nå målet. Selve
omleggingen vil skje i slutten av januar/begynnelse av februar. Arbeidsmengden
med omleggingen har vært større enn antatt så vi brukt litt lenger tid enn
planlagt.

Sentral lagring
---------------

Vi la om til sentral lagring som default i BGO i 17. januar. Ingen kjørende
instanser har blitt flyttet, men nye vil få sentral lagring. Vi fikk noen
utfordringen som medførte at vi utsatte endringene i OSL til disse er løst.
Planen er å legge om OSL i uke 4.

Objektlagring
-------------

Vi har satt opp en PoC av Openstack Swift som ser ut til å fungere. Vi trenger
mer tid til testing og tilpassing av tjenesten. Planen er å installere den i BGO
når vi er ferdig med Puppet 4 oppgradering.

Annet
-----

Det jobbes videre med å sette opp Designate (DNS) og Ceilometer (telemetri).

Planlagte aktiviteter
=====================

- Fortsette å hjelpe brukere med å ta i bruk tjenesten
- Jobbe videre med Designate og Ceilometer
- Oppgradering til Puppet versjon 4
- Objektlagring


Utfordringer
============


Annet
=====

- Se https://trello.com/norcams for oppdaterte planer.
