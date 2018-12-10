===============
Navnekonvensjon
===============

Sist endret: 2018-11-30

.. WARNING::
   Under arbeid.

Her følger en oversikt over hvilke navn brukes til hva og hva som menes.

.. contents::

Overordnet
==========

Team
----

Teamet opererer under navnet **norcams**, som også er vårt navnrom på Github.

Produkt
-------

Vi har valgt å navngi Openstack-installasjonen **himlar** (flertall av himmel
på nynorsk). Dette navnet blir brukt på git-repoet for
konfigurajonshåndteringskoden, og andre repoer, verktøy etc som er relatert
til installasjonen (f.eks. himlarcli).

Tjeneste
--------

Vi trenger et navn på tjenesten vi selger til andre organisasjoner i
UH-sektoren og våre sluttbrukere. For øyeblikket kaller vi tjenesten
**UH-IaaS**. Vi vurderer å skifte dette navnet til UniSky.

Lokasjoner
----------

Vi har valgt å bruke flyplasskoder for å navngi lokasjoner (regioner i Openstack).
Når vi snakker om **BGO** så snakker vi om den installasjonen vi har på UiB og
**OSL** er på USIT.

Tekniske begrep
===============

Instans
-------

Sluttbrukeren sin maskin i Openstack (eller IaaS generelt) blir
omtalt som instanser. Det har vært viktig å skille instans fra virtuell
maskin siden det ikke er det samme.

Node
----

Vi bruker **node** om maskiner som kjører våre Openstack, Storage
eller management tjenester. En node er alltid knyttet til en rolle i **himlar**
og kan kjøre både i dev, test og prod.
