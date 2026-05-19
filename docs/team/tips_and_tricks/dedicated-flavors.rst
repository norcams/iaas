================================
Flavor for special compute hosts
================================

Has the SHPC-like properties:

- Local OS disk on hypervisor
- No overcommit on cores, ram and disk (=1.0)
- Pinned CPU cores to VMs
- Enabled static huge pages
- Disabled transparent huge pages

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

Example:

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

