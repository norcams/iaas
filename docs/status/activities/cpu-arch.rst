=========================================
(KLADD) Endre CPU-arkitektur i central1
=========================================

Last changed: 2025-09-15


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
enkelhetsskyld deler jeg opp hypervisor-nodene i tre generasjoner.


Analyse av dagens maskinpark
----------------------------

For å finne ut hvilken cpu model som passer best for hver enkelt
hypervisor skal man kunne kjøre::

  virsh -c qemu:///system capabilities

Resultat for bgo::

  $ sudo ansible bgo-compute-central -m shell -a 'sudo virsh -c qemu:///system capabilities | grep /model | head -n 1'
  bgo-compute-04 | CHANGED | rc=0 >>
        <model>Broadwell-IBRS</model>
  bgo-compute-03 | CHANGED | rc=0 >>
        <model>Haswell-noTSX-IBRS</model>
  bgo-compute-01 | CHANGED | rc=0 >>
        <model>Haswell-noTSX-IBRS</model>
  bgo-compute-02 | CHANGED | rc=0 >>
        <model>Haswell-noTSX-IBRS</model>
  bgo-compute-05 | CHANGED | rc=0 >>
        <model>Broadwell-IBRS</model>
  bgo-compute-06 | CHANGED | rc=0 >>
        <model>Broadwell-IBRS</model>
  bgo-compute-09 | CHANGED | rc=0 >>
        <model>Haswell-noTSX-IBRS</model>
  bgo-compute-08 | CHANGED | rc=0 >>
        <model>Haswell-noTSX-IBRS</model>
  bgo-compute-07 | CHANGED | rc=0 >>
        <model>Haswell-noTSX-IBRS</model>
  bgo-compute-10 | CHANGED | rc=0 >>
        <model>Haswell-noTSX-IBRS</model>
  bgo-compute-38 | CHANGED | rc=0 >>
        <model>Cascadelake-Server-noTSX</model>
  bgo-compute-40 | CHANGED | rc=0 >>
        <model>Cascadelake-Server-noTSX</model>
  bgo-compute-39 | CHANGED | rc=0 >>
        <model>Cascadelake-Server-noTSX</model>
  bgo-compute-59 | CHANGED | rc=0 >>
        <model>Cascadelake-Server-noTSX</model>
  bgo-compute-58 | CHANGED | rc=0 >>
        <model>Cascadelake-Server-noTSX</model>
  bgo-compute-60 | CHANGED | rc=0 >>
        <model>Cascadelake-Server-noTSX</model>
  bgo-compute-81 | CHANGED | rc=0 >>
        <model>Broadwell-noTSX-IBRS</model>
  bgo-compute-82 | CHANGED | rc=0 >>
        <model>Broadwell-noTSX-IBRS</model>
  bgo-compute-83 | CHANGED | rc=0 >>
        <model>Broadwell-noTSX-IBRS</model>
  bgo-compute-84 | CHANGED | rc=0 >>
        <model>Broadwell-noTSX-IBRS</model>

Resultat for osl::

  $ sudo ansible osl-compute-central -m shell -a 'sudo virsh -c qemu:///system capabilities | grep /model | head -n 1'
  osl-compute-06 | CHANGED | rc=0 >>
        <model>Broadwell-IBRS</model>
  osl-compute-04 | CHANGED | rc=0 >>
        <model>Broadwell-IBRS</model>
  osl-compute-05 | CHANGED | rc=0 >>
        <model>Broadwell-IBRS</model>
  osl-compute-08 | CHANGED | rc=0 >>
        <model>Skylake-Server-IBRS</model>
  osl-compute-07 | CHANGED | rc=0 >>
        <model>Skylake-Server-IBRS</model>
  osl-compute-43 | CHANGED | rc=0 >>
        <model>Cascadelake-Server-noTSX</model>
  osl-compute-10 | CHANGED | rc=0 >>
        <model>Skylake-Server-IBRS</model>
  osl-compute-09 | CHANGED | rc=0 >>
        <model>Skylake-Server-IBRS</model>
  osl-compute-44 | CHANGED | rc=0 >>
        <model>Cascadelake-Server-noTSX</model>
  osl-compute-45 | CHANGED | rc=0 >>
        <model>Cascadelake-Server-noTSX</model>
  osl-compute-46 | CHANGED | rc=0 >>
        <model>Cascadelake-Server-noTSX</model>
  osl-compute-47 | CHANGED | rc=0 >>
        <model>Cascadelake-Server-noTSX</model>
  osl-compute-48 | CHANGED | rc=0 >>
        <model>Cascadelake-Server-noTSX</model>
  osl-compute-49 | CHANGED | rc=0 >>
        <model>Cascadelake-Server-noTSX</model>
  osl-compute-50 | CHANGED | rc=0 >>
        <model>Cascadelake-Server-noTSX</model>
  osl-compute-57 | CHANGED | rc=0 >>
        <model>Broadwell-noTSX-IBRS</model>
  osl-compute-58 | CHANGED | rc=0 >>
        <model>Broadwell-noTSX-IBRS</model>
  osl-compute-60 | CHANGED | rc=0 >>
        <model>Broadwell-noTSX-IBRS</model>
  osl-compute-59 | CHANGED | rc=0 >>
        <model>Broadwell-noTSX-IBRS</model>
  osl-compute-61 | CHANGED | rc=0 >>
        <model>Broadwell-noTSX-IBRS</model>
  osl-compute-62 | CHANGED | rc=0 >>
        <model>Broadwell-noTSX-IBRS</model>
  osl-compute-63 | CHANGED | rc=0 >>
        <model>Broadwell-noTSX-IBRS</model>
  osl-compute-65 | CHANGED | rc=0 >>
        <model>Skylake-Server-IBRS</model>
  osl-compute-64 | CHANGED | rc=0 >>
        <model>Skylake-Server-IBRS</model>
  osl-compute-66 | CHANGED | rc=0 >>
        <model>Skylake-Server-IBRS</model>


Basert på dette vil vi fordele det slik:

+------------+---------------------------+------------------------+
| Aggregat   | CPU model                 | Compute hosts          |
+============+===========================+========================+
| central1   | Haswell-noTSX             | Alle                   |
+------------+---------------------------+------------------------+
| central2   | Skylake-Server-IBRS-noTSX | * bgo-compute-38..40   |
|            |                           | * bgo-compute-58..60   |
|            |                           | * bgo-compute-81..84   |
|            |                           | * osl-compute-09..10   |
|            |                           | * osl-compute-43..50   |
|            |                           | * osl-compute-57..66   |
+------------+---------------------------+------------------------+
| central3   | Broadwell-noTSX-IBRS      | * bgo-compute-81..84   |
|            |                           | * osl-compute-57..63   |
+------------+---------------------------+------------------------+

De tre generasjonene:

1. G1 (Haswell-noTSX): De eldste nodene
2. G2 (Skylake-Server-IBRS-noTSX): Ikke eldst, ikke nyest
3. G3 (Broadwell-noTSX-IBRS): De nyeste nodene

	
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


Sette traits på hypervisors
---------------------------

Vi definerer et par custom traits for å sørge for at scheduler
filtrerer til riktig compute-node. For hver compute-node som skal ha
m3-flavor::

  openstack --os-placement-api-version 1.28 resource provider \
      trait set --trait CUSTOM_NREC_FLAVOR_GEN_3 <uuid>

Der ``uuid`` er id-en som man finner slik::

  $ openstack resource provider list -c name -c uuid -f value | grep osl-compute-63
  69b5e9c2-3fc1-4762-9347-c21a44b16f4d osl-compute-63.mgmt.osl.uhdc.no



Nye flavors
-----------

NB! For praktiske formål later vi som at dagens m2-flavor ikke
eksisterer.

Jeg ønsker å definere nye flavors:

* m3 flavor for G3-nodene. Her må vi sette en "trait" for at scheduler
  skal velge riktig hypervisor (i YAML-fila)::
    
    trait:CUSTOM_NREC_FLAVOR_GEN_3: 'required'

* m2 flavor for G2-nodene. Her må også sette en trait::

    trait:CUSTOM_NREC_FLAVOR_GEN_2: 'required'

* m1 flavor skal ikke endres

Resultatet av dette vil være at:

#. Instanser av m3 vil alltid havne på G3-nodene
#. Instanser av m2 vil havne på G2 eller G3
#. Instanser av m1 vil havne hvor som helst

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
