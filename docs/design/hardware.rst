Development hardware requirements
=================================

A key point is that each location is built from the same hardware
specification. This is done to simplify and limit influence of external
variables as much as possible while building the base platform.

The spec represents a minimal baseline for one site/location.

Networking
----------

4x Layer 3 routers/switches

- Connected as routed leaf-spine fabric (OSPF)
- At least 48 ports 10gb SFP+ / 4 ports 40gb QSFP
- Support for ONIE/OCP preferred

1x L2 management switch

- 48 ports 1GbE, VLAN capable
- Remote management possible

Cabling and optics

- 48x 10GBase-SR SFP+ tranceivers
- 8x 40GBase-SR4 QSFP+ tranceivers
- 4x QSFP+ to QSFP+, 40GbE passive copper direct attach cable, 0.5 meter
- 4x 3 or 5 meter QSFP+ to QSFP+ OM3 MTP fiber cable

Servers
-------

3x management nodes

- 1u 1x12 core with 128gb RAM
- 2x SFP+ 10gb and 2x 1gbE
- 2x SSD drives RAID1
- Room for more disks
- Redundant PSUs

3x compute nodes

- 1u 2x12 core with 512Gb RAM
- 2x SFP+ 10Gb and 2x 1GbE
- 2x SSD drives RAID1
- Room for more disks
- Redundant PSUs

5x storage nodes

- 2u 1x12 core with 128gb RAM
- 2x SFP+ 10Gb and 2x 1GbE
- 8x 3.5" 2tb SATA drives
- 4x 120gb SSD drives
- No RAID, only JBOD
- Room for more disks (12x 3.5" ?)
- Redundant PSUs

Comments

- Management and compute nodes could very well be the same chassis with different specs.
  Possibly even higher density like half width would be considered, but not blade chassis (it would mean non-standard cabling/connectivity)
- Important key attribute for SSD drives is *sequential write performance*. SSDs might be PCIe connected.
- 2tb disks for storage nodes to speed up recovery times with Ceph
