==================
Misbruk av NREC
==================

Dersom vi får CERT-meldinger på instanser så gjelder følgende
instruks:

#. Finn ut hvilken instans det er, vanligvis utfra IP:

   * IPv4::

       openstack server list --all --ip <ip-address-regex>

   * IPv6::

       openstack server list --all --ip6 <ip-address-regex>

#. Finn ut prosjekt-ID::

    $ openstack server show -f shell <instance-id> | grep project
    project_id="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

#. Finn admin for prosjektet::

    $ openstack project show -f shell <project-id> | grep admin
    admin="foo@bar.com"

#. Skru av og lås instansen::

    openstack server stop <instance-id>
    openstack server lock <instance-id>

#. Informer prosjektadmin via RT (e-post)

#. Dersom man oppnår kontakt bli enig med bruker om en løsning på
   problemet

#. Dersom vi ikke får svar fra bruker på tre forsøk (prøv også instans
   user om admin feiler) så kan instansen slettes.

