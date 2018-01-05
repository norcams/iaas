======================
Øke kvoter i etterkant
======================


Et prosjekt får alle kvoter satt automatisk ved opprettelse, enten til
default-verdiene eller til annen kvote definert ved opprettelsen via
*himlarcli*. Vi har dog ikke noe enkelt grensesnitt for å endre kvotene på et
prosjekt i ``etterkant`` (fra feks. `small` til `medium`). Man må da i stdet
endre hver individuell kvote manuelt med *openstack* e.l.

Eksempel:

Prosjektet **mikaeld-test** er satt opp med kvote `small` i utgangspunktet.
Denne skal nå endres til kvote `large`, men med en ytterlige økt kvote for
minnebruk (opp fra `96 GB` til `160 GB`) og GB med snapshots (der er det
allerede en økt kvote på `600 GB` mens default for `large` er `500 GB`).

.. NOTE::
   Forutsetter at omgivelsesmiljø-variabler for `openstack` og `himlarcli` er
   definert på forhånd på ordinær måte!


1. Finn prosjekt-id:
   
   `/opt/himlarcli/project.py show mikaeld-test | grep "^id ="`
   
   Alternativt:
   
   `/opt/himlarcli/project.py list | grep mikaeld-test`

#. Finn gjeldende kvoter:
   
   `openstack quota show $id`

#. Finn kvoter for nytt kvote-sett:
   
   `cat /opt/himlarcli/config/quotas/large.yaml`

#. Sett nye kvoter med utgangspunkt i det som ble funnet over:
   
   `openstack quota set --ram 163840 --instances 50 --cores 100 --snapshots 40 --volumes 20 --secgroup-rules 500 --secgroups 100 $id`
   
   Hvis man også skal sette kvoten for disk-størrelse så slenger man på
   `--gigabytes <ny kvote>`

#. Bekreft med:
   
   `openstack quota show $id`

#. Siste to punkter må gjentas for alle regioner (dersom det skal være likt overalt)
   da denne kommandoen kun tar effekt i den region det kjøres i/mot!

