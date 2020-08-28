===========
Setup vGPU
===========

This documents how to install and set upp a compute host with a vGPU capable
nVIDIA card and a corresponding guest running CentOS.

Prerequisites:

1. A license server offering an appropriate license to the guest(s)
   See `Virtual GPU Client Licensing User Guide <https://docs.nvidia.com/grid/latest/grid-licensing-user-guide>`_


2. A bundle containing both a grid (client) installation file and a vGPU manager
   installation file (compute host). Assume this file is located in `/tmp`.
   Note that it is important that client and host driver versions are in sync!
   Also make sure that the bundle version supports the pertinent compute host
   and guest OS releases.
   See the product support matrix ("Supported Products") for the relevant
   versions in the `NVIDIA® Virtual GPU (vGPU) Software Documentation <https://docs.nvidia.com/grid/>`_

   The 'Bundle Release' used in these examples, is *8.1*.
   Note that for vanilla Openstack on CentOS use generic Linux KVM bundle, NOT
   any of the "RHEL KVM" bundles!


Note that CUDA only supports certain vGPU "models" (that is: only a certain
limited set of vGPU profiles). See `1.6.2. NVIDIA CUDA Toolkit and OpenCL
Support on NVIDIA vGPU Software <https://docs.nvidia.com/grid/latest/grid-vgpu-user-guide/index.html#cuda-open-cl-support-vgpu>`_
together with `1.4.1. Virtual GPU Types <https://docs.nvidia.com/grid/latest/grid-vgpu-user-guide/index.html#virtual-gpu-types-grid>`_
in *nVIDIA vGPU Software Users Guide*.
Of interest is also `Virtual GPU Software R430 for Linux with KVM Release Notes
<https://docs.nvidia.com/grid/latest/grid-vgpu-release-notes-generic-linux-kvm>`_
and `NVIDIA CUDA Installation Guide for Linux <https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html>`_.

For notes about OpenStack/Nova configuration, see `Attaching virtual GPU
devices to guests <https://docs.openstack.org/nova/train/admin/virtual-gpu.html>`_.


vGPU compute host
-----------------

'Copy-n-paste' recipe
'''''''''''''''''''''

Set nVIDIA package (bundle) name and PCI ID (check with `lspci`):

.. code:: bash

    bundle=NVIDIA-GRID-Linux-KVM-418.109-426.26.zip   # adjust
    pci_id=0000\:21\:00.0                             # adjust

Execute installation steps:

.. code:: bash

    echo "blacklist nouveau" > /etc/modprobe.d/blacklist.conf
    echo "options nouveau modeset=0" >> /etc/modprobe.d/blacklist.conf
    dracut --force
    . /root/proxy.sh
    yum install -y wget unzip
    yum groupinstall -y "Development Tools"
    yum install -y kernel-devel epel-release
    yum install -y dkms
    yum update -y
    reboot
    (log back in)
    mkdir /root/md
    cd /root/md
    unzip /tmp/$bundle
    sh \*-vgpu-kvm.run -s --dkms
    reboot
    (log back in)
    ls /sys/class/mdev_bus/$pci_id/mdev_supported_types/
    #decide based on available types listed the desired profile

To correlate vGPU profiles under `/sys` with the tables in the nVIDIA
documentation, check content of the file ``name`` under each profile directory.
The profile name (`nvidia-<number>`) must then be set in hieradata and pushed to
production. After this the compute host is ready.

Manual activation (only for testing, requires disabling of puppet!):
Update :file:`nova.conf`::

	[devices]
	enabled_vgpu_types = nvidia-<num>

Restart ``nova-compute``

Up until (not including) nVIDIA Bundle Release family 9: Ensure that ECC is disabled on GPU
(mostly is by default).

.. code:: bash

	nvidia-smi -q

Otherwise, run

.. code:: bash

        nvidia-smi -g 0 --ecc-config=0

``nvidia [vgpu|-q]`` is a nice tool for debugging


vGPU Flavor
-----------
Make sure that the flavor type has right properties

- aggregate_instance_extra_specs:type: s== vgpu

- resources: VGPU=1


vGPU guest (instance) - CentOS 7
--------------------------------

Make sure nVIDIA GPU is enabled on the guest

.. code:: bash

	lshw -numeric -C display

.. code:: bash

	Output:
	$ *-display:1 UNCLAIMED
	description: VGA compatible controller
	product: NVIDIA Corporation [10DE:1EB8]
	vendor: NVIDIA Corporation [10DE]


copy-n-paste recipe
'''''''''''''''''''
Set package name and license server:

.. code:: bash

    bundle=NVIDIA-GRID-Linux-KVM-418.109-426.26.zip   # adjust
    licenseserver=licenseserver.host.dfqdn            # adjust

Execute installation steps:

.. code:: bash

    echo "blacklist nouveau" > /etc/modprobe.d/blacklist.conf
    echo "option nouveau.modeset=0" >> /etc/modprobe.d/blacklist.conf
    dracut --force
    yum -y install wget unzip
    yum -y install kernel-devel epel-release
    yum -y groupinstall "Development Tools"
    yum -y update
    reboot
    log back in
    mkdir /root/nvidia
    cd /root/nvidia
    unzip /tmp/$bundle
    sh \*-grid.run -s
    cd /etc/nvidia/
    cp gridd.conf.template  gridd.conf
    sed -i "s/^ServerAddress=/ServerAddress=$licenseserver/" gridd.conf
    sed -i 's/^#EnableUI=TRUE/EnableUI=TRUE/' gridd.conf
    reboot

