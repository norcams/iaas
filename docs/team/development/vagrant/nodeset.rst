.. |date| date::

=======
Nodeset
=======

Last changed: |date|

There are different sets of nodes to use in Vagrant. The node set can be
changed by setting the environment variable called :file:`HIMLAR_NODESET`.

Default nodeset
===============

The default nodeset uses the :file:`vagrant` location. Here we have added all the
important roles.::

  export HIMLAR_NODESET=default

Other nodeset
=============

There are also other special case nodeset. To see all nodeset and change them
edit :file:`$himlar/nodes.yaml`.
