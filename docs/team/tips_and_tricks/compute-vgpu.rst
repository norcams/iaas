===========
Setup vGPU 
===========

Compute-vgpu-42
---------------

Download and install Nvidia virtual GPU driver 

Update :file:`nova.conf`::

	cpu_mode=custom
	cpu_model=EPYC

	[devices]
	enabled_vgpu_types = nvidia-<num>

	[pci]
	passthrough_whitelist = {"address": "0000:<num>:00.0"}

Restart ``nova-compute``

Ensure that ECC is diabled on GPU

.. code:: bash

	nvidia-smi -q

Reboot

Download and install the Nvidia GRID RPM

.. code:: bash

	yum install NVIDIA-vGPU-rhel-7.6-418.66.x86_64.rpm

Download and run the Nvidia driver

.. code:: bash

	./NVIDIA-Linux-x86_64-418.66-vgpu-kvm.run

vGPU Flavor
-----------
Make sure that the flavor type has right properties

- aggregate_instance_extra_specs:type: s== vgpu

- resources:VGPU=1

Install Nvidia Driver on Centos 7.6
------------------------------------

Make sure NVIDIA is enabled

.. code:: bash

	lshw -numeric -C display 

.. code:: bash

	Output:
	$ *-display:1 UNCLAIMED
	description: VGA compatible controller
	product: NVIDIA Corporation [10DE:1EB8]
	vendor: NVIDIA Corporation [10DE]

Disable Nouveau driver 
Edit :file:`/etc/modprobe.d/blacklist.conf` file, and add ``blacklist nouveau``

Next create a new :file:`initramfs` file and taking backup of existing.

.. code:: bash

	mv /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r).img.bak  
	dracut -v /boot/initramfs-$(uname -r).img $(uname -r)

Edit :file:`/etc/default/grub` file, and add the ``nouveau.modeset=0`` into line starting with ``GRUB_CMDLINE_LINUX`` to ensure the next time you boot your VM, the Nouveau driver is disabled.

Apply the new GRUB configuration change

.. code:: bash

	sudo grub2-mkconfig -o /boot/grub2/grub.cfg

reboot

Next go to the folder where you have downloaded Nvidia driver and run the script. If any dependency, you need to install the required packages.

.. code:: bash

	yum groupinstall "Development Tools"
	yum install kernel-devel epel-release
	yum install dkms

Download and run the Nvidia driver

.. code:: bash

	./NVIDIA-Linux-x86_64-418.70-vgpu-kvm.run

If the :file:`/etc/nvidia/gridd.conf` file does not already exist, create it by copying the supplied template file :file:`/etc/nvidia/gridd.conf.template`.

Edit the :file:`/etc/nvidia/gridd.conf` file to set the ``EnableUI`` option to ``TRUE``
and edit ``ServerAddress`` to ``<licenseserver>``.

.. code:: bash

	sudo service nvidia-gridd start
