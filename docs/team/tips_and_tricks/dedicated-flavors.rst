================================
Flavor for special compute hosts
================================

Atlas compute nodes
-------------------
- 6x osl-compute-[11-16] (128 vcpu, 512 GB RAM, 176 GB disk) - m1a

- 4x osl-compute-[21-24] (128 vcpu, 512 GB RAM, 213 GB disk) - m1a

- 12x osl-compute-[29-40] (192 vpu, 512 GB RAM, 213 GB disk) - c1a

RAM
...

Total RAM: (hugepages x hugepagesz) MB

RAM pr vCPU:

- atlas.m1a: 3840 MB

- atlas.c1a: 2560 MB

- robin.c1a: 1920 MB

Flavor RAM: (RAM pr vCPU) x (vCPU) - 2
