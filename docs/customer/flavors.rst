=================
Priser og flavors
=================

Sist endret: 2018-02-28

.. NOTE::
  Det jobbes forsatt med å komme frem til endelige priser.

Her er en oversikt over hvilke flavor man kan velge når man starter instanser.
Flavor er en klassifisering av ressursene tilgjengelig for instansen etter at
den starter opp.

m1
==

m1 er tenkt som en general purpose type av flavors som alle prosjekter har
tilgang til.

Ratio: 1 til 4 (vcpu til ram)

=========== ==== ========== ===== =====
Navn        vCPU RAM (GiB)  Disk  Pris
=========== ==== ========== ===== =====
m1.tiny      1    0.5        1
m1.small     1    2          10
m1.medium    1    4          20
m1.large     2    8          20
m1.xlarge    4    16         20
=========== ==== ========== ===== =====

m2
==

.. IMPORTANT::
   DENNE SKAL IKKE LENGER TILBYS!!!!!

m2 er tenkt som større maskiner for dem som trenger mer RAM og vCPU enn det
m1 dekke. Denne vil kun være tilgjengelig for prosjekter som har bestilt
tilgang til m2. Alle som eksplisitt ber om økt flavor som passer inn i denne
gruppen kan få dette.

Ratio: 1 til 4 (vcpu til ram)

=========== ==== ========== ===== =====
Navn        vCPU RAM (GiB)  Disk  Pris
=========== ==== ========== ===== =====
m2.2xlarge    8    32        20
m2.4xlarge   16    64        20
=========== ==== ========== ===== =====

win
===

win er en flavor type med mer disk en m1 og er kun ment for å kjøre Windows.
Alle instanser av denne typen vil også kjøre på compute noder som er lisensiert
med Mircosoft Datacenter lisens.

Denne skal kun brukes til windows workloads.

Ratio: 1 til 4 (vcpu til ram)

=========== ==== ========== ===== =====
Navn        vCPU RAM (GiB)  Disk  Pris
=========== ==== ========== ===== =====
win.small    1     2         40
win.medium   1     4         40
win.large    2     8         60
win.xlarge   4     16        80
win.2xlarge  8     32        80
win.4xlarge  16    64        80
=========== ==== ========== ===== =====

d1
==

Ratio: 1 til 4 (vcpu til ram)

d1 er en flavor type med mer disk enn m1. Denne vil kreves for å
kunne kjøre Windows og vil kun være tilgjengelig for prosjekter som har bestilt
tilgang til d1.

Vær restriktiv i forhold til hvem som får tildelt tilgang til flavors i denne
gruppen!

Ratio: 1 til 4 (vcpu til ram)

=========== ==== ========== ===== =====
Navn        vCPU RAM (GiB)  Disk  Pris
=========== ==== ========== ===== =====
d1.small     1     2         40
d1.medium    1     4         40
d1.large     2     8         60
d1.xlarge    4     16        80
d1.2xlarge   8     32        80
d1.4xlarge   16    64        80
=========== ==== ========== ===== =====

c1
==
c1 en er flavor type for dem som trenger mer vCPU enn m1.

Ratio: 1 til 2 (vcpu til ram)

=========== ==== ========== ===== =====
Navn        vCPU RAM (GiB)  Disk  Pris
=========== ==== ========== ===== =====
c1.medium    1     2         20
c1.large     2     4         20
c1.xlarge    4     8         20
c1.2xlarge   8     16        20
c1.4xlarge   16    32        20
=========== ==== ========== ===== =====

r1
==

.. IMPORTANT::
   DENNE SKAL IKKE LENGER TILBYS!!!!!

r1 er tenkt som en maskin med mer RAM som m1 og c1 dekker.

Ratio: 1 til 8 (vcpu til ram)

=========== ==== ========== ===== =====
Navn        vCPU RAM (GiB)  Disk  Pris
=========== ==== ========== ===== =====
r1.medium    1     8         20
r1.large     2     16        20
r1.xlarge    4     32        20
r1.2xlarge   8     64        20
r1.4xlarge   16    128       20
=========== ==== ========== ===== =====

Andre typer flavor
==================

Vi vil utvide med flere typer flavor etter behov.
