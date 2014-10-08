dev hardware specification
==========================
(draft)

The project will deliver a geo-distributed iaas service across (at least) three
locations.

A key point is that each location is built from the same specification. This is
done to simplify and limit influence of external variables as much as possible.

Networking
----------

4 L3 switches

- Will be connected as routed leaf-spine fabric (OSPF)
- Each with at least 48 ports 10gb SFP+ / 4 ports 40gb QSFP
- Swithces that support ONIE/OCP preferred

1 management switch (L2)

- 48 ports 1GbE, VLAN support
- Remote management possible

48 10GBase-SR SFP+ tranceivers

8  40GBase-SR4 QSFP+ tranceivers

Servers
-------

3 management role

- 1u 1x12 core with 128gb RAM
- 2x SFP+ 10gb and 2x 1gbE
- 2x SSD drives
- Room for more disks

3 compute role

- 1u 2x12 core with 512Gb RAM
- 2x SFP+ 10Gb and 2x 1GbE
- 2x SSD drives
- Room for more disks

5 storage role

- 2u 1x12 core with 128gb RAM
- 2x SFP+ 10Gb and 2x 1GbE
- 8x 3.5" 2tb SATA drives
- 4x 120gb SSD drives
- Room for more disks

