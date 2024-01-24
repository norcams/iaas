=========================================
Proposal: Connect Educloud with NREC
=========================================

Last changed: 2024-01-24

Background and Purpose
======================

Educloud has a need for a more flexible and scalable underlying
infrastructure for some of its services. Most notably user driven
services, in which Educloud personnel helps setting up services
created by users. These are mostly web services, for example an
application running in RShiny which is served via web.

Today, creating a new service within the Educloud infrastructure is
cumbersome and time consuming, and does not allow any flexibility.

With this proposal implemented, Educloud admins can easily use tools
such as Terraform to install, delete virtual machines, e.g. to scale
up or down services. Educloud will be able to use all of the NREC
infrastructure (both regions, lightweigth HPC, GPU etc.).


Implementation
==============

We want to make NREC a viable option for running Educloud
services. For this we need to solve the storage problem: NREC is
considered outside of Educloud and Educloud storage is not available
for NREC instances.

The following has been implemented:

#. NREC has created an IPv6 subnet which is specifically tagged for
   Educloud usage. This will be a /64 within the NREC IPv6 range, and
   will be a different subnet in each of the regions

#. NREC has created a user selectable network called "Educloud" which
   contains the new IPv6 network and the default RFC1918 IPv4
   network. Only select NREC projects will able to select this
   network.

These networks are:

* OSL:

  - IPv6: ``2001:700:2:8204::/64``
  - IPv4: ``10.4.0.0/20``

* BGO:

  - IPv6: ``2001:700:2:8304::/64``
  - IPv4: ``10.3.0.0/20``

TODO
====

#. Router ACLs in NREC are changed to allow NFS and SMB from Educloud

#. Router ACLs in Educloud are changed to allow NFS and SMB between
   the new NREC-Educloud IPv6 range and Educloud.

   Comment: this will also include traffic to the Active Directory
   domain controllers in Educloud, and probably also some more
   services.

#. On the UiO and Educloud side, define the NREC Educloud IPv6 network
   as a part of Educloud for all intents and purposes.


Policy
======

This is a short description of the policy dictating how the Educloud
networks NREC should be used.

* The network **educloud1** is not publicly available to NREC projects

* Access to the **educloud1** network will be given to projects that
  are completely owned and managed by Educloud personnel. These
  project should never include members that are regular Educloud
  users. Regular Educloud users should not have access to these
  projects via NREC

* All instances in the Educloud projects should be managed as any
  other server within the Educloud realm


What does this mean in practice?
================================

When this is implemented, Educloud personnel may use NREC as a backend
service to run servers and services within the Educloud realm. There
should be no difference between running an Educloud server on Vmware
or on NREC.
