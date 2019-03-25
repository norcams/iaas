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

  sudo ansible-playbook --become -e "myhosts=<whatever som vanlig>" lib/check_epel.yaml

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

3. *sudo ansible-playbook -e "myhosts=<loc>-identity" lib/push_gpg_keys.yaml*

   Distribuerer den genererte nøkkelen til relevante identity-noder og
   importerer den inn i GPG.


Utvide sensu-plugins-himlar
---------------------------

1. git clone git@github.com:norcams/sensu-plugins-himlar.git
2. legg til/endre filer etter behov
3. oppdater *lib/sensu-plugins-himlar/version.rb* (versjon)
4. tilpass ev. *sensu-plugins-himlar.gemspec*
5. kjør `gem build sensu-plugins-himlar.gemspec`
6. last opp resulterende *gem*-pakke til repository-serveren som beskrevet
   i dokumentasjonen rundt den
7. sjekk inn og push til git-repo

Avassosiere noder i Foreman
---------------------------

Noder i Foreman blir ikke automatisk blir avassosiert med en compute-profil
når du sletter compute-profilen, og dette resulterer i en ødelagt database.
Løsningen, inntil bug'en er fikset, er dette::

  for h in `hammer --csv host list --search 'facts.is_virtual == true' | cut -d, -f1 | tail -n +2`; do hammer host disassociate --id $h; done


Er puppet disablet
------------------

Kan man se om en node har agent-kjøring disablet uten å teste med en kjøring?
Om ikke annet så kan man i alle fall sjekke slik:

::
  # ls -l /opt/puppetlabs/puppet/cache/state/agent_disabled.lock

Dersom filen finnes er agent-kjøring disablet, og grunnen (hvis angitt) ligger
som en tekst i filen.
