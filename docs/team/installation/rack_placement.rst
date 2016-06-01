Placement of equipment in racks
===============================

We are installing the equipment in two separate racks to provide for easier
future expansion.

Installation guide
------------------

The six controller and compute nodes are installed in rack 1, the five storage
nodes in the other. Each rack has a pair of layer 3 capable switches at the
top. There is only a single management switch, a the top of rack 1, but if
expanding the setup we'll have one management switch in each rack.

.. image:: images/rack_two.png


Single rack installation (not used)
-----------------------------------

We also documented an optional single rack installation setup. In this setup
the physical boxes outlined in red are connected to routers loc-leaf-03 and 04.

We decided not to use this setup because all the sites got enough space for two
racks.

.. image:: images/rack_single.png

