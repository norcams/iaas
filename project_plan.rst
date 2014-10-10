====================
UH-sky IaaS platform
====================
Project plan and description

Descriptive summary
===================

This document describes what the IaaS project will develop and deliver. The project
aims to position IaaS as a common building block and vessel for future IT
infrastructure and services delivery in the academic sector.

The main project activity is developing, documenting and delivering an open
source IaaS platform ready for production use by June 15th 2015.

Additional activites that expands and builds on top of this platform are
described. These activites will need to be researched, discussed and specified
in greater detail before they can be put into action. The project plan sets
the earliest startup time for these activities to be February/March 2015.

The base IaaS platform will deliver these services:

- Compute
- Storage, 2 variants:
  - Block storage, accessible as virtual disks for compute instances
  - Object storage, accessible over the network as an API

Limitations
-----------

- The project will not deliver *traditional backup*. A common definition of
  backup state that backup data must be off-site, off-grid (e.g tape). A
  planned property of the storage system is to be able to select that an
  instance will be replicated to another location.
- The additional activites described are dependent on the base IaaS platform.
- Initial success criterias for the additional activities are described but
  no cost estimates (resources, budget) are given as part of this project plan.

Prerequisites
-------------

To be able to deliver the platform as described, on time, it is a requirement
that the project get access to the needed resources

- At least 3 people must work full-time (100%) with the main project activity
- No roles less than 50%
- If split roles are used, alternating blocks of at least 3 days continuous
  work hours must be with the project

The project will need at least 6 months from the *Locations complete* milestone
to delivery of the platform. This means that to deliver on time by 15th of June
2015 procurement of the needed hardware will need to be completed within 2014.
If hardware is delayed until 2015, the final delivery date will be delayed the
same amount of time, counting from August 15th 2015, as June and July are not
counted due to vacations. E.g, if *Locations complete* is reached in February
2015 final delivery will be 15th of October 2015.

Project goals and success criterias
===================================

The project will deliver a base IaaS platform to form a buildling block for
future IT infrastructure delivery in the academic sector.

The project has defined the following activities:

1. Develop, document and deliver a base IaaS platform
2. Integration of authentication and authorization
3. Further develop and verify services to cover 'traditional workloads'
4. Research and suggest a solution for PaaS
5. Research and suggest possible SaaS servics
6. Research and specify a consumer-focused self-service portal

Activities 1 and 2 have been passed by the UH-sky steering group in June 2014.

To describe the activities a format similar to user stories is used. The
stories share a common set of definitions

service
  The base IaaS platform, including all services layered below

user
  A person within the academic sector (with an identity record in FEIDE) given
  rights to administer instances and services on behalf of a tenant.

tenant
  An organization or unit within the Norwegian academic sector

administrator
  A person given responsibility and access to all the components of the
  service. This does not extend to access rights to the resources of a tenant.

small instance
  A compute instance defined as 1 vCPU, 4GB RAM, 10GB storage

large instance
  A compute instance defined as 4 vCPU, 16GB RAM, 100GB storage


1. Develop, document and deliver a base IaaS platform
-----------------------------------------------------

This is the main project activity.

- The service must deliver capacity for ~750 small instances or ~275 large
  instanecs with a total of 100tb accessible storage. This capacity should
  be equally divided across three geo-dispersed sites.

- The project must deliver a proof-of-concept PaaS solution able to offer three
  standardized development environments.

- The project must deliever proof-of-concept operation of at least one common
  service, in a SaaS-like model.

- The service must enable and document an expansion of the base platform to
  include (existing or new) HPC environments and workloads

- The service must deliver data that can be used for billing tenants. The data
  delivered must be usable to identify users, organizations and organization
  units.

- A user must be able to start an instance immediately after first login. The
  instance must be available within 60 seconds.

- A user must be able to create, update and delete instanes in the service from
  a graphical user interface in a browser, using an API or by using command
  line tools.

- A user must be able to select if an instance should have a persistent boot
  volume or not.

- A user must be able to assign and use more storage as needed, within a quota.
  Billing of storage must be per usage, not per quota.

- A user should be able to place or move an instance geographically across the
  available locations. The choice should be possible to make according to the
  users need for redundancy, resilience, geographical distance or other
  factors.

- A user should be able to choose that an instance is replicated to other
  locations automatically, thus potentially increasing protection against
  service outages.

- A user must be given the ability to monitor service performance and quality
  continuously.

- An administrator must use two-factor authentication for any access to the
  service for systems management and maintenance purposes.

- An administrator must be able to expand capacity, plan and execute
  infrastructure changes and fix errors in all parts of the service by using
  version-controlled code and automation. This key point should cover all
  operational tasks like discovery, deployment, maintenance, monitoring and
  troubleshooting.


2. Integration of authentication and authorization
--------------------------------------------------

- A user must be able to authenticate via FEIDE and be authorized as belonging
  to a tenant in the service

- Any FEIDE user passwords should NOT be stored in the service

Before the service can be used in a production scenario it is neccessary to
integrate central authentication and authorization. Users in the service must
be identified as belonging to an organizational entity with correct billing
information.

This activity must research and document a model and solution that shows how
user- and organization data from FEIDE (and other sources) can be integrated
to cover the needs of the service. The model must be detailed enough to make
it possible to estimate cost and resource constraints for the solution.

Limitations in the chosen solution and model must be described. Suggestions
and cost estimates for more advanced id/authN/authZ models, e.g users and
billing across organizational boundaries, must be discussed. An analysis and
assessment of integration with the UNINETT project *FEIDE Connect* should be
done as part of this.


3. Further develop and verify services to cover 'traditional workloads'
-----------------------------------------------------------------------

The base IaaS platform is planned to be built using OpenStack, a framework for
building modern scalable cloud-centric infrastructure. Traditional enterprise
workloads, defined as long-lived instances with critical data and state kept as
part of the boot filesystem, is not as easily integrated into this framework.
We believe a lot of our potential users would also like the service to cover
this class of workloads.

This activity integrates a solution tailored for traditional workloads with the
base IaaS platform. Openstack and its service APIs are used to unify the
solution so that the consumer side of the service is kept uniform. The solution
can make use of existing infrastructure at each site/location, possibly by
utilizing existing excess capacity, or later by expansion.

A key value proposition for this activity is to confirm and further develop the
requirement that any solution, knowledge and people working in the project are
part of a shared pool of resources. Existing systems and available free
capacity vary greatly between locations but this must not prevent or stop all
parties from participating.

Licensing is an important question that this activity must address.


4. Research and suggest a solution for PaaS
-------------------------------------------

There is a definite interest in PaaS as a concept in our communities. Earlier
discussions has revealed that it is very likely we would want to deliver some
form of PaaS solution on top of the IaaS platform. Today, from what we know,
only UNINETT and its internal Nova project has experience with PaaS as an
environment.

This activity must research and suggest a form and model for a PaaS service
delivered on top of the base IaaS platform. The suggested solution must be
described and cost must be estimated.


5. Research and suggest possible SaaS servics
---------------------------------------------

Several of the common IT services in the sector are already today delivered in
models that are close to SaaS. From our UH-sky viewpoint it is natural to look
at these services as possible future migrations to the IaaS platform. This
activity must actively approach the sector on multiple fronts to find use cases
and needs that could possibly fit in a SaaS model. Early examples of such
services could be software used in labs or classrooms. Is SPSS as a service
possible?


6. Research and specify a consumer-focused self-service portal
---------------------------------------------------------------

This activity will define goals to enable a uniform, consumer-focused,
self-service portal for all IaaS, PaaS (SaaS?) related services. A central
point for consuming the services is needed.

Functional aspects we'd need solved are

- Chargeback. Automatically generated billing based on usage.

- Support for several cloud and virt providers, both private and public

- Possibility for migrating workloads/instances and data between different
  infrastructure providers

- Overview and monitoring of allocated resources across providers

There are several products today that cover most if not all of the functional
aspects described. A central customer-focused portal should be developed using
one of them as a base. A development project formed around this activity will
be only loosely coupled to the IaaS project but we think it would be beneficial
to wait until the core functionality of the IaaS platform is in place.


Project milestones and scheduling
=================================

The following describes planned progress and possible startup dates for the
project activies

+------------------------------------------------------------+----------------+
| Activity                                                   | Date           |
+============================================================+================+
| Startup activity 1 and 2                                   | June 2014      |
+------------------------------------------------------------+----------------+
| *Minimum viable product*. Per activity 1, one of three     | October 2014   |
| physical sites installed and running.                      |                |
+------------------------------------------------------------+----------------+
| *Locations complete*. All sites up and running. No storage | December 2014  |
| or instance uptime guaranteed.                             |                |
+------------------------------------------------------------+----------------+
| *Functionally complete*. All functional goals completed    | February 2015  |
| and operative. No storage or instance uptime guaranteed.   |                |
+------------------------------------------------------------+----------------+
| *Incubation period*. Pre-production tuning, testing and    | Feb.-Jun. 2015 |
| verification. Early customers given access. Best effort    |                |
| storage consistency and instance uptime. Documenting any   |                |
| further development needed.                                |                |
+------------------------------------------------------------+----------------+
| *Project delivery*. Activites 1, 2 delivered as described. | 15.6.2015      |
+------------------------------------------------------------+----------------+

Resources and budgeting
=======================

*This part of the project plan is not public*


Project organization and management
===================================

The UH-sky steering group represents the top level project management

- 
