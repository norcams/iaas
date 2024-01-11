=========================================
(KLADD) Endre CPU-arkitektur i central1
=========================================

Last changed: 2024-01-11


Dagens tilstand
===============

I central1 har vi i dag kun én CPU-arkitektur som presenteres til
instansene:

* Haswell

Denne er tilpasset de eldste hypervisor-nodene. Det er slik jeg ser
det noen problemer med dette:

#. Vi kunne tilbudt nyere CPU-arkitektur på de nyere
   hypervisor-nodene, men det gjør vi ikke

#. Vi mangler justeringer for mitigering av Spectre- og
   Meltdown-sikkerhetshullene

#. Vi har i dag ingen mekanisme for å sikre at VIP-kunder havner på de
   nyeste (beste) hypervisor-nodene


Ønsket tilstand
===============

Først og fremst ønsker jeg å få på plass mitigering av Spectre,
Meltdown og tilsvarende sikkerhetshull.

Dernest ønsker jeg å kunne tilby nyere CPU-arkitektur for
VIP-kunder. Dette kan gjøres ved å innføre "tiering". For
enkelhetsskyld deler jeg opp hypervisor-nodene i tre generasjoner:

1. G1 (Haswell): De eldste nodene
2. G2 (CascadeLake): Ikke eldst, ikke nyest
3. G3 (IceLake): De nyeste nodene

Endringer i nova.conf
---------------------

.. _Important CPU features for Intel x86 hosts: https://www.qemu.org/docs/master/system/i386/cpu.html#important-cpu-features-for-intel-x86-hosts
.. _Openstack Doc - CPU models: https://docs.openstack.org/nova/latest/admin/cpu-models.html

For samtlige ønsker jeg å sette følgende flagg i nova.conf via
himlar::

  nova::compute::libvirt::libvirt_cpu_model_extra_flags:
    - 'pcid'
    - 'spec-ctrl'
    - 'stibp'
    - 'ssbd'
    - 'pdpe1gb'
    - 'md-clear'
    - 'mds-no'   # kun for G2 og G3
    - 'taa-no'   # kun for G3
    - 'tsx-ctrl' # kun for G2

Dette er tatt fra `Important CPU features for Intel x86 hosts`_
      
Vi må også sette cpu_mode=custom hvis ikke det allerede er satt::

  nova::compute::libvirt::libvirt_cpu_mode:   'custom'
      
For G2 vil vi spesifisere en liste av CPU-arkitekturer::

  nova::compute::libvirt::libvirt_cpu_models:
    - 'Haswell'
    - 'Cascadelake-Server'

For G3 det samme, men inkludere IceLake::

  nova::compute::libvirt::libvirt_cpu_models:
    - 'Haswell'
    - 'Cascadelake-Server'
    - 'Icelake-Server'

Ideen bak dette er tatt fra `Openstack Doc - CPU models`_
      
Nye flavors
-----------

NB! For praktiske formål later vi som at dagens m2-flavor ikke
eksisterer.

Jeg ønsker å definere nye flavors::

* m3 flavor for G3-nodene. Her må vi sette en "trait" for at scheduler
  skal velge riktig hypervisor::
    
    openstack flavor set m3 --property trait:HW_CPU_X86_AVX512-VPOPCNTDQ=required

  Dette er basert på `Openstack Doc - CPU models`_ og::

    diff /usr/share/libvirt/cpu_map/x86_Skylake-Server-noTSX-IBRS.xml /usr/share/libvirt/cpu_map/x86_Icelake-Server-noTSX.xml | grep feature | grep '>'

* m2 flavor for G2-nodene. Her må også sette en trait::

    openstack flavor set m2 --property trait:HW_CPU_X86_3DNOWPREFETCH=required

  Dette er basert på `Openstack Doc - CPU models`_ og::
    
    diff /usr/share/libvirt/cpu_map/x86_Haswell.xml /usr/share/libvirt/cpu_map/x86_Skylake-Server-noTSX-IBRS.xml | grep feature | grep '>'

* m1 flavor skal ikke endres

Resultatet av dette vil være at:

#. Instanser av m3 vil alltid havne på G3-nodene
#. Instanser av m2 vil havne på G2 elle G3
#. Instanser av m1 vil hanve hvor som helst

Dette gir relativt god fleksibilitet.

Negative konsekvenser
---------------------

Den åpenbare negative konsekvensen er at live-migrering blir
vanskeligere. Man kan ikke migrere alle instansene fra en G3-node til
G2/G1, og man kan ikke migrere alle instansene fra en G2-node til
G1. Andre veien går fint.


Utrulling
=========

Dette er veldig tentativt. Det er gjort antakelser og alt må testes.

#. Legge på plass **cpu_model_extra_flags** i nova.conf

#. Reboote hypervisor-nodene som har fått endringen

#. Sjekke at migrering funker, og at migrerte instanser fungerer

#. Sjekke at nye instanser får flaggene satt

#. Lage nye flavors m2 og m3

#. Legge på plass **cpu_models** i nova.conf (på G2, G3)

#. Sjekke at migrering til/fra fungerer

#. Sjekke at nye flavors fungerer

#. Sjekke migrering med nye flavors
