.. |A| image:: /images/16x16_yes.png
.. |O| image:: /images/16x16_no.png
.. |I| image:: /images/16x16_warning.png

======================================
HPC Compute nodes setup and management
======================================


Hypervisor hardware
===================

* 2x AMD EPYC 7551 32-Core Processor
* 512 GB RAM

These hosts have 8 NUMA nodes::

  # numactl -H
  ...
  node distances:
  node   0   1   2   3   4   5   6   7 
    0:  10  16  16  16  28  28  22  28 
    1:  16  10  16  16  28  28  28  22 
    2:  16  16  10  16  22  28  28  28 
    3:  16  16  16  10  28  22  28  28 
    4:  28  28  22  28  10  16  16  16 
    5:  28  28  28  22  16  10  16  16 
    6:  22  28  28  28  16  16  10  16 
    7:  28  22  28  28  16  16  16  10 



Flavors
=======

All flavors have the following properties::

  hw_rng:allowed='True'
  hw_rng:rate_bytes='1000000'
  hw_rng:rate_period='60'

In addition, we have set a type (either "alice" or "atlas")::

  type='s== alice'

We have the following flavors for HPC workloads:

+------------------+----------+------+--------------------------------+
| Name             | RAM (GB) | vCPU | Properties                     |
+==================+==========+======+================================+
| alice.large      | 8        | 2    |                                |
+------------------+----------+------+--------------------------------+
| alice.xlarge     | 16       | 4    |                                |
+------------------+----------+------+--------------------------------+
| alice.2xlarge    | 24       | 8    |                                |
+------------------+----------+------+--------------------------------+
| atlas.large      | 8        | 2    | hw:cpu_policy='dedicated'      |
|                  |          |      | hw:cpu_thread_policy='require' |
+------------------+----------+------+--------------------------------+
| atlas.xlarge     | 16       | 4    | hw:cpu_policy='dedicated'      |
|                  |          |      | hw:cpu_thread_policy='require' |
+------------------+----------+------+--------------------------------+
| atlas.2xlarge    | 24       | 8    |                                |
+------------------+----------+------+--------------------------------+
| atlascpu.2xlarge | 24       | 8    | hw:cpu_policy='dedicated'      |
|                  |          |      | hw:cpu_thread_policy='require' |
+------------------+----------+------+--------------------------------+


Hypervisor OS
=============

The following parameters is set via the grub boot loader, in
``/etc/sysconfig/grub``::

  hugepagesz=2M
  hugepages=245760
  transparent_hugepage=never
  isolcpus=4-127


Nova configuration
==================

Only configuration that is special or relevant to the HPC compute
nodes.

On **novactrl** hosts::

  enabled_filters=...,NUMATopologyFilter,...

On **compute** hosts::

  vcpu_pin_set="4-127"
  reserved_host_memory_mb=4096
  cpu_allocation_ratio=1
  ram_allocation_ratio=1.5
