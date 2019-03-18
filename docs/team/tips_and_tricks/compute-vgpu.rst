=======================
Setup compute vgpu node 
=======================

Download and install Nvidia virtual GPU driver.

Update nova.conf

- cpu_mode=custom
- cpu_model=EPYC

- [devices]
- enabled_vgpu_types = nvidia-<num>

- [pci]
- passthrough_whitelist = {"address": "0000:<num>:00.0"}

Restart nova-compute.

Ensure that ECC is diabled on GPU.
- nvidia-smi -q
Reboot.