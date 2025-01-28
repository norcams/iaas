=============================
vGPU with SR-IOV capable GPUs
=============================

We use traits to ensure that placement doesn't allocate GPU resources
that doesn't exist on SR-IOV GPUs.

First, create the trait::

  openstack --os-placement-api-version 1.28 trait create CUSTOM_NREC_VGPU_L40S_24G

Find which resources providers we want to add the trait to::

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

Add the trait to the resource providers::

  for uuid in $(openstack resource provider list -c name -c uuid -f value | grep -E 'osl-compute-l40s-6(7|8).mgmt.osl.uhdc.no_pci_0000_(61|4a|e1|ca)_01_(1|2)' | awk '{print $1}'); do
      openstack --os-placement-api-version 1.28 resource provider trait set --trait CUSTOM_NREC_VGPU_L40S_24G $uuid
  done

The trait must be added to the flavor in the yaml file::

  trait:CUSTOM_NREC_VGPU_L40S_24G: 'required'
  

