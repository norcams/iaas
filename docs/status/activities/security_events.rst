============================
Varsel om sikkerhetshendelse
============================

Må skille mellom viktighet kritisk, høy, middels og lav
IT-sikkerhet må avgjøre viktigheten.
Scanning er ferskvare, viktig at saker opprettes så snart som mulig etter scanning er gjennomført

For alle saker må det sjekkes:

#. At eier av instansen er riktig

#. At instansen fortsatt er den som det er varslet om


Rutine
======

* Kritisk: Instansen skrus av og brukeren varsles

  .. NOTE::
     Dersom det er snakk om varsel pga. EOL av operativsystemet, og det er gått
     ut av support helt nylig, så gi bruker en ukes tid på respons før instansen
     skrus av.

* Høy: Bruker varsles. Krever at brukeren fikser problemet innen 14 dager, hvis ikke stenge/skru av instansen

* Middels: Bruker varsles og følges opp dersom det er behov.

* Lav: Bruker varsles, ingen videre oppfølging
