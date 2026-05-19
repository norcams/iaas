================================
Flavor for special compute hosts
================================

Has the SHPC-like properties:

- Local OS disk on hypervisor
- No overcommit on cores, ram and disk (=1.0)
- Pinned CPU cores to VMs
- Enabled static huge pages
- Disabled transparent huge pages
- VM provisioned on hypervisor based on trait (only) and/or aggregate instance extra specs

Atlas hardware and flavors class
--------------------------------

- 4 x osl-compute-[21-24] (128 vcpu, 512 GB RAM, 213 GB disk) - atlas.m1a

- 12 x osl-compute-[29-40] (192 vpu, 512 GB RAM, 213 GB disk) - atlas.c1a

- 4 x osl-compute-[069-072] (192 vpu, 768 GB RAM, 878 GB disk) - atlas3

RAM formulas
............

Total RAM: (hugepages x hugepagesz) MB

RAM/cores:

- atlas.m1a: 3840 MB

- atlas.c1a: 2560 MB

- robin.c1a: 1920 MB

- atlas3: 3925 MB

Flavor RAM:

Atlas1-2: (RAM per core) x cores - 2

Atlas3: floor ( 3925.33333333333333333333 * cores ) - 1 (if floor is odd)

Notes:
......

Atlas3 flavors: cores, ram and disk need to be even

How the flavors for atlas3 were made
....................................

1. Number of pinned / dedicated CPU cores are even (=cores)

2. Configure hypervisor with hugepagesz and hugepages

Example::

  Set a large hugepages size (hugepagesz): 2M (Mebibyte)

  Determine the number of hugepages (hugepages) according to total RAM specification (as from dmidecode) and a large enough (non-hugepages) RAM for OS:

  # hugepages = floor ( 1024 * ( total RAM GiB - OS RAM GiB) / hugepagesz MiB )
  # hugepages = floor ( 1024 * ( 768 * 32 ) / 2 ) = 376832

3. RAM used for hugepages should not be larger than the RAM available for VMs according to Placement (openstack resource provider inventory list <resource provider uuid>). In the example, the RAM used for hugepages will be: 1024 * ( 768-32 ) = 753664 Mebibyte, which is less than the MEMORY_MB max_unit 772785 Mebibyte reported from openstack resource provider inventory list <resource provider uuid>

4. Estimate RAM per core from the number from 3.: RAM per core = 753664/192 = 3925.33333333333333333333

5. Determine a set of flavors with even cores, like 32, 96 and 192

6. Flavor RAM: floor ( 3925.33333333333333333333 * cores ) - 1 (if floor is odd)

7. Find total disk available for flavors from Placement. In the example, the total avilable disk pace for flavors were: 877 Gigabyte.

8. Estimate disk per core similar to 4. : Disk per core = 877/192 = 4.56770833333333333333 Gigabyte

9. Flavor disk: floor ( 4.56770833333333333333 * cores) - 1 (if floor is odd)

10. Create flavors and verify full hypervisor utilization with the different flavor configurations using Terraform


Flavor specific configuration for atlas3:
.........................................

- himlar (hieradata/osl/roles/compute-atlas3.yaml)::

    profile::base::physical::hugepagesz:       '2M'
    profile::base::physical::hugepages:        '376832'

    ...

    nova::compute::cpu_dedicated_set:
      - '0-191'

- himlarcli (config/flavors/atlas3.yaml)::

    ---
    # https://iaas.readthedocs.io/team/tips_and_tricks/dedicated-flavors.html
    public: false
    properties: {}
    atlas3: {}

- himlarcli (config/flavors/atlas3-osl.yaml)::

    ---
    # https://iaas.readthedocs.io/team/tips_and_tricks/dedicated-flavors.html
    public: false
    properties:
      hw_rng:allowed: 'True'
      hw_rng:rate_bytes: 2048
      hw_rng:rate_period: 1
      hw:mem_page_size: 2048
      hw:cpu_policy: 'dedicated'
      hw:cpu_thread_policy: 'require'
      trait:CUSTOM_NREC_ATLAS3: 'required'
    atlas3:
      'atlas3.32-cores':
        vcpus: 32
        ram:   125610
        disk:  146
      'atlas3.48-cores':
        vcpus: 48
        ram:   188414
        disk:  218
      'atlas3.64-cores':
        vcpus: 64
        ram:   251220
        disk:  292
      'atlas3.96-cores':
        vcpus: 96
        ram:   376830
        disk:  438
      'atlas3.192-cores':
        vcpus: 192
        ram:   753662
        disk:  876

- OpenStack admin CLI::

    # Create custom trait
    openstack trait create CUSTOM_NREC_ATLAS3
    # Add trait to atlas3 hypervisors
    for uuid in $(openstack resource provider list -c name -c uuid -f value | grep atlas3 | awk '{print $1}')
    do
      openstack resource provider trait set --trait CUSTOM_NREC_ATLAS3 $uuid
    done
