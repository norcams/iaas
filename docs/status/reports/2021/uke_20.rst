======
Uke 20
======

av Raymond Kristiansen, NREC, 20. mai 2021

Status lagringsproblemer OSL
============================

Om kvelden tirsdag 18.mai opplevde brukere av volumtjensten og imagetjenesten i
OSL alvorlig nedsatt ytelse. NREC har ingen vakt om natten og vi ble først kjent
med problemet onsdag morgen. Vi startet da med feilsøking og lokaliserte det vi
antok var problemet. Rundt klokken 10:30 var problemet løst.

Litt mer detaljer om problemet
------------------------------

Vi antar at problemet henger samme med en konfigendring vi utførte på Ceph etter
arbeidstid tirsdag. Endringen ble utført både i BGO og OSL, og det var ingen
indikasjoner på problemer i etterkant. Vi er ikke sikker på hvorfor det så
oppstod problemer i OSL og ikke BGO i etterkant, men vi mistenker at det kan
ha noe med at vi regelmessig (hvert 30 min) kjører et config management system
(CMS) for å sikre tilstanden til alle komponentene. Dette kan ma medført Ceph
fikk motstridene beskjed om hvilke konfig den skulle bruke. Vi har i ettertid
gått igjennom all Ceph konfig i CMS for å unngå at det samme skjer igjen.
