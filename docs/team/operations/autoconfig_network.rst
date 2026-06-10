Network autoconfig
==================

Automatic configuration of network interfaces for configuring interfaces
(including bonds and VLAN ifs), routes, routing tables, and rules for
NetworkManager enabled nodes (it also work for old el8).

This mechanism triggers if :file:`network::interfaces_hash` is not defined.

For nodes **not** automatically provisioned, routes and rules
**must** now be defined in the respective interfaces hashes, typically
in the node file.

For nodes with public IP (e.g. api, dashboard) we will always need to
create :file:`network::interfaces_hash` in the node config yaml file.

Config hashes for autoconfig must be created on pr role basis::

    profile::base::network::nm_auto_routes
    profile::base::network::nm_auto_opts
    profile::base::network::nm_network_auto_bonding
    network::routing::table::tables
    profile::network::interface::create_custom_routes


The configuration hashes typically follows the internal logic in the
NetworkManager system connection files. At the end, the configuration
files are handled by the new puppet network module.

Example hashes for automatic configuration (region test01 for compute role):

  .. code-block:: yaml

    network::routing::table::tables:
      'private':
        'table_id':  '240'

    named_interfaces::config: # no change here, just for context of this example
      mgmt:
        - p1p1
      trp:
        - bond0
      live:
        - bond0.120

    profile::base::network::nm_auto_routes:
      trp:
        ipv4:
          route1: '0.0.0.0/0,172.30.0.26'
          route1_options: 'table=240'
          routing-rule1: "priority 5 from %{hiera('netcfg_priv_network')} lookup 240"
          route2: "%{hiera('netcfg_priv_anycast_net')}/%{hiera('netcfg_priv_anycast_cidr4')},%{hiera('netcfg_trp_gateway')}"
          route2_options: 'table=240'
          routing-rule2: "priority 5 from %{hiera('netcfg_elastic_cidr')} lookup 240"
          route3: "0.0.0.0/0, %{hiera('netcfg_trp_gateway')}"
        ipv6:
          route1: '::/0,fd00::701'

    profile::base::network::nm_auto_opts:
      mgmt:
        ipv4:
          'never-default': 'true'
          'dns': "%{hiera('netcfg_dns_trp_server1')};%{hiera('netcfg_dns_mgmt_server1')};" # FIXME; define in common/roles/compute
      trp:
        ipv6init: 'yes' # NOTE: this is not NM syntax, rather interface.pp config
        bond:                          # Teaming driver is no longer available
          mode: '802.3ad'              # the best and only supported mode with existing network config
          xmit_hash_policy: 'layer3+4' # please use this hash policy
        ethernet:
          mtu: '9000'
      live:
        ipv4:
          'never-default': 'true'

    profile::base::network::nm_network_auto_bonding:
      trp:
        em1:
          ethernet:
            'mtu': '9000' # the MTU size must be set also on the slave interfaces
        em2:
          ethernet:
            'mtu': '9000'

===============
Troubleshooting
===============

Wrong IP on mgmt
----------------

Most likely caused by wrong interfaces name in :file:`named_interfaces::config`. This is often
defined in the role or variation config. To check if there is a mismatch check
:file:`/etc/facter/facts.d/named_interfaces.yaml` and compare to the interface name on the node.

No config files created
-----------------------

After a puppet run the NM config files are not created. This might be related to missing or
wrong DNS records in :file:`<loc>/common.yaml`.
