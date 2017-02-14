=================
Workshop 1 - 2017
=================

Samling i ved USIT 2. og 3. februar 2017.

Agenda og referat ble ført i Trello. Siden alt som ligger i Trello er i konstant
endring ligger det en kopi av alt som ble diskutert under.

Arbeidsplan vår 2017
====================

Ceilometer
----------

Må først vurdere skalere rabbitmq.

Hvordan minimere bruken av root-disk til instanser
--------------------------------------------------

* Trenger å bygge egne image med discard
* Sjekke at image properties er satt rett på alle image (også snapshot)
* Løste problem med libvirt 2.0 (trenger 1.2, 2.1, patch)"

Nettverk: Fremtidig uplink
--------------------------

Vi har snakket om å koble UH-IaaS direkte til UNINETT både ved UiB og UiO.
Er dette problematisk?

* Petter tar kontakt med UNINETT for å høre om vi kan få flyttet uplink
  til i bgo og osl til UNINETT

Calico 2.0
----------

Designate
---------

Må bli enig om hva vi setter $domain til i designate. Forslag:

* `<sone>.uh-iaas.no`
* `<nytt-domene.no>`

Vi lager A-records for alle instans-IPer på formen `ip-xxx-xxx-xxx-xxx.vm.$domain`.

Finne ut om vi vil sette opp slave-master på innsiden av UH-IaaS eller bruker uio og uib
sine DNS-tjenester.

Implementere IPv6 for instanser
-------------------------------

Sette opp FreeBSD NAT bokser på controllere.
Petter har kontakter som kan hjelpe å sette det opp.

Hvordan vil vi lage object storage?
-----------------------------------

**Krav:**

* Vi trenger å lage et HW plan med realistisk priser.
* Pris på HW kan avgjøre valg av software
* Tilby snapshot
* Keystone som IDP
* Til release 2 skal det være tilgang til en object storage (kan være pilot)

**Plan for test:**

* Vi ønsker å teste både openstack swift og ceph.
* Ta en avgjørelse på hva vi bruker i release 2

**HW:**

* public ip til test02
* bruke test01-storage til å teste openstack swift
* lage nytt ceph-cluster i test01
* lage openstack swift i test02 på gammel HW (3 1U, og 2 4U)
* Bruker VMer for egen gateway for swift og ceph objectstorage

Åpne dashboard og api for verden?
---------------------------------

* Ønsker å kjøre selinux på dashboard og api.
* Avsjekk på sikkerhetsdokumentet for api og dashboard
* Sjekke om UNINETT har en form for blacklist eller filter vi kan bruke

**Access:**

* Trenger en koderevisjon av access
* Trenger en sikkerhets vurdering av access.

Markedsføring
-------------

**Webside:**

* vi trenger en forside å sende nye brukere til
* lager et git repo på github og setter opp github-pages for norcams.github.io
* www.uh-iaas.no vil da vise disse sidene
* vi kan ta utgangspunkt i design som ligger på iaas.uhsky.no
* vi kan få KA til å hjelpe til med navn og logo

**Skaffe brukere:**

* bruke faggruppe for skyteknologi til å promotere tjenesten til andre
* fokus på snakke med miljøene lokalt først
* hjelpe it-avd og usit med å ta det i bruk

Newton
------

Oppgradere til neste versjon av openstack: newton

Puppet 4
--------

Prøver å få til en oppgradering av puppet etter newton.
Dersom newton fungerer bedre med puppet 4 må vi vurdere å ta det før.

Uprioriterte arbeidsoppgaver
================================

Ekstra HW (osl-controller-04)
-----------------------------

Ønsker en ny controller-04 i OSL også som kan kjøre management noder: logger, admin, monitor, etc
vurdere iaas-vagrant01

Oppetid og kapasitet på tjenester (HA, LB)
------------------------------------------

Kapasitet (LB):

* Setter opp 3 backend noder for alle api (nova, volume, glance, neutron)
* Teste litt mer før vi sett opp 3 backends for keystone

Oppetid (HA):

* vi kan speile databasene for å få høyere oppetid
* se på mulighet for å bruker ruting og anycast til api failover

Lastbalanserer:

* sette opp to nye eksterne last-balanserer for å få HA på public tjenestene våre og tilby en enkel LBaaS"


Andre tema
==========

**I hvor stor grad bør vi bruke institusjonenes tjenester for perifere
administrative ting, kontra å sette opp og drifte selv? (overvåkning,
logging, grafing, etc.)**

* det er ikke brukt mye tid på logging og monitor (metrics) til nå
* vi vil måtte bruke tid på logg-filtre og graf-dashboard, dette vil være det samme uansett hvor det kjører"

**Nettverk: Redundant uplink OSL**

Ved UiB har vi link ut fra UH-IaaS fra både
leaf-01 og leaf-02 (de er koblet i samme switch, men gir oss redundans), mens
i UiO har vi nå kun en fra leaf-02. Har vi mulighet til å gjøre det samme ved UiO?

* Vi kobler rett til UNINETT

**Nettverk: NAT-tjeneste OSL**

Når vi skal implementere IPv6 så trenger vi en tjeneste for NAT på IPv4.
Vi ønsker at instansene kjører med public IPv6 og privat IPv4 (som da trenger NAT ut).
Ved UiB vil vi få levert denne tjenesten av nettverksgruppen.
Klarer vi å få til noe bed UiO?

* Setter opp NAT på controllere

**Vi bør se på mulighet for å bruke Gluster på compute**
