===================
Lagring for OS-disk
===================

Sist endret: 2018-09-28

Alternativ 1 ble valgt og produksjonsatt.


Det vi ønsker er å benytte sentral OS-disk som default for alle instanser.
For spesialiserte compute-ressurser vil det være aktuelt med lokal OS-disk,
men disse vil da være i egne availability zones (AZ).

.. contents:: Oversikt

Utfordring
==========

Hvordan kommer vi oss fra dagens løsning med lokal OS-disk til sentral OS-disk?

Alternativ 1
============

Vi lager en ny default AZ med nye compute noder (vi har 2 i OSL og 4 i BGO).
Eksisterende instanser blir værende dere de er og ny instanser havner i ny AZ
med sentral OS-disk.

AZ navn
-------

**Alt A:** <loc>-default-2

**Alt B:** Endrer navn på <loc>-default-1 til <loc>-legacy-1 og opprette en ny
<loc>-default-1

Fordeler
--------

* Slipper å flytte instanser med høyt diskbruk (dvs ingen discard) inn i sentral lagring
* Får en gradvis flytting

Ulemper
-------

* Hvordan hindre at nye instanser ikke havner i gammel AZ? Et prosjekt kan ha både
  nye og gamle instanser

Alternativ 2
============

Lage en ny AZ og flytte alle instanser dit. Vi starter med ledige compute-noder
og så flytter vi de som er tømt over etter hvert som vi flytter. Vi har to
aktive grupper med instanser idag så vi må flytte i to omganger.

AZ navn
-------
**Alt A**: <loc>-default-2

<loc>-default-1 blir ledig etter flytting og kan brukes til neste default AZ.


Fordeler
--------

* Raskere ferdig med endringen

Ulemper
-------

* Vi vil flytte instanser med høyt diskbruk (dvs ingen discard) inn i sentral
  lagring. Det er nå ca 140 instanser uten discard, noe som utgjør litt under 50%.
