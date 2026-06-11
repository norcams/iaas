============
vGPU flavors
============

Current flavors:

* gr1.L40S.24g

Flavor names
============

The flavor class name is split into 3 blocks separated with a :file:`.`
The last 4. block of a flavor will always be the the size based on the number of
vCPU in the flavor.

Flavor class blocks:

* type (e.g. gr1)
* gpu (e.g. L40S)
* vram (e.g. 24g)

Type
----

The type for vGPU always starts with :file:`g` since this is a gpu accelerated flavor.
This is also the same as AWS with their :file:`g4` and :file:`g5` flavor.

The second letter will be the RAM to vCPU ration used by other flavors::

  r = 8 GB to 1 vCPU (ram)
  c = 2 GB to 1 vCPU (cpu)
  m = 4 GB to 1 vCPU (generic)

Last number is the generation in NREC. We always start on 1.

GPU
---

Unique name of the GPU used for this flavor. E.g. :file:`L40S` or :file:`H200`

VRAM
----

Amount of Video RAM for the instance in GB followed by a :file:`g`

Size
----

The size strings we use is also taken for AWS::

  medium  =  1 vCPU
  large   =  2 vCPU
  xlarge  =  4 vCPU
  2xlarge =  8 vCPU
  4xlarge = 16 vCPU
  ...
