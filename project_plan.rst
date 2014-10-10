UH-sky IaaS platform
Project plan and description

Summary

This plan describes what the IaaS project will develop and deliver. The project
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

- The project will not deliver *traditional backup*. A common definition of
  backup state that backup data must be off-site, off-grid (e.g tape). A
  planned property of the storage system is to be able to select that an
  instance will be replicated to another location.
- The additional activites described are dependent on the base IaaS platform.
- Initial success criterias for the additional activities are described but
  no cost estimates (resources, budget) are given as part of this project plan.

Prerequisites

To be able to deliver the platform as described, on time, it is a requirement
that the project get access to the needed resources

- At least 3 people must work full-time (100%) with the main project activity
- No roles less than 50%
- If split roles are used, alternating blocks of at least 3 days continuous
  work hours must be with the project

The project will need at least 6 months from the *Locations complete* milestone
to delivery of the platform. This means that if delivery is to be complete by
15th of June 2015 procurement of the needed hardware will need to be completed
within 2014. If hardware is delayed until 2015, the final delivery date will be
delayed the same amount of time, counting from August 15th 2015, as June and
July are not counted due to vacations. E.g, if *Locations complete* is reached
in February 2015 final delivery will be 15th of October 2015.

Project goals and success criterias

The project will deliver a base IaaS platform to form a buildling block for
future IT infrastructure delivery in the academic sector.

The project has defined the following activities:

1. (main) Develop, document and deliver a base IaaS platform
2. Integration of authentication and authorization
3. Further develop and verify services to cover 'traditional workloads'
4. Research and suggest a solution for PaaS
5. Research and suggest possible SaaS servics
6. Research and specify a consumer-focused self-service portal

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


Activity specifications

1 (main) Develop, document and deliver a base IaaS platform

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


























