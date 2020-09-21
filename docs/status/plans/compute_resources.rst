======================
Compute resources (CR)
======================

Sist endret: 2020-09-21

.. IMPORTANT::
   KLADD. Dette dokumentet er kun et internt utkast.

Intro
=====

Compute resources (beregningsressurser på norsk) er en type instanser i NREC
som er tenk å kjøre tyngre oppgaver over lengre tid enn vanlig instanser.
Instansene vil ofte ha mer ressurser (minne og vCPU).

Dedicated compute resources (DCR)
---------------------------------

Dette er en variasjon av compute resources hvor instansens minne og vCPU
ikke er delt med andre. Instanser her vil være NUMA aware og ha høyere ytelse
enn vanlige compute resources. Dette vil passe til oppgaver som kjøres 24/7
over en lengre periode. Eksempler på dette er CERN T1 jobbene til atlas og
alice.

Et annet eksempel på dette er vGPU eller GPU som vil kreve dedikerte ressurser.

OSL
===

Vi tilbyr dedicated compute resources i dag som en del av det vi nå kaller HPC.

BGO
===

Vi har planer om å tilby vanlig compute resources og dedicated compute resources
med vGPU. Det kan også bli aktuelt å tilby dedicated compute resources uten
vGPU i fremtiden.

Compute hosts
-------------

Vi har følgende compute hosts tilgjengelig::

  TODO: liste med host og spec (ram, cpu og disk)

Navn
----

* Host aggregate: bør ha navn etter bruksområde pluss et tall for fremtiden,
  f.eks. dcr1 eller vgpu1
* role variation: kan ha navn etter HW eller brukeområde som over
* flavor: bør ha navn som gir mening for brukeren som skal velge det, kan være
  samme som første del av host aggregate (uten tall)

Eksempel::

  Role variation = host aggregate == flavor type (ikke nødvendigvis navn)

dcr = dedicated compute resources

cr = compute resources

vgpu = dedicated compute resources with vGPU

gpu = dedicated compute resources with GPU passthrough
