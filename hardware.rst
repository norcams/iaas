dev hardware specification
==========================
(draft)

The project will deliver a geo-distributed iaas service across (at least) three
locations. A key point is that each location is built from the same specification. This is
done to simplify and limit influence of external variables as much as possible.

The spec represents a minimal baseline.

Networking
----------

4x L3 switches

- Will be connected as routed leaf-spine fabric (OSPF)
- Each with at least 48 ports 10gb SFP+ / 4 ports 40gb QSFP
- Swithces that support ONIE/OCP preferred

1x L2 management switch

- 48 ports 1GbE, VLAN
- Remote management possible

48x 10GBase-SR SFP+ tranceivers

8x  40GBase-SR4 QSFP+ tranceivers

Servers
-------

3x management nodes

- 1u 1x12 core with 128gb RAM
- 2x SFP+ 10gb and 2x 1gbE
- 2x SSD drives RAID1
- Room for more disks

3x compute nodes

- 1u 2x12 core with 512Gb RAM
- 2x SFP+ 10Gb and 2x 1GbE
- 2x SSD drives RAID1
- Room for more disks

5x storage nodes

- 2u 1x12 core with 128gb RAM
- 2x SFP+ 10Gb and 2x 1GbE
- 8x 3.5" 2tb SATA drives
- 4x 120gb SSD drives
- No RAID, only JBOD
- Room for more disks (12x 3.5" ?)


Comments:
- 2tb disks for storage nodes to speed up recovery times with Ceph
