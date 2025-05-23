==================================================
Diverse småtterier som ikke passer i egne kapitler
==================================================

Patching av prod-noder før prod-peker er oppdatert
--------------------------------------------------

Dersom man ønsker å patche noder i prod (f.eks. compute-noder i
placeholder) før prod-peker er oppdatert til samme som test-peker, kan
man endre repo-filene til å peke på test midlertidig. Puppet vil rydde
opp etter denne endringen, dvs. ingen manuell rydding nødvendig.

Endre repo-filene til å bruke test-peker::

  perl -p -i -e 's/prod/test/g' /etc/yum.repos.d/*.repo

Deretter kjøre yum upgrade::

  yum upgrade --refresh


Management-switch i OSL (10.17.32.1) og test01 (10.17.0.1)
----------------------------------------------------------

Disse støtter ikke en av de default'e ciphers som nyere ssh-klienter tilbyr. Man må
derfor spesifisere denne eksplisitt når man skal inn på switchen::

  ssh iaas@10.17.32.1 -c 3des-cbc

Man må også komme med passord her, både for initiell login og for *enable*.
Dette passordet ligger i secrets-repoet.

Dersom login ikke er på 10.17.0.0/24 nettet::

  ip addr add 10.17.0.10/24 dev eth1


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

Hvilken instans ble myrdet av oom-killer?
-----------------------------------------

Første steg er å finne logginnslaget i /var/log/messages::

  # grep 'Out of memory' /var/log/messages

som vil returnere f.eks.::

  11948:2019-12-13T04:23:58.358162+01:00 kern.err bgo-compute-06 kernel: Out of memory: Kill process 40223 (qemu-kvm) score 126 or sacrifice child

Noter tidspunkt og se etter en korresponderende timestamp på filene i /var/log/libvirt/qemu
Finner du sjekker du om siste linjen i loggfilen matcher::

  shutting down, reason=crashed

Om dette er tilfellet har du gode beviser på at instansen ble myrdet av
oom-killer.

For å starte instansen igjen må du finne Nova ID. Dette kan gjøres på flere
måter, enten ved å se i instansens konfigurasjonsfil::

  # grep uuid /etc/libvirt/qemu/instance-00000000.xml

eller ved å bruke himlarcli::

  # ./hypervisor.py instances <hypervisor> | grep instance-00000000

Merk at du for øyeblikket må avkommentere::

  #'6'': getattr(i, 'OS-EXT-SRV-ATTR:instance_name'),

i hypervisor.py for å få qemu-navn listet ut i tabellen.

(Re)installasjon av status-01
-----------------------------

Dette gjelder kun status med graphite datasoure på monitor (el7)

Puppet setter opp det meste men det er to ting som manuelt må settes opp:

* Endre org name til "norcams"
* Endre settings til å bruke Dashboard/Status som default dashboard
