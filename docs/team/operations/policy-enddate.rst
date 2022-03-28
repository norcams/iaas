
===================================================
Policy for håndtering av prosjekter som når enddate
===================================================

Før enddate
===========

* Varsling om enddate:
  - Når det er 60 dager til enddate
  - Når det er 30 dager til enddate
  - Når det er 14 dager til enddate

  Gjøres med::
    
    ./report.py enddate --days 60 --days 30 --days 14 --template notify/notify_enddate_before.txt

Ved enddate
===========
    
Når enddate nås:

* Alle instanser skrus av
* Prosjektet disables
* Varsling til admin / contact
* Setter tags på prosjektet:
  - ``quarantine date: <dato>``
  - ``quarantine type: enddate``
  - ``quarantine_active``

  Gjøres med::

    ./report.py enddate --days 0 --list | awk '{print $2}' # lage liste
    for project in <liste>; do
        ./project.py quarantine --reason enddate -m --template notify/notify_enddate_after.txt $project
    done

Etter enddate
=============

Når prosjektet er i karantene:

* Når det er 60 dager til sletting (30 dager siden tag ``quarantine
  date: <dato>``): Varsling til admin / contact
* Når det er 30 dager til sletting (60 dager siden tag ``quarantine
  date: <dato>``): Varsling til admin / contact

  Gjøres med::

    ./report.py enddate --days -60 --days -30 --template notify/notify_enddate_quarantine.txt

Når prosjektet har vært i karantene i 90 dager, dvs. det er 90 dager
siden tag ``quarantine date: <dato>``:

- Prosjektet slettes

  Gjøres med::

    ./report.py enddate --days -90 --list | awk '{print $2}' # lage liste
    for project in <liste>; do
        ./project delete $project
    done

Andre rutiner
=============

* Hvis quarantine tags ikke er satt og admin ber om
  oppdatering av enddate:
  - Enddate oppdateres manuelt (maks 2 år frem i tid)

  Gjøres med (eksempel)::

    ./project.py extend --end +1y <prosjekt>

* Hvis quarantine tags er satt og admin ber om oppdatering
  av enddate:
  - Prosjektet enables
  - tags "quarantine*" fjernes
  - Ny enddate settes (maks 2 år frem i tid)
  - Admin må selv skru på instanser

  Gjøres med::

    ./project.py quarantine --unset <prosjekt>
    ./project.py extend --end <arg> <prosjekt>
