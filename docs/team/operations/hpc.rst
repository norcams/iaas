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

We have the following flavors for HPC workloads:

+------------------+----------+------+--------------------------------+
| Name             | RAM (GB) | vCPU | Properties                     |
+==================+==========+======+================================+
| alice.large      | 8        | 2    | type='s== alice'               |
|                  |          |      | hw_rng:allowed='True'          |
|                  |          |      | hw_rng:rate_bytes='1000000'    |
|                  |          |      | hw_rng:rate_period='60'        |
+------------------+----------+------+--------------------------------+
| alice.xlarge     | 16       | 4    | type='s== alice'               |
|                  |          |      | hw_rng:allowed='True'          |
|                  |          |      | hw_rng:rate_bytes='1000000'    |
|                  |          |      | hw_rng:rate_period='60'        |
+------------------+----------+------+--------------------------------+
| alice.2xlarge    | 24       | 8    | type='s== alice'               |
|                  |          |      | hw_rng:allowed='True'          |
|                  |          |      | hw_rng:rate_bytes='1000000'    |
|                  |          |      | hw_rng:rate_period='60'        |
+------------------+----------+------+--------------------------------+
| atlas.large      | 8        | 2    | type='s== atlas'               |
|                  |          |      | hw_rng:allowed='True'          |
|                  |          |      | hw_rng:rate_bytes='1000000'    |
|                  |          |      | hw_rng:rate_period='60'        |
|                  |          |      | hw:cpu_policy='dedicated'      |
|                  |          |      | hw:cpu_thread_policy='require' |
+------------------+----------+------+--------------------------------+
| atlas.xlarge     | 16       | 4    | type='s== atlas'               |
|                  |          |      | hw_rng:allowed='True'          |
|                  |          |      | hw_rng:rate_bytes='1000000'    |
|                  |          |      | hw_rng:rate_period='60'        |
|                  |          |      | hw:cpu_policy='dedicated'      |
|                  |          |      | hw:cpu_thread_policy='require' |
+------------------+----------+------+--------------------------------+
| atlas.2xlarge    | 24       | 8    | type='s== atlas'               |
|                  |          |      | hw_rng:allowed='True'          |
|                  |          |      | hw_rng:rate_bytes='1000000'    |
|                  |          |      | hw_rng:rate_period='60'        |
+------------------+----------+------+--------------------------------+
| atlascpu.2xlarge | 24       | 8    | type='s== atlas'               |
|                  |          |      | hw_rng:allowed='True'          |
|                  |          |      | hw_rng:rate_bytes='1000000'    |
|                  |          |      | hw_rng:rate_period='60'        |
|                  |          |      | hw:cpu_policy='dedicated'      |
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
