===============
Navnekonvensjon
===============

Sist endret: 2017-03-07

.. WARNING::
   Under arbeid.

Her følger en oversikt over hvilke navn brukes til hva og hva som menes.

.. contents::

Overordnet
==========

Trenger navn på team, produkt (intern) og tjeneste (ekstern).

Team
----

Hva kaller vi oss selv vi som jobber med å sette opp en sektor intern IaaS?
Forslag **norcams**

Produkt
-------

Vi har valgt å navngi vår versjon av en Openstack installasjon **himlar**
(flertall av himmel på nynorsk). Dette navnet blir brukt på git-repoet som
vi bruker for å installere en lokasjon av vår Openstack.

Tjeneste
--------

Vi trenger et navn på tjenesten vi selger til andre organisasjoner i UH-sektoren
og våre sluttbrukere. Inntil man har noe bedre er det navnet **UH-IaaS**.

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
