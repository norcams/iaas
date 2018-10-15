======
Uke 41
======

av Raymond Kristiansen, UH IaaS, 15.oktober 2018

Oppdatert informasjon om status finnes alltid i
`Trello <https://trello.com/norcams>`_

.. contents::

Status
======

Vi har nå startet oppgradering til pike i test. For identity har vi testet
bruk av `rolling upgrade` for identity. Dvs at vi oppgraderer identity i fart
uten at brukere skal merke at tjenesten er utilgjengelig. Dersom testene går
bra er planen å oppgradere Openstack Keystone (identity) til Pike i uke 42.

Vi har jobbet videre med å sette opp flere backends for Openstack tjenestene med
mål om å bedre oppetid ved planlagt vedlikehold og øke ytelsen. De som gjenstår
nå er image og volume tjenestene.

De siste ukene har også gått med til å feilsøke og overvåke tilgjengeligheten av
DHCP lease for IPv6 adresser på instanser. Vi har fått rapporter om at windows
instanser har mistet IPv6, men har selv ikke klart å gjenskape problemet. Vi har
også laget en patchet versjon av dnsmasq (som brukers som dhcp-server) som
tvinger instansene til å godta lengre levetid på IPv6 adressen. Vi tester nå
denne for å finne ut vi vil ta den i bruk. Siden vi bruker IPv6 til DNS resolvere
vil et fravær av IPv6 også medføre manglende DNS. Dette er har vært tidkrevende
å feilsøke siden vi ikke ser problemer på DHCP-serveren eller klarer å overvåke
IPv6 i andre instanser enn dem vi tester på.

Utfordringer
============

Vi begynner å gå tom for compute ressurser, spesielt i OSL. Der har vi nå gikk
vekk ca 3 ganger så mange vCPUs som vi har logiske kjerner (6 ganger mot fysiske
kjerner). Vi kan forsatt overprovisjonere litt mer, men i løpet av høsten må vi
ha flere compute hoster.

Planlagte aktiviteter
=====================

- Fortsette å hjelpe brukere med å ta i bruk tjenesten
- Oppgradere til ny Openstack-versjon: **Pike**
- testing av DNSaaS med Designate
- Pilot objektlagring

Annet
=====

- Se https://trello.com/norcams for oppdaterte planer.
