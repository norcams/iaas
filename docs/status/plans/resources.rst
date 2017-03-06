
==========================
Ressursplanlegging compute
==========================

Sist endret: 2017-01-19

**Oppdatering 19.januar 2017**: Vi ble enig om å gå for forslag 1 i første
omgang. I tillegg er det fornuftig å likevel tagge gruppene med installuke
for fremtidig planlegging.

Definisjoner
============

**N**
  Antall compute noder per region. Idag er N=6

**G**
  En gruppe maskiner (host aggregate) Må være faktor av **N**

**D**
  Antall uker mellom en aktiv rotasjon

**A**
  Antall aktive compute hosts

**U**
  Ubrukte compute hosts

**L**
  Låste compute hosts

**R**
  Antall uker før en compute node blir reinstallert (patchet)

**I**
  Antall uker mellom instans restart (første restart kan komme etter **D** uker)

Forslag 1
=========

* **G=3**
* **A=2**
* **U=2**
* **L=2**
* **D=2**

Formler
-------

* R=D*G
* I=(G-1)*D
* N=A+U+L

Start status idag (januar 2017):

* G1 = L
* G2 = A
* G3 = L

Regler:
-------

* U -> A
* A -> L
* L -> U (med flytting og reinsall)

========== ==== ==== ====
 rotasjon   G1   G2   G3
========== ==== ==== ====
 1*         U    L    A
 2          A    U    L
 3          L    A    U
 4          U    L    A
 5          A    U    L
 6          L    A    U
========== ==== ==== ====

*= Vi må trikse litt for å komme ut av dagens status til rotasjon 1.


Konklusjon
----------

Vi kan granatere å ikke restarte instaser oftere enn hver 4 uke (nye instanser kan
bli restartet etter 2-4 uker). Vi får reinstallert compute hosts hver 6 uke.
Vi har alltid 2 ledige compute hosts dersom gruppen som er aktiv går full.
Så ved behov kan vi kjøre U -> A og A -> L.

Utnyttelsen vil da være **(G-1)/G** av compute nodene (G=3 gir 66%)

Forlsag 2
=========

* **G=3**
* **A=6**
* **D=2**

Vi kan tagge (T) hver gruppe med ukenummer det ble reinstalert. Ved oppstart
kan vi anta:

* G1 = 52
* G2 = 2
* G3 = 50

For hver rotasjon tømmer vi og reinstallere den gruppen som har vært opp lengst.

========== ==== ==== ====
 rotasjon   G1   G2   G3
========== ==== ==== ====
start      T=52 T=2  T=50
1          T=52 T=2  T=4
2          T=6  T=2  T=4
3          T=6  T=8  T=4
4          T=6  T=8  T=10
5          T=12 T=8  T=10
6          T=12 T=14 T=10
========== ==== ==== ====

Konklusjon
----------

Ved å låse den eldste gruppen som ikke reinstalleres før vi tømmer vil vi kunne
sørge for at en kjørende instans aldri blir flyttet i to rotasjoner på rad.
Det vil da kreve at den gruppen som mottar alle nodene har kapasitet til å
ta i mot alle instansene (typisk vil man måtte takle alle nye instanser de siste
to ukene pluss alle som kommer fra den gruppen som blir reinstallert).
For nye instanser kan vi kun love min oppetid på 5 dager (vi låser noen når vi
varsler brukere om restart).

Utnyttelsen vil da være **(G-1)/G** av ressursene til en hver tid (G=3 gir 66%)
