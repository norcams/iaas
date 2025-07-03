
===================================================
Policy for shared security groups
===================================================

Bakgrunn
========

.. _Role-Based Access Control (RBAC): https://docs.openstack.org/neutron/latest/admin/config-rbac.html

Det er flere ting som kan deles via `Role-Based Access Control
(RBAC)`_ i Openstack. Av det som er interessant for oss er deling av
security groups og address groups. Alt er spesifikt for region og må
derfor gjøres i alle regioner.


Manuelt oppsett for test
========================

Laget et prosjekt **nrec-secgroups** etter modell fra nrec-images::

  openstack project create --description 'Project for sharing security groups' --domain 617d766a300441dfab4d78a6f630d358 --property org=nrec nrec-secgroups

Opprettet en security group::

  openstack security group create --project nrec-secgroups --description 'Allows ssh and ping from UiO networks' GOLD_ssh_icmp_from_uio

La inn ingress-regler og fjernet egress-reglene::

  openstack security group rule create --ethertype IPv4 --protocol icmp --remote-ip 129.240.0.0/16 42980bb2-5802-474d-ae10-8f0ecfaa5f5f
  openstack security group rule create --ethertype IPv4 --protocol tcp --dst-port 22 --remote-ip 129.240.0.0/16 42980bb2-5802-474d-ae10-8f0ecfaa5f5f
  openstack security group rule create --ethertype IPv6 --protocol ipv6-icmp --remote-ip 2001:700:100::/48 42980bb2-5802-474d-ae10-8f0ecfaa5f5f
  openstack security group rule create --ethertype IPv6 --protocol tcp --dst-port 22 --remote-ip 2001:700:100::/48 42980bb2-5802-474d-ae10-8f0ecfaa5f5f
  openstack security group rule delete 8dfdf462-085e-4130-a968-663c87ca284f
  openstack security group rule delete a77b690f-165f-4230-912f-62d47b51d527

La inn deling til iaas-team::

  openstack network rbac create --project nrec-secgroups --target-project iaas-team --action access_as_shared --type security_group 42980bb2-5802-474d-ae10-8f0ecfaa5f5f

Nå kan iaas-team bruke denne security
group-en **GOLD_ssh_icmp_from_uio**


Policy (forslag)
================

Hvorvidt et prosjekt skal få delt security groups til seg avhenger av

* Organisajonstilknytning (property ``org``)

* Tags:

  - ``gold_secgroups:uio``
  - ``gold_secgroups:uib``
  - ``gold_secgroups:<foo>``


Security Groups
---------------

Vi oppretter følgende security groups som gjøres tilgjengelig for alle
prosjekter:

* **GOLD SSH and ICMP from UH Sector** Inneholder ingress-regler
  (ingen egress-regler) som tillater trafikk fra alle nett som utgjør
  norsk UH-sektor.

Vi oppretter følgende security groups som gjøres tilgjengelig for alle
UiB-prosjekter (``org=uib``):

* **GOLD SSH and ICMP from all UiB** Inneholder ingress-regler
  (ingen egress-regler) som tillater trafikk fra alle nett som utgjør
  UiB-nettet.

* **GOLD SSH and ICMP from UiB Login Hosts** Inneholder ingress-regler
  (ingen egress-regler) som tillater trafikk login.uib.no

Vi oppretter følgende security groups som gjøres tilgjengelig for alle
Uio-prosjekter (``org=uio``):

* **GOLD SSH and ICMP from all UiO** Inneholder ingress-regler
  (ingen egress-regler) som tillater trafikk fra alle nett som utgjør
  UiO-nettet.

* **GOLD SSH and ICMP from UiO Login Hosts** Inneholder ingress-regler
  (ingen egress-regler) som tillater trafikk login.uio.no

* **GOLD Basic for UiO Managed** Inneholder ingress- og egress-regler
  som tillater kommunikasjon med UiO-tjenester som er nødvendig for
  drift av UiO Managed RHEL


Address Groups
--------------

Vi oppretter følgende address groups som gjøres tilgjengelig for alle
prosjekter:

* **Norwegian UH Sector**

* **UiO Networks**

* **UiB Networks**

* **UiO Login Hosts**

* **UiB Login Hosts**


Implementasjon
==============

Følgende må på plass for å implementere dette:

* Manuell deling av nye security groups til de prosjektene som skal ha
  dem, basert på bl.a. org-tilknytning

* ``project.py`` må oppdateres til å gjøre deling av korrekte
  secgroups ved opprettelse av nye prosjekter

* ``project.py`` må få ny funksjonalitet for å

  - dele secgroups til eksisterende prosjekter
  - sette tags
  - liste delinger basert på tags

* ``project.py`` må oppdateres til å slette delingen når et prosjekt slettes

* Dokumentere og informere brukerne
