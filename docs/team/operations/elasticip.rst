=============================
Elastic IP for NREC instances
=============================


Introduction
============

The networking model used in the NREC infrastructure prohibits the use of
the OpenStack Octavia project LBaaS (Load Balancing as a Service). The only
balancing and HA solution that has hitherto been available to users is to set up
an external load balancer, which for many users is not feasable. However,
the NREC infrastructure now supports the ability for instances to announce
IP prefixes via BGP peering to the networking infrastructure. This provides
the infrastructure for both load balancing and high availability for the
end user's workloads. Any BGP speaker will do as long as the software supports
a minimum of features (refer to the end user documentation at
https://docs.nrec.no/elasticip.html for details).

How it works
============

A pair of routers in each region have been equipped with loopback addresses
and firewall rules that allow instances to do BGP peering (normally all traffic
from instances to NREC infrastructure is immediately dropped on the compute host).
The router pair will typically be the same routers with the public uplinks (ie, spine)
The instances doing the peering can only do so if they are connected to a
specific neutron network ("Elastic IP"). The BGP peering happens over IPv4 only, but
IPv6 prefixes are announcable by default via BGP Multiprotocol.

Each project that needs access to this feature must be given the following
information, in addition to access to the Elastic IP neutron network, the NREC region
specific AS number, and the loopback IPv4 addresses to peer to:

* A 4 byte private AS number (unique pr project, range 4200000000 to 4294967294)
* md5 password for the BGP session
* An announcable IPv4 prefix
* An announcable IPv6 prefix

The above information must be configured on the NREC's mentioned router pair
in order for puppet to configure FRR to accept the MD5 bgp password, connections
and announcements.

Example config for a pair of FFR routers::

  frrouting::frrouting::bgp_neighbor_groups:
    'elastic_test':
      'options':
        - 'peer-group'
        - "remote-as 4200000000" # set in secrets
        - "password b1ecd7f662e6ff6ce03ab33626f92cfe" # set in secrets
        - 'soft-reconfiguration inbound'
        - 'ebgp-multihop'
        - 'bfd' # optional but recommended. Security group and extra config by user
      'options6':
        - 'neighbor elastic_test activate'
        - 'neighbor elastic_test soft-reconfiguration inbound'
      'bgp_listen_range':
        - "%{hiera('netcfg_elastic_cidr')}"
      'ip_access_list':
        - "192.168.100.100/32" # would be announced internally in a region
        - "129.177.31.100/31 le 32" # minimum 31 and maximum 32 prefix length
      'ip_access_list6':
        - "2001:700:200:916::4000/127 le 128"
        - "fc00::/64 le 128"

The NREC team can check if the users has configured the connections correctly
in the vtysh CLI interface in FRR, and check if prefixes are announced.

