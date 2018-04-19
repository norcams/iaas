==================
Småtips rundt CEPH
==================

Feilsøking:

https://ceph.com/geen-categorie/ceph-manually-repair-object/


Vanlige advarsler som kan overses:

  **Too many PGs per OSD**

  Den er jo permanent inntil vi får flere OSDer. Feks. fjernet vi
  snurredisker, og det er ikke mulig å minske antall pger, bare øke.
  Eneste konsekvens er litt høyere CPU-BRUK enn nødvendig.


  **Clock skew detected on... (cephmon-instans)**

  Kommer etter restart og forsvinner etter en stund.
  Kan ignoreres.


