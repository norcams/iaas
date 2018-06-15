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


GPG-nøkkel
----------

For Keystone brukes bl.a. GPG for å kryptere og dekryptere tokens under
distribusjonen mellom identity-nodene. Når et miljø (re)installeres eller man av
andre grunner må sette opp ny GPG-nøkkel, må en ny slik genereres og distes til
alle identity-noder i miljøet.

Følgende rutine kjøres på relevant login-node:

1. */usr/local/sbin/create-gpg.sh <loc>*
   Genererer en ny GPG-nøkkel uten passord og evig varighet. Nøkkelen legges
   under node-katalogen til `<loc>-identity-01` i secrets-repoet.

2. Kopier manuelt filen `token-secret-key.gpg` fra denne katalogen til
   nodekatalogene for andre deltakende noder i miljøet.

3. *sudo ansible-playbook -e "hosts=<loc>-identity" lib/push_gpg_keys.yaml*
   Distribuerer den genererte nøkkelen til relevante identity-noder og
   importerer den inn i GPG.

