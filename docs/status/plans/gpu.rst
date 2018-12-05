====================
GPU Assisted Compute
====================

Last changed: 2018-10-01

There is a growing interest in GPU assisted compute resources. There are 
different alternatives as of how to offer such resources in UH-IaaS.


GPU vendors
===========

There are mainly three players in the GPU compute field - NVIDIA, AMD and Intel, the former
being the dominant player for now, the latter the latest to join. Performance wise NVIDIA has
the most performant GPUs. We have not considered AMD GPUs for now. Newer Intel Xeon E3 ***5 series
have an onboard GPU that can be used, however the performance of these GPUs compared to
NVIDIA of AMD is unknown to us for now.

NVIDIA enjoys the broadest software support, but many toolkits use hardware abstraction,
so it is unclear if software support is an issue.


PCI passthrough
===============

The traditional way of offering GPU resources in a virtual machine is by
PCI passthroughing a device and present it directly to the vm. This is certainly
doable and technically supported in OpenStack, but there severe caveats.

**pros**:

* High performance GPU for VMs, technically this can be cheap consumer grade video cards

**cons**:

* Some labour required pr card inserted in compute nodes
* Some labour required in each VM
* Does not scale very well - few VMs pr compute node
* For NVIDIA consumer grade cards it would violate their EULA - this is a **blocker**


Virtual GPU (vGPU)
==================

The preferred method is by the way of virtual GPUs, one GPU card is sliced into
several virtual GPUs served to many VMs. This scales well, and is supported by all three
GPU vendors. This feature is supported from the OpenStack Queens release as well. There are,
however, caveats.

**pros**:

* High performance GPU for VMs
* The preferred way to serve GPUs to virtual machines
* Trivial configuration in OpenStack
* Scales well, many VMs pr GPU

**cons**:

* At least for for NVIDIA this could be cost prohibitive, incurring 5-6x price/performance compared to consumer grade cards
* Additionally, for NVIDIA GPUs, a concurrent user licence fee is necessary


Looking forward
===============

The UH-IaaS team itself can not finance GPU assisted compute, not even for testing - at least for now,
and the hitherto interested parties have not provided any financial means to mitigate the fact.
There are a few things to consider looking forward, for example

* Xeon E3 CPUs with onboard GPUs could be worth considering as a test use case, or cheap HW GPUs for students
* We should investigate AMD GPUs as the price/performance ratio could be better compared to NVIDIA
