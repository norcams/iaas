
==================
Ressursplanlegging
==================

Compute
=======

Definisjoner
------------

**N**
  Antall compute noder per region

**G**
  En gruppe maskiner (host aggregate) Må være faktor av **N**

**A**
  Antall ledige compute hosts (A=N/G)

**U**
  Ubrukte compute hosts (U=N/G)

**L**
  Låste compute hosts (L=N/G)

**D**
  Antall uker mellom en aktiv rotasjon

**R**
  Antall uker før en compute node blir reinstallert (patchet)

**I**
  Antall uker mellom instans restart (første restart kan komme etter **D** uker)

Formler
-------
* **R=D*G**
* **I=(G-1)*D**

Status
------

Idag:

* **N=6**
* **A=2**
* **U=2**
* **L=2**
* **D=2**

Start status idag (januar 2017):

* G1 = L
* G2 = A
* G3 = L

Regler:

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

Vi trenger ikke å restarte instaser oftere enn hver 4 uke (nye instanser kan
bli restartet etter 2-4 uker). Vi får reinstallert compute hosts hver 6 uke.
Vi har alltid 2 ledige compute hosts dersom gruppen som er aktiv går full.
Så ved behov kan vi kjøre U -> A og A -> L.
