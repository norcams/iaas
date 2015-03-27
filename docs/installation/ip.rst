IP Addressing Plan
==================

We have 3 different subnets:

::

    x.x.x.x/27 oob
    x.x.x.x/27 mgmt
    x.x.x.x/24 cloud-public-addresses

mgmt ip allocation
------------------

::

    x.x.x.1  gw
    x.x.x.2  gw
    x.x.x.3  gw
    x.x.x.4  login-1
    x.x.x.5  foreman-1
    x.x.x.6  empty
    x.x.x.7  leaf-1
    x.x.x.8  leaf-2
    x.x.x.9  leaf-3
    x.x.x.10 leaf-4
    x.x.x.11 controller-1
    x.x.x.12 controller-2
    x.x.x.13 controller-3
    x.x.x.14 compute-1
    x.x.x.15 compute-2
    x.x.x.16 compute-3
    x.x.x.17 osd-1
    x.x.x.18 osd-2
    x.x.x.19 osd-3
    x.x.x.20 osd-4
    x.x.x.21 osd-5

cloud public address ip allocation
----------------------------------

::

    ### x.x.x.x/24 reservert for uh-sky
    # x.x.x.0/29 reservert nett-loopback
    x.x.x.0/32    - ledig
    x.x.x.1/32    leaf1
    x.x.x.2/32    leaf2
    x.x.x.3/32    leaf3
    x.x.x.4/32    leaf4
    x.x.x.5/32    - ledig
    x.x.x.6/32    - ledig
    x.x.x.7/32    - ledig
    # x.x.x.8/29  - ledig
    # x.x.x.16/28 - ledig
    # x.x.x.32/27 reservert nett-p2p
    x.x.x.32/30   leaf1 - leaf2
    x.x.x.36/30   leaf3 - leaf4
    x.x.x.40/30   leaf2 - leaf3
    x.x.x.44/30   - ledig
    x.x.x.48/30   - ledig
    x.x.x.52/30   - ledig
    x.x.x.56/30   - ledig
    x.x.x.60/30   - ledig
    # x.x.x.64/26 - ledig
    # x.x.x.128/25 reservert host-nett
    x.x.x.128/29 controller 1
    x.x.x.136/29 controller 2
    x.x.x.144/29 controller 3
    x.x.x.152/29 compute 1
    x.x.x.160/29 compute 2
    x.x.x.168/29 compute 3
    x.x.x.176/29 storage 1
    x.x.x.184/29 storage 2
    x.x.x.192/29 storage 3
    x.x.x.200/29 storage 4
    x.x.x.208/29 storage 5
    x.x.x.216/29 - ledig
    x.x.x.224/29 - ledig
    x.x.x.232/29 - ledig
    x.x.x.240/29 - ledig
    x.x.x.248/29 - ledig

All boxes, including network equipment, have a mgmt interface and an oob interface 
on two separate networks in addition to the cloud public network.
