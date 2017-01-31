=======
Flavors
=======

Her er en oversikt over hvilke flavor av instatanser som skal være tilgjengelig:


m1
==

m1 er tenkt som en general purpose type av flavors som alle for tilgang til.
Den vil hovedsaklig bli brukt i personlige prosjekter.

=========== ==== ========== ===== ==============
Navn        vCPU RAM (GiB)  Disk  Aggregate
=========== ==== ========== ===== ==============
m1.tiny      1    0,5         1   default-1
m1.small     1    2          10   default-1
m1.medium    2    4          20   default-1
m1.large     4    8          20   default-1
=========== ==== ========== ===== ==============

m2
==

m2 er tenkt som større maskiner for dem som trenger mer minne og cpu enn det
m1 dekke.

=========== ==== ========== ===== ==============
Navn        vCPU RAM (GiB)  Disk  Aggregate
=========== ==== ========== ===== ==============
m2.large     2      8        20   default-1
m2.xlarge    4     16        20   default-1
m2.2xlarge   8     32        20   default-1
m2.4xlarge   16    64        20   default-1
=========== ==== ========== ===== ==============

d1
==

d1 er en flavor type med mer disk en m1.

=========== ==== ========== ===== ==============
Navn        vCPU RAM (GiB)  Disk  Aggregate
=========== ==== ========== ===== ==============
d1.small     1    2           20  default-1
d1.medium    2    4           40  default-1
d1.large     4    8           60  default-1
=========== ==== ========== ===== ==============

Andre typer flavor
==================

* **c1** mye cpu
* **x1** mye minne
* **h1** for hpc
