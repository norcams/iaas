Gjennomgang av håndtering/sikring av følsomme data
==================================================

Provisjonerings- og driftssystemet håndterer installasjon, konfigurasjon og "ønsket
tilstand"-drift av den underliggende infrastrukturen. Dette inkluderer naturlig
basis-systemer som switcher og servere, inkl. disses operativsystem. Dessuten
håndteres de grunnleggende administrasjonssystemene, som feks. *Foreman* og
*Horizon*.

I utviklings- og beta-fasen er det i utstrakt grad benyttet default brukernavn
og -passord, disse er dessuten håndtert via offentlige repositories, i hovedsak
på GitHub. Dette er selvsagt en situasjon som ikke er tenkt å vedvare inn i
produksjonsfasen. Det er laget et "secret"-repo lokalt, som i dag lagrer en del
følsomme data (bla. lisenser og DDNS-nøkler som er tenkt å anvendes også etter
produksjonssetting).

Alle forslag listet under som berører lagring av følsomme data i lokale
repositories på *Puppet-master* forutsetter at denne/disse sikres med
**2faktor-autentisering** (gjelder da både interaktiv innlogging og evt. pushing
av data). Det er allerede testet konfigurasjon for dette, men det er foreløpig
ikke implementert.



Root-passord
------------

Dette settes for Foreman-installerte systemer (dvs. infrastruktur-systemer som
er en del av IAAS-rammeverket) via Foreman-opsjonen "root_pass". Denne ligger
her MD5-kryptert, men mates fra et provisjoneringsskript hvor passordet ligger i
klartekst, dette skriptet er igjen i offentlig repository.

Passordet må:

1. av skriptet i stedet hentes fra det lokale "secret"-repoet
#. krypteres med nyere algoritme enn MD5
#. settes til noe mye bedre enn dagens test-passord



Foreman-konfigurasjon
---------------------

Det er _en_ vesentlig bruker her, som har full tilgang til alt og som settes opp
ved installasjon av Foreman: 'admin'. Ved tilgang til denne brukeren kan man
installere og endre basis-infrastrukturen. Dennes passord settes av Puppet, data
for passordet ligger i klartekst i datatreet (`hieradata`) på offentlig repo.

Passordet må:

1. endres til noe mye sikrere enn dagens test-passord
#. enten
   a. settes kryptert i datafilen (er neppe sikkert nok om det
      krypterte passord er offentlig tilgjengelig)
   #. av Puppetmaster kunne hentes fra det lokale "secret"-repoet



OpenStack-konfigurasjon
-----------------------

Det er flere komponenter her som får satt opp et passord av type 'admin', den
viktigste er keystone administrator-passord, men også feks. for 'nova' m.fl.
komponenter. Disse settes via Puppet, hvor data hentes fra datatreet
(`hieradata`) som for tiden ligger i offentlig repository.

Passord må:

1. endres til noe mye sikrere enn dagens test-passord
#. enten
   a. settes kryptert i datafilen (er neppe sikkert nok om det
      krypterte passord er offentlig tilgjengelig)
   #. av Puppetmaster kunne hentes fra det lokale "secret"-repoet


Cumulus
-------

Lisenser m.v. ligger i lokalt "secret"-repository og håndteres manuelt.
Installasjon og førstegangsoppsett av administrator-passord m.v: UKJENT


BMC
---

De fysiske maskinenes BMC (iDRAC etc) settes opp ved å boote opp maskinene med
en USB-pinne med ønsket konfigurasjon satt i maskinens for formålet spesielle
USB-port. Det kreves følgelig fysisk tilgang til maskinrom for dette.



OS-patching
-----------

Status: OS patches opp til dagens nivå ved installasjon, men blir deretter ikke
automatisk patchet. Et moment her er at man må vurdere om det er pakker som må
holdes spesielt stabile i forhold til driften av OpenStack-installasjonen.

En foreløpig plan er å teste oppdateringer på dev-miljøene, og deretter trigge
oppdateringer med Ansible-kjørebøker via Consul. UiB har en del opplegg rundt
Ansible-delen av dette som vi kan vurdere.

