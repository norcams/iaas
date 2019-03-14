=====================
 Ephemeral hostnames
=====================

For puppet to work and to know which node to configure we have cername
(or clientcert) be constructed the following way::

  <location>-<role>-<variant/subrole>-<id>

To make it easier to know what certname a node uses we also set the hostname
equal to the certname for all nodes.

When some nodes, e.g. compute, object or storage, change certname we need a way
to keep track of the node other than certname. All physical nodes have one
permanent name and mgmt IP that will follow the machine from start to end::

  <location>-<role>-<id>

This will be used for A and PTR records for mgmt as well.

When a node are used in a variant/subrole we use a CNAME to map the ephemeral
hostname to the permanent one. This will only be done in the location where
the subrole/variant is present and removed when no longer needed.


Physical naming
===============

When we add name tags to machines in the datacenter we use the permanent name::

  [<location>-]<role>-<id>

The location part can be omitted to save space.
