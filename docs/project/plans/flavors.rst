=======
Flavors
=======

Her er en oversikt over hvilke flavor av instatanser som skal være tilgjengelig:


m1
==

m1 er tenkt som en general purpose type av flavors som alle for tilgang til.
Den vil hovedsaklig bli brukt i personlige prosjekter.

=========== ==== ==== ===== ==============
Navn        vCPU RAM  Disk  Aggregate
=========== ==== ==== ===== ==============
m1.tiny      1    512   1   default-1
m1.small     1   2048  10   default-1
m1.medium    2   4096  20   default-1
m1.large     4   8192  20   default-1
=========== ==== ==== ===== ==============

d1
==

d1 er en flavor type med mer disk en m1.

=========== ==== ===== ===== ==============
Navn        vCPU  RAM  Disk  Aggregate
=========== ==== ===== ===== ==============
d1.small     1    2048   20  default-1
d1.medium    2    4096   40  default-1
d1.large     4    8192   60  default-1
d1.xlarge    8   16384  100  default-1
=========== ==== ===== ===== ==============

Andre typer flavor
==================

* **m2** større general purpose
* **c1** mye cpu
* **x1** mye minne
* **h1** for hpc
