=============
Node overview
=============

**node = a virtual machine running on a physical controller box with libvirt**

This overview shows the different nodes, which network the nodes have access to
and where the Openstack and other services are running.

.. image:: images/nodes.png
   :target: ../_images/nodes.png

.. WARNING::
   The following is under construction!

New stuff:

Physical hardware
-----------------

.. image:: images/physical-hardware.png

Virtual nodes
-------------

.. image:: images/controllers-and-nodes.png

There are 4 physical controller hosts. These are servers with lots of
CPU and memory, and are used to run virtual machines, which we call
"nodes". Some of the nodes have a purely administrative purpose, some
provide internal infrastructure services, and some are OpenStack
components.

Some nodes are scaled out horizontally, mostly this applies on
OpenStack services. This is done for efficiency and redundancy
reasons.

List of nodes
-------------

+-------------------------+------------------------------------------+
| NODE                    | COMMENT                                  |
+=========================+==========================================+
| <loc>-proxy-01          | FIXME                                    |
+-------------------------+------------------------------------------+
| <loc>-novactrl-01       | FIXME                                    |
+-------------------------+                                          |
| <loc>-novactrl-01       |                                          |
+-------------------------+                                          |
| <loc>-novactrl-01       |                                          |
+-------------------------+------------------------------------------+
| <loc>-image-01          | FIXME                                    |
+-------------------------+------------------------------------------+
