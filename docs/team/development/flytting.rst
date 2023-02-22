
===============================
Flytting til nytt maskinrom OSL
===============================


Kan flyttes/settes opp først
----------------------------

#. controller-05..08

#. compute-57..63

#. compute-epyc-56

#. diverse mgmt-switcher

#. sette opp ny osl-login (krever uio-nett)


Transportnett
-------------

#. verifisere at trp funker

#. en leaf

#. en torack

#. en spine + uplink + teste uplink

#. verifisere at nye computes virker


Flytting
--------

#. migrere/reinstallere controller-vm-er til controller-05..08

#. maskiner som er i placeholder + teste

#. storage-noder
   - en og en ... hvordan?
   
#. standard computes
   - disable
   - migrere ut instanser til en compute i nytt maskinrom
   - ta ned noden og flytte den

#. vgpu computes
   - skru av alle instanser
   - disable
   - flytte

#. shpc computes - ditto

#. atlas computes - ditto

#. hpc computes + robin - ditto

#. flytte leaf, torack, spine, kable opp

#. flytte siste uplink


Etter flytting
--------------

#. sette opp fysiske ceph-mons

#. gjennomgå kabling

#. testing?

#. fest
