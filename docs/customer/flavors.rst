=================
Priser og flavors
=================

Sist endret: 2017-03-22

.. NOTE::
  Det jobbes forsatt med å komme frem til endelige priser.

Her er en oversikt over hvilke flavor man kan velge når man starter instanser.
Flavor er en klassifisering av ressursene tilgjengelig for instansen etter at
den starter opp.

m1
==

m1 er tenkt som en general purpose type av flavors som alle prosjekter har
tilgang til.

=========== ==== ========== ===== =====
Navn        vCPU RAM (GiB)  Disk  Pris
=========== ==== ========== ===== =====
m1.tiny      1    0.5        1    
m1.small     1    2          10
m1.medium    1    4          20   
m1.large     2    8          20   
m1.xlarge	 4    16		 20   
=========== ==== ========== ===== =====

m2
==

m2 er tenkt som større maskiner for dem som trenger mer minne og cpu enn det
m1 dekke. Denne vil kun være tilgjengelig for prosjekter som har bestilt
tilgang til m2. Alle som eksplisitt ber om økt flavor som passer inn i denne
gruppen kan få dette.

=========== ==== ========== ===== =====
Navn        vCPU RAM (GiB)  Disk  Pris
=========== ==== ========== ===== =====
m2.xlarge    8     32        20
m2.2xlarge   16    64        20
m2.4xlarge   32    128       20
=========== ==== ========== ===== =====

d1
==

d1 er en flavor type med mer disk enn m1. Denne vil kreves for å kreves for å
kunne kjøre Windows og vil kun være tilgjengelig for prosjekter som har bestilt
tilgang til d1.

Vær restriktiv i forhold til hvem som får tildelt tilgang til flavors i denne
gruppen!

=========== ==== ========== ===== =====
Navn        vCPU RAM (GiB)  Disk  Pris
=========== ==== ========== ===== =====
d1.small     1     2         40
d1.medium    1     4         40
d1.large     2     8         60
d1.xlarge    4     16        80
d1.x2large   8     32        80
d1.4xlarge   16    64        80
=========== ==== ========== ===== =====

Andre typer flavor
==================

Vi vil utvide med flere typer flavor etter behov.
