
===================================================
Policy for håndtering av prosjekter som når enddate
===================================================

Før enddate
===========

* Varsling om enddate:

  - Når det er 60 dager til enddate
  - Når det er 30 dager til enddate
  - Når det er 7 dager til enddate

  Gjøres med::
    
    ./report.py enddate --days 60 --days 30 --days 7 --template notify/notify_enddate_before.txt

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

Når prosjektet er i karantene varsler vi admin/contact:

* Når det er 60 dager til sletting (30 dager siden tag ``quarantine
  date: <dato>``)
* Når det er 30 dager til sletting (60 dager siden tag ``quarantine
  date: <dato>``)

  Gjøres med::

    ./report.py quarantine --days 60 --days 30 --template notify/notify_enddate_quarantine.txt

Når prosjektet har vært i karantene i 90 dager, dvs. det er 90 dager
siden tag ``quarantine date: <dato>``:

* Prosjektet slettes

  Gjøres med::

    ./report.py quarantine --days 90 --list | awk '{print $2}' # lage liste
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


Utrullingsplan
==============

Problemområder:

#. Prosjekter hvor enddate er passert
#. Prosjekter med enddate i nær fremtid (dvs. mindre enn 3 mnd)
#. Prosjekter som ikke har enddate
#. Prosjekter med enddate for langt frem i tid (mer enn 2 år)

Plan for utrulling:

#.  **UTFØRT** Policy må beskrives på brukerdoc-sidene

   * https://docs.nrec.no/enddate.html

#. URL til policy må legges inn i mail templates i himlarcli:

   * notify_enddate_before.txt
   * notify_enddate_after.txt
   * notify_enddate_quarantine.txt

#. Varsle om at ny policy trer i kraft, link til informasjon. Normal
   varsling til Twitter, Slack og Statussiden.

   * Forslag til tekst::

       New end date policy will take effect soon:
       https://docs.nrec.no/enddate.html Projects where end date has
       passed or is due soon will automatically get en extension, and
       you will be informed via email

#. Alle prosjekter uten enddate får satt enddate 6 mnd frem i tid. Kun
   unntak for systemprosjekter. Prosjekteiere + contact varsles via
   mail

   * Forslag til tekst::

       From: The NREC Team <support@nrec.no>
       To: <admin>
       Cc: <contact>
       Subject: NREC: New end date set for project <foo>

       Hi,

       Our new policy for project end date is in effect very
       soon. More information:

         https://docs.nrec.no/enddate.html

       The project <foo> did not have an end date.

       New end date is: <date>

       See the URL above for information about how to get an end date
       extension.

       IMPORTANT: If this project is no longer in use, please let us
       know so that we may delete it and free up the resources for
       other users.

       Kind Regards,
       --
       The NREC Team <support@nrec.no>

#. Prosjekter hvor enddate er passert får satt ny enddate 3 mnd frem i
   tid. Prosjekteiere + contact varsles via mail

   * Forslag til tekst::

       From: The NREC Team <support@nrec.no>
       To: <admin>
       Cc: <contact>
       Subject: NREC: New end date set for project <foo>

       Hi,

       Our new policy for project end date is in effect very
       soon. More information:

         https://docs.nrec.no/enddate.html

       The end date for project <foo> was passed.

       New end date is: <date>

       See the URL above for information about how to get an end date
       extension.

       IMPORTANT: If this project is no longer in use, please let us
       know so that we may delete it and free up the resources for
       other users.

       Kind Regards,
       --
       The NREC Team <support@nrec.no>

#. Prosjekter med enddate i nær innen 60 dager får satt ny enddate 4
   mnd frem i tid. Prosjekteiere + contact varsles via mail

   * Forslag til tekst::

       From: The NREC Team <support@nrec.no>
       To: <admin>
       Cc: <contact>
       Subject: NREC: New end date set for project <foo>

       Hi,

       Our new policy for project end date is in effect very
       soon. More information:

         https://docs.nrec.no/enddate.html

       The end date for project <foo> was due soon.

       New end date is: <date>

       See the URL above for information about how to get an end date
       extension.

       IMPORTANT: If this project is no longer in use, please let us
       know so that we may delete it and free up the resources for
       other users.

       Kind Regards,
       --
       The NREC Team <support@nrec.no>

#. Prosjekter med enddate for langt frem (>2 år) får satt ny enddate 2
   år frem i tid. Prosjekteiere + contact varsles via mail

   * Forslag til tekst::

       From: The NREC Team <support@nrec.no>
       To: <admin>
       Cc: <contact>
       Subject: NREC: New end date set for project <foo>

       Hi,

       Our new policy for project end date is in effect very
       soon. More information:

         https://docs.nrec.no/enddate.html

       The end date for project <foo> was set too far into the
       future. According to the policy, maximum is 2 years. You may
       extend the life time of the project by applying for an
       extension when the new end date is due.

       New end date is: <date>

       See the URL above for information about how to get an end date
       extension.

       IMPORTANT: If this project is no longer in use, please let us
       know so that we may delete it and free up the resources for
       other users.

       Kind Regards,
       --
       The NREC Team <support@nrec.no>

#. Policy iverksettes. **Kun på osl-proxy-02**

   * Cron-jobb for varsling før enddate::

       0 6 * * * /opt/himlarcli/bin/enddate-notify-before.sh >/dev/null 2>&1

   * Cron-jobb for å sette i karantene::

       5 6 * * * /opt/himlarcli/bin/enddate-enter-quarantine.sh >/dev/null 2>&1

   * Cron-jobb for varsling av prosjekter i karantene::

       10 6 * * * /opt/himlarcli/bin/enddate-notify-quarantine.sh >/dev/null 2>&1

   * Cron-jobb for slette prosjekter som har vært i karantene 90 dager::

       15 6 * * * /opt/himlarcli/bin/enddate-delete.sh >/dev/null 2>&1
