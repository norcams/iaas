=========================================
Configuring vGPU with SR-IOV capable GPUs
=========================================

Currently, newer Single Root IO Virtualization (SR-IOV) capable GPUs such as Nvidia L40s, are installed in NREC/OpenStack Zed in the following way (2026-05-22):

- The Nvidia driver version needs to be supported by NVidia for the current Linux kernel version of AlmaLinux. NREC has its own nrec-nonfree repository that provides the correct driver from the package NVIDIA-vGPU-rhel.x86_64
- Enabled VT-d (Intel) or IOMMU (AMD) in BIOS
- Set OpenStack to use VT-d (Intel) or IOMMU (AMD). For instance, for Intel, the config line in hieradata that enables VT-d is: profile::openstack::compute::pci_passthrough::configure_intel_iommu: true
- Make sure the GPU driver creates Virtual Functions (VFs). The NVidia SR-IOV capable driver provides a tool for this in /usr/lib/nvidia/sriov-manage. There is a one-shot systemd service called create-nvidia-mdev.service that will run /usr/lib/nvidia/sriov-manage -e ALL on startup, which should create the VFs. This service is installed with the hieradata config line: profile::openstack::compute::nvidia_vgpu_createmdev::enable: true
- OpenStack Zed accesses vGPU resources using the legacy mediated device (mdev). From Linux kernel 5.16 and newer, OpenStack will instead use native SR-IOV VFs (See: https://specs.openstack.org/openstack/nova-specs/specs/2025.1/implemented/enable-vfio-devices-with-kernel-variant-drivers.html). Until then, when detecting a vGPU resource as mdev, OpenStack will create a resource provider. Running sriov-manage -e ALL to create VFs should also create mdevs. If this is not the case, a workaround seems to reinstall the NVidia driver (dnf reinstall NVIDIA-vGPU-rhel.x86_64), followed by a reboot. mdevs (mdevctl list) and vGPU resource providers should then be apparent.
- The Virtual Functions provided by the SR-IOV driver are Virtual Function IO devices. The SR-IOV driver provides vfio linux kernel modules. The modules can be seen from lsmod | grep nvidia
- OpenStack will create resource providers (uuids) of all possible vGPU configurations, linked to the PCIe address of the physical GPU + virtual index based on the VF + mdev VRAM size (TODO: clarify more / revise)
- vGPU flavor needs to use a specific mdev type. Select which type to use from the list from mdevctl types. The mdev type(s) to use needs to be set in hieradata using nova::compute::mdev::mdev_types:
- Placement provisions the vGPU resource based on resource provider trait. This requires the following setup::

1. Create the trait::

     openstack --os-placement-api-version 1.28 trait create CUSTOM_NREC_VGPU_L40S_24G

2. Find which resource providers we want to add the trait to. These have to be the correct SR-IOV Virtual Function (VF) PCIe addresses according to the selected GPU mediated device (mdev) type and vGPU flavor confiugration::

     $ openstack resource provider list -c name -c uuid -f value | grep -E 'osl-compute-l40s-6(7|8).mgmt.osl.uhdc.no_pci_0000_(61|4a|e1|ca)_01_(1|2)'
     6f258839-9288-47ec-a1ea-be1237c0bd0b osl-compute-l40s-67.mgmt.osl.uhdc.no_pci_0000_ca_01_1
     bd5fd3f2-6935-4daa-bb7f-09336a4e45f4 osl-compute-l40s-67.mgmt.osl.uhdc.no_pci_0000_e1_01_1
     006db0df-e087-4437-a525-abc6d31291e2 osl-compute-l40s-67.mgmt.osl.uhdc.no_pci_0000_e1_01_2
     2f32a4e6-4963-40e9-ac69-7ebd46543014 osl-compute-l40s-67.mgmt.osl.uhdc.no_pci_0000_4a_01_1
     02cebf5d-3a50-47a6-9bd2-0a1a650b3237 osl-compute-l40s-67.mgmt.osl.uhdc.no_pci_0000_61_01_2
     248783e3-d8dd-47f1-8179-1a1e4f1c83d9 osl-compute-l40s-67.mgmt.osl.uhdc.no_pci_0000_4a_01_2
     8a135f13-6a6a-4434-ae36-b76beae25c56 osl-compute-l40s-67.mgmt.osl.uhdc.no_pci_0000_ca_01_2
     0c5d79fb-f83a-4609-b11c-7bddf962c673 osl-compute-l40s-67.mgmt.osl.uhdc.no_pci_0000_61_01_1
     80fd0701-da9d-47a0-a19a-c2cd0725fa66 osl-compute-l40s-68.mgmt.osl.uhdc.no_pci_0000_61_01_1
     0c19f56e-dc68-4f63-846f-42d109141b01 osl-compute-l40s-68.mgmt.osl.uhdc.no_pci_0000_4a_01_2
     77b0a84c-b75a-498b-b5cc-e90716427479 osl-compute-l40s-68.mgmt.osl.uhdc.no_pci_0000_ca_01_2
     615b0b2a-9161-4e41-b343-034fda99cd13 osl-compute-l40s-68.mgmt.osl.uhdc.no_pci_0000_4a_01_1
     32715e33-ad8b-4170-8524-8e09d4e69f16 osl-compute-l40s-68.mgmt.osl.uhdc.no_pci_0000_61_01_2
     5c3844f8-3263-40f4-926e-735fdaf6f23e osl-compute-l40s-68.mgmt.osl.uhdc.no_pci_0000_ca_01_1
     a26fc9ce-8f62-4672-92e6-5e6fe22c130c osl-compute-l40s-68.mgmt.osl.uhdc.no_pci_0000_e1_01_1
     3e9fb1ca-0cf7-4971-8d56-dcbcfb379eb1 osl-compute-l40s-68.mgmt.osl.uhdc.no_pci_0000_e1_01_2

3. Add the trait to the resource providers::

     for uuid in $(openstack resource provider list -c name -c uuid -f value | grep -E 'osl-compute-l40s-6(7|8).mgmt.osl.uhdc.no_pci_0000_(61|4a|e1|ca)_01_(1|2)' | awk '{print $1}'); do
         openstack --os-placement-api-version 1.28 resource provider trait set --trait CUSTOM_NREC_VGPU_L40S_24G $uuid
     done

4. The trait must be added to the flavor in the yaml file::

     trait:CUSTOM_NREC_VGPU_L40S_24G: 'required'

How vGPU memory is configured for vGPU flavors
----------------------------------------------

This will probably change when OpenStack stops using mdevs

- Select a mdev type from the list given from mdevctl types, with the appropriate framebuffer=*M. framebuffer is VRAM
- Allow Nova to use the mdev type. Configure this either in the hypervisor node file or compute role
- Find out which resource providers that need the VGPU trait in order to fully utilize all vGPU resources (see above)
- Add the trait to the resource providers (see above)

Some commands that may be needed at the various steps are: restarting nova, flavor.py update <flavor class>
