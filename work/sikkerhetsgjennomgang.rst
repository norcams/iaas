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


Nettverksdesign
---------------

Det er totalt to separate lokasjoner (Oslo og Bergen), og således to
adskilte nettverk fysisk, med tilsammen 5 kategorier nettverk. Det er 
ikke dratt felles nett over disse lokasjoner, slik at det er 5 nett på hvert
sted. For beskrivelse av disse adresserommene se _IP addressing plan: http://iaas.readthedocs.org/en/latest/installation/ip.html
på Norcams dokumentasjonssider.


Public
''''''
Dette er adresser som tildeles instanser satt på infrastrukturen (dvs.
kunde-styrt). Disse gir kun aksess til de virtuelle systemene og ikke til
infrastrukturen rundt.


Infrastruktur/management
''''''''''''''''''''''''

Service-nett
""""""""""""

Aksesspunkt for felles infrastruktur-tjenester. Dette er delt i to: intern
aksess og åpen (offentlig) aksess. Førstnevnte settes opp med adresser fra
private adresseområder, sistnevnte etter behov med adresser fra `Public`_.

Management-nett
"""""""""""""""

For intern system-administrasjon; bla. ssh-aksess for drifts-personale. Disse er
kun aksesserbare via den enkelte login-node, hvilken har et ben på dette
nettverket.

OOB-nett
""""""""

Forbindelse til de fysiske maskiners out-of-band management-moduler (OOB). Disse
skal ikke være tilgjengelige fra omverden, men må aksesseres via login-nodene,
som har et ben på dette nettverket.

Transport-nett
""""""""""""""

Interne transporter av service- og lagringstrafikk. Adresserommet konstrueres
fra et av de private adresseområdene.


Tilgang til springbrett og management-nett
------------------------------------------

Problemstilling
'''''''''''''''

Hver enkelt lokasjon har en egen login-server, hvorfra eneste mulighet for å nå
management-nett og OOB-nett er. Tilgangen i dag er via ssh hvor definerte
brukere kan logge inn via SSH-nøkler. Brukere og tilhørende offentlige
SSH-nøkler defineres i datatreet (`hieradata`), hvilket er åpent tilgjengelig.

Plan for løsning
''''''''''''''''

Det er testet oppsett av 2faktor-autentisering med Google Authenticator. Planen
er å implementere dette rundt produksjonsstart slik at det i tillegg til
SSH-nøkkel må ha dette konfigurert. Man kan evt. også tenke seg å begrense
adgangen til disse systemene fra et begrenset sett med kjente nett/adresser.


Root-passord
------------

Problemstilling
'''''''''''''''

Dette settes for Foreman-installerte systemer (dvs. infrastruktur-systemer som
er en del av IAAS-rammeverket) via Foreman-opsjonen "root_pass". Denne ligger
her MD5-kryptert, men mates fra et provisjoneringsskript hvor passordet ligger i
klartekst, dette skriptet er igjen i offentlig repository.

Dette fører til at root-passordet er åpent tilgjengelig. Systemene skal ikke
kunne nås direkte fra omverden, men dersom noen klarer å bryte seg "inn" til
infrastrukturen er dette likevel uønsket.


Plan for løsning
''''''''''''''''

Passordet må:

1. av skriptet i stedet hentes fra det lokale "secret"-repoet
#. krypteres med nyere algoritme enn MD5
#. settes til noe mye bedre enn dagens test-passord



Foreman-konfigurasjon
---------------------

Problemstilling
'''''''''''''''

Det er en bruker som har full tilgang til alt og som settes opp
ved installasjon av Foreman: 'admin'. Får man tilgang til denne brukeren kan man
installere og endre basis-infrastrukturen. Dennes passord settes av Puppet, data
for passordet ligger i klartekst i datatreet (`hieradata`) på offentlig repo.


Plan for løsning
''''''''''''''''

Passordet må:

1. endres til noe mye sikrere enn dagens test-passord
#. enten
   a. settes kryptert i datafilen (er neppe sikkert nok om det krypterte passord er offentlig tilgjengelig)
   #. av Puppetmaster kunne hentes fra det lokale "secret"-repoet



OpenStack-konfigurasjon
-----------------------

Problemstilling
'''''''''''''''

Det er flere komponenter her som får satt opp et passord av type 'admin', den
viktigste er keystone administrator-passord, men også feks. for 'nova' m.fl.
komponenter. Disse settes via Puppet, hvor data hentes fra datatreet
(`hieradata`) som for tiden ligger i offentlig repository.

Plan for løsning
''''''''''''''''

Passord må:

1. endres til noe mye sikrere enn dagens test-passord
#. enten
   a. settes kryptert i datafilen (er neppe sikkert nok om det krypterte passord er offentlig tilgjengelig)
   #. av Puppetmaster kunne hentes fra det lokale "secret"-repoet


Cumulus
-------

Problemstilling
'''''''''''''''

Lisenser m.v. ligger i lokalt "secret"-repository og håndteres manuelt.
Installasjon og førstegangsoppsett av administrator-passord m.v: UKJENT

Sikkerhetsmessig er dette i seg selv ikke problematisk, men driftsmessig kan det
vise seg tungdrevet med manueklle rutiner. Det vil i så fall være nødvendig å ta
hensyn til den sikkerhetsmessige siden ved utvikling av nye rutiner.


BMC
---

Problemstilling
'''''''''''''''

De fysiske maskinenes BMC (iDRAC etc) settes opp ved å boote opp maskinene med
en USB-pinne med ønsket konfigurasjon satt i maskinens for formålet spesielle
USB-port. Det kreves følgelig fysisk tilgang til maskinrom for dette.

Etter konfigurasjon er disse enhetene nåbare fra nett, slik at tilgang hit med
aksess til login-data vil kunne føre til uønsket adgang.

Plan for løsning
''''''''''''''''

Modulene konfigureres til å ikke tillate endring av oppsett fra lokal maskin,
kun fra administrasjonsserveren. Det utvikles Puppet-modul for å sørge for at
denne innstillingen holdes slik som beskrevet. Brukernavn og passord ligger kun
i det lokale "secret"-repoet og brukes ikke av noen automatiske rutiner.

I tillegg er BMC-modulene kun nåbare fra de enkelte lokasjoners
springbrett/login-maskin, denne er videre tenkt sikret med 2-faktorautentisering.


OS-patching
-----------

Problemstilling
'''''''''''''''

Status: OS patches opp til dagens nivå ved installasjon, men blir deretter ikke
automatisk patchet. Et moment her er at man må vurdere om det er pakker som må
holdes spesielt stabile i forhold til driften av OpenStack-installasjonen.

Plan for løsning
''''''''''''''''

En foreløpig plan er å teste oppdateringer på dev-miljøene, og deretter trigge
oppdateringer med Ansible-kjørebøker via Consul. UiB har en del opplegg rundt
Ansible-delen av dette som vi kan vurdere. Det må i så fall defineres (og
etterfølges) faste rutiner for dette slik at det blir fulgt opp.

