.. |date| date::

=======
Nodeset
=======

Last changed: |date|

There are different sets of nodes to use in vagrant. The node set can be
changed by setting the environment variable called :file:`HIMLAR_NODESET`.

Default nodeset
===============

The default nodeset uses the :file:`vagrant` location. Here we have added all the
important roles into one node called :file:`vagrant-api-01`. The reset of the
nodes are optional (like dashboard, access and compute).

Full nodeset
============

The full nodeset uses the :file:`dev` location. Here all roles have nodes
matching the test and production locations. This will require more resources
on the vagrant host (16GB+ RAM, 4+ Cores). To use the full nodeset::

  export HIMLAR_NODESET=full

Other nodeset
=============

There are also other special case nodeset. To see all nodeset and change them
edit :file:`$himlar/nodes.yaml`.
