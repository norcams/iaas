.. |date| date::

==================
Ressursplanlegging
==================

Sist endret: |date|

Compute
=======

Definisjoner
------------

**N**
  Antall compute noder per AZ (idag samme som per region)

**U**
  Utnyttelse: **U-1/U** hvor U må være en faktor av **N**
  (U > 2 om vi ønsker over 50% utnyttelse)

**R**
  Antall uker før en compute node blir reinstallert (patchet)

**D**
  Antall uker et set med noder kjører uten endringere

**I**
  Antall uker vi kan love at en instans kjører uten planlagt restart

Formler
-------
* **R=D*U**
* **I=(U-1)*D**

Status
------

Idag:

* **N=3**
* **U=3 (66% utnyttelse)**
* **D=2**

Eksempler
---------

=== === ===
 D   R   I
=== === ===
 1   3   2
 2   6   4
 3   9   6
 4  12   8
=== === ===
