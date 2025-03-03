Here is the text converted to RST format:

First, you need to enable MIG on the device before proceeding. There should be no vgpu allocations at this point.

To verify that MIG is enabled, run:
```
nvidia-smi -i DEVICE_ID -mig 1 (0 disables)
```
This command will check if the MIG mode is currently set to 1 or 0 (disable).

Next, you need to check which GPU profiles are available. Run:
```
nvidia-smi mig -lgip
```
to list all GPU profiles.

Run:
```
nvidia-smi mig -lgipp
```
to list only the profiles that do not have a +me suffix (these are for graphical support).

Once you have decided on the GPU profiles, initiate them using:
```
nvidia-smi mig -cgi ID(,ID2,ID3,ID4..)
```
Replace `ID` with the IDs of the GPU profiles you want to use.

To list all the profiles that have been initiated, run:
```
nvidia-smi mig -lgi
```

You can then apply these profiles using:
```
nvidia-smi mig -cci -gi INSTANCE-ID(,IID2,IID3,IID4..)
```
Replace `INSTANCE_ID` with the IDs of the instances that you want to use.

To list all vGPUs, run:
```
nvidia-smi -L
```

Next, check which mdev devices are available by running:
```
mdevctl types
```

To configure Nova with the available MDEV/VGPU profiles, add the following configuration:

```markdown
enabled_mdev_types=nvidia-476

#[mdev_nvidia-476]
#mdev_class = A100_3_20C
```

Note: In this example, `A100_3_20C` is used as an example mdev class. The actual value may vary depending on your specific use case.

To create a custom trait for the MDEV/VGPU profile using OpenStack:

1. Run:
```
openstack --os-placement-api-version 1.6 trait create CUSTOM_A100_3_20C
```

2. Use a loop to set this trait on all resources that you want to use with the custom VGPU profile:

```bash
for uuid in $(openstack resource provider list -c name -c uuid -f value | grep -E 'bgo-compute-vgpu-53.mgmt.bgo.uhdc.no_pci_0000_3b_01_(1|2)' | awk '{print $1}'); do     openstack --os-placement-api-version 1.28 resource provider trait set --trait CUSTOM_A100_3_20C  $uuid; done
```

3. Run:
```
openstack --os-placement-api-version 1.28 resource provider list --required  CUSTOM_A100_3_20C
```

This command will verify that the custom trait has been applied to all resources.

Note: Make sure to replace `CUSTOM_A100_3_20C` with your desired VGPU profile name and ID, as well as the actual values of the resource provider UUIDs in the loop.
