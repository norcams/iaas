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

The following illustration show the physical hardware, in broad
terms. The number of compute hosts and storage hosts is horizontally
scalable and will vary from region to region.

.. image:: images/physical-hardware.png

The illustration shows these types of physical components:

**Management switch**
  Network ethernet switch used for internal networking,
  i.e. non-routed RFC1918 addresses. These are only used for
  management tasks.

**Public switch**
  A switch that has access to Internet. These switches also perform
  layer 3 routing, and are used to provide access to the public
  services in UH-IaaS.

**Controller hosts**
  Servers that are running virtual machines manually with libvirt
  (i.e. not managed by OpenStack). All OpenStack components such as
  the dashboard, API services etc. are running as virtual machines on
  these hosts.

**Compute hosts**
  Servers that are used as compute hosts in OpenStack. Customer's
  virtual machines are running on these servers.

**Storage hosts**
  Servers that are part of the Ceph storage cluster. They provide
  storage services to OpenStack (e.g. storage volumes).

Virtual machines
----------------

The illustration below shows the various virtual machines running on
the controller hosts.

.. image:: images/controllers-and-nodes.png
   :target: ../_images/controllers-and-nodes.png

Some of the virtual machines have a purely administrative purpose,
some provide internal infrastructure services, and some are running
OpenStack components.

Some virtual machines are scaled out horizontally, typically one on
each controller host, mostly this applies on OpenStack services. This
is done for efficiency and redundancy reasons.

List of virtual machines:

+-------------------------+------------------------------------------+
| NODE                    | COMMENT                                  |
+=========================+==========================================+
| <loc>-proxy-01          | FIXME                                    |
+-------------------------+------------------------------------------+
| <loc>-novactrl-01       | FIXME                                    |
+-------------------------+                                          |
| <loc>-novactrl-02       |                                          |
+-------------------------+                                          |
| <loc>-novactrl-03       |                                          |
+-------------------------+------------------------------------------+
| <loc>-image-01          | FIXME                                    |
+-------------------------+------------------------------------------+
| <loc>-ns-01             | Autoritative DNS server                  |
+-------------------------+------------------------------------------+
| <loc>-resolver-01       | Resolving (caching) DNS servers. These   |
+-------------------------+ servers are running in a redundant setup |
| <loc>-resolver-02       | via the Anycast protocol.                |
+-------------------------+------------------------------------------+
