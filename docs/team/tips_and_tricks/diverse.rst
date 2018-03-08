==================================================
Diverse småtterier som ikke passer i egne kapitler
==================================================

Management-switch i OSL (10.17.32.1)
------------------------------------

Denne støtter ikke en av default'e cipher som nyere ssh-klienter tilbyr. Man må
derfor spesifisere denne eksplisitt når man skal inn på switchen::

  ssh iaas@10.17.32.1 -c 3des-cbc


