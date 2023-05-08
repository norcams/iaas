
===============================
Flytting til nytt maskinrom OSL
===============================

Fordeling av oppgaver
---------------------

* Varsling til brukere (spesifikk mail om nedetid):

  - Raymond

* Varsling til brukere generelt (twitter o.l.):

  - Trond

* Transportnett:

  - Raymond
  - Mikael
  - Erik
  - (Trond)

* Migrering:

  - Lennart
  - Raymond
  - Erik

* Storage-migrering:

  - Terje
  - (Lennart)

* Flytting av sHPC, HPC, vGPU, ROBIN, ATLAS:

  - Trond
  - Mikael
  - Raymond
  - (Lennart)

* Migrere m2-instanser for IntArk:

  - Raymond
  - Erik

* Migrere m2-instanser generelt:

  - Raymond
  - Erik

* Fysisk flytting:

  - Trond
  - Mikael
    
    
Dagsplan
--------

* Torsdag 4.mai:

  - Varsle brukere (hvis ikke gjort før)
  - Flytte transportnett
  - verifisere trp-nett, nye computes m.m.

* Fredag 5.mai:

  - Starte migrering
  - Starte flytting av storage
  - Flytte placeholder
  - Flytte tomme computes

* Mandag 8.mai:

  - Migrere m2-instanser i IntArk (uh-intark-prod)

* Tirsdag 9.mai:

  - Flytte sHPC (3 compute)
  - Flytte HPC (4 compute)
  - Flytte vGPU (2 compute)
  - Flytte ROBIN (1 compute)

* Onsdag 10.mai:

  - Migrere m2-instanser (shutoff m/nedetid)
  - Flytte ATLAS (22 compute)



Kan flyttes/settes opp først
----------------------------

#. controller-05..08

   - Installert
   - Mangler trp-nett

#. compute-57..63

   - Installert
   - Mangler trp-nett

#. compute-epyc-56

   - Installert
   - Mangler trp-nett

#. diverse mgmt-switcher

   - Installert 4 og 5
   - Mangler 6

#. sette opp ny osl-login (krever uio-nett)

   - Installert
   - Mangler login-nett
   - Mangler flere nett-porter (til test02)


Transportnett
-------------

Tentativt planlagt torsdag 4.mai

#. en spine + uplink + teste uplink

   - Hvilken spine? hvilken uplink?
   - Trenger 100 GbE optikk til interconnect (2 stk)

#. en leaf

   - Hvilken avhenger av hvilken spine
   - Trenger 10 GbE optikk (2 stk)

#. en torack

   - Hvilken avhenger av hvilken spine
   - Trenger 10 GbE optikk (2 stk)

#. verifisere at alt av trp fungerer

#. verifisere at nye computes virker

   - Kan starte migrering fredag 5.mai

#. disable computes i gammelt maskinrom


Flytting
--------

#. maskiner som er i placeholder + teste

   - Kan gjøres fredag 5.mai

#. storage-noder

   - kan startes fredag 5.mai
   - kan gjøres uavhengig av alt annet

#. standard computes

   - migrere ut instanser til en compute i nytt maskinrom
   - ta ned noden og flytte den
   - enable noden

#. vgpu computes

   - Tirsdag 9.mai
   - skru av alle instanser
   - disable
   - flytte

#. shpc computes

   - Tirsdag 9.mai
   - skru av alle instanser
   - disable
   - flytte

#. hpc computes

   - Tirsdag 9.mai
   - skru av alle instanser
   - disable
   - flytte

#. atlas computes

   - avtale tidspunkt
   - skru av alle instanser
   - disable
   - flytte

#. robin compute

   - avtale tidspunkt
   - skru av alle instanser
   - disable
   - flytte

#. migrere/reinstallere controller-vm-er til controller-05..08

#. flytte leaf, torack, spine, kable opp

#. flytte siste uplink



Etter flytting
--------------

#. sette opp fysiske ceph-mons

#. gjennomgå kabling

#. flytte kabling for mgmt-nett til å bruke osl-mgmt-00

#. testing?

#. fest
