=========================================
Proposal: Connect Educloud with NREC
=========================================

Last changed: 2023-08-24

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
up or down services.


Proposal
========

We propose that we make NREC a viable option for running Educloud
services. For this we need to solve the storage problem: NREC is
considered outside of Educloud and Educloud storage is not available
for NREC instances.

We can accomplish this with a few simple steps:

#. NREC creates an IPv6 subnet which is specifically tagged for
   Educloud usage. This will be a /64 within the NREC IPv6 range, and
   will be a different subnet in each of the regions

#. NREC creates a user selectable network called "Educloud" which
   contains the new IPv6 network and the default RFC1918 IPv4
   network. Only select NREC projects will able to select this
   network

#. Router ACLs in NREC are changed to allow NFS and SMB from Educloud

#. Router ACLs in UiO/Educloud are changed to allow NFS and SMB (and
   possibly GPFS?) between the new NREC-Educloud IPv6 range and
   Educloud

#. Agree to and set up a policy that describes how this should be
   used. Most notably, only select NREC projects managed by Educloud
   personnel will be able to use the "Educloud" IPv6 network in NREC,
   and any instances in these projects should be UiO-managed

#. On the UiO and Educloud side, define the NREC Educloud IPv6 network
   as a part of Educloud for all intents and purposes



