==================================================
Diverse småtterier som ikke passer i egne kapitler
==================================================

Management-switch i OSL (10.17.32.1)
------------------------------------

Denne støtter ikke en av default'e cipher som nyere ssh-klienter tilbyr. Man må
derfor spesifisere denne eksplisitt når man skal inn på switchen::

  ssh iaas@10.17.32.1 -c 3des-cbc


EPEL-repo
---------

Ved installasjon av 'epel-release' e.l. kan man risikere at repodefinisjonen for
EPEL-repoet settes til å peke på EPEL sitt offisielle speil-nettverk i stedet
for vårt snapshot-kontrollerte speil. For å finne slike feilkonfigurerte systemer
kan man kjøre følgende ansible-jobb::

  sudo ansible-playbook --become -e "hosts=<whatever som vanlig>" lib/check_epel.yaml

Man vil da få feil på de hoster som er feil satt opp sammen med utskrift av
linjen som ikke skal være der.
