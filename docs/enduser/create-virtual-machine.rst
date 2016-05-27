.. |date| date::

Create a Linux virtual machine
==============================

Last changed: |date|

.. contents::


Setting up a keypair
--------------------

Virtual machines in UH-IaaS are accessed using SSH keypairs. There are
numerous ways to achieve this, depending on the OS on your local
computer.


Importing an existing key
~~~~~~~~~~~~~~~~~~~~~~~~~

If the local computer is Linux, any BSD variant such as
FreeBSD, or MacOSX, the easiest way is to create a keypair locally if
you don't already have one::

  $ ssh-keygen 
  Generating public/private rsa key pair.
  Enter file in which to save the key (/home/username/.ssh/id_rsa): 
  Enter passphrase (empty for no passphrase): 
  Enter same passphrase again: 
  Your identification has been saved in /home/username/.ssh/id_rsa.
  Your public key has been saved in /home/username/.ssh/id_rsa.pub.
  The key fingerprint is:
  SHA256:UrFhPtth14+S9f8BzMHsy+KbAZJMoC1s+8nHh9UDIc4 username@example.org
  The key's randomart image is:
  +---[RSA 2048]----+
  |     . .+.       |
  |  . o +o.+. o.   |
  |   = . E=.o .+o  |
  |  . o o..=oo+o.+ |
  |   .  .+So.oo=. o|
  |    o o.+ . o.o .|
  |     + + . o o ..|
  |      . . . +   o|
  |           +.   .|
  +----[SHA256]-----+

Another option is to let OpenStack create a keypair for you, more
about that later. To import your existing keypair into OpenStack, go
to the **Access & Security** tab under **Project** and select "Key
Pairs":

.. image:: images/dashboard-access-and-security-01.png
   :align: center
   :alt: Dashboard - Access & Security

Click the button labeled "Import Key Pair". Give the keypair a name,
and enter the contents of the **id_rsa.pub** file in the "Public Key"
field:

.. image:: images/dashboard-import-keypair-01.png
   :align: center
   :alt: Dashboard - Import an SSH keypair

Click "Import Key Pair" and the key is saved:

.. image:: images/dashboard-keypairs-01.png
   :align: center
   :alt: Dashboard - View keypairs


Letting OpenStack create a keypair
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can let OpenStack create a keypair for you, if you don't wish to
use an existing one. Go to the **Access & Security** tab
under **Project** and select "Key Pairs":

.. image:: images/dashboard-access-and-security-01.png
   :align: center
   :alt: Dashboard - Access & Security

Click on "Create Key Pair":

.. image:: images/dashboard-create-keypair-01.png
   :align: center
   :alt: Dashboard - Create an SSH keypair

Choose a name for you keypair and click "Create Key Pair". The newly
created private key will be downloaded by the browser automatically:

.. image:: images/dashboard-create-keypair-02.png
   :align: center
   :alt: Dashboard - Download created keypair

The name of the downloaded file is based on the name you provided
earlier. In this example the file is called "test.pem" as "test" was
provided as the keypair name. Remember to restrict the access to the
private key, as SSH will refuse to use unless it's properly
protected::

  $ chmod 0600 test.pem

In order to use the downloaded private key, use the **-i** option to
ssh, like this (example for "test.pem" above)::

  $ ssh -i test.pem <virtual-machine>

Replace "<virtual-machine>" with the name or IP of the virtual machine
that this keypair is assigned to.


Create a virtual machine
------------------------

Once you have an SSH keypair defined, you can proceed with creating a
virtual machine (instance). In the **Project** tab,
select **Instances**:

.. image:: images/dashboard-create-instance-01.png
   :align: center
   :alt: Dashboard - Instances

Click "Launch Instance". The following window will appear:

.. image:: images/dashboard-create-instance-02.png
   :align: center
   :alt: Dashboard - Launch instance

In this window, enter the following values:

* **Availability Zone**: nova (the default)
* **Instance Name**: Select a name for your new virtual machine
* **Flavor**: Choose whichever size that fits your purpose
* **Instance Count**: How many virtual machines to create (usually only 1)
* **Instance Boot Source**: Select whichever is appropriate for your
  needs:

  - *Boot from image*: This is usually preferred. In this case, the
    virtual machine will boot from a standard cloud image. When
    selecting this option, you can choose from a list of images.
  - *Boot from snapshot*: If you have previously taken a snapshot from
    another virtual machine, you can boot from it when creating your
    new virtual machine
  - *Boot from volume*: FIXME.
  - *Boot from image (creates a new volume)*: FIXME
  - *Boot from volume snapshot (creates a new volume)*: FIXME

When finished with the "Details" tab, select the "Access & Security"
tab:

.. image:: images/dashboard-create-instance-03.png
   :align: center
   :alt: Dashboard - Launch instance - Access & Security

Here, choose which SSH keypair you want to assign to this virtual
machine, and choose any security groups. The "default" security group
doesn't allow any access to the virtual machine unless it's
modified. When finished with this tab, select the "Networking" tab:

.. image:: images/dashboard-create-instance-04.png
   :align: center
   :alt: Dashboard - Launch instance - Networking

Here, you may select to attach networks to the virtual machine:

* **public**: The virtual machine will be on the public network, and
  receive a "real" IPv4 address which is accessible from the Internet.
* **private**: The virtual machine will be on the private network,
  which is shared within the OpenStack location (e.g. Bergen, Oslo) in
  which the virtual machine is created.

You can choose one or both of these networks.

.. IMPORTANT::
   Currently, you should choose only one of these networks. Due to a
   technical issue with default routing setup on the virtual machine,
   using both simultanously may not work. This will be fixed in the
   future. FIXME.

.. WARNING::
   The networking setup in UH-IaaS differs from the default OpenStack
   networking as documented elsewhere. There are no really private
   network available just for one project. The private network, as
   mentioned above, is shared within the location (e.g. Oslo,
   Bergen). This means that all virtual machines can reach each other
   within the location regardless of their project association. You
   should use Security Groups to restrict network traffic access to
   your virtual machines also on the private network.

The "Post-Creation" and "Advanced" tabs are normally not used. When
satisfied, clik "Launch" to create your virtual machine.

.. image:: images/dashboard-create-instance-05.png
   :align: center
   :alt: Dashboard - Launch instance - finished

After a few moments, the virtual machine is up and running. If you
chose a public IPv4 address the virtual machine is accessible from the
Internet, but you need to manage security groups in order to reach
it. By default, all network access is denied.


Allowing SSH and ICMP access
----------------------------

In order to allow traffic to the virtual machine, you need to create a
new security group which allows it, and attach that security group to
the virtual machine. Alternatively, you can modify an existing rule
such as "default". To create a new security group, go to the **Access &
Security** tab under **Project** and select "Security Groups":

.. image:: images/dashboard-access-and-security-02.png
   :align: center
   :alt: Dashboard - Access & Security

Click on "Create Security Group":

.. image:: images/dashboard-create-secgroup-01.png
   :align: center
   :alt: Dashboard - Create Security Group

Fill in a name for the new security group, and optionally a
description. Then click "Create Security Group":

.. image:: images/dashboard-create-secgroup-02.png
   :align: center
   :alt: Dashboard - Create Security Group

Next, click "Manage Rules" for the "SSH and ICMP" security group:

.. image:: images/dashboard-create-secgroup-03.png
   :align: center
   :alt: Dashboard - Create Security Group

You want to add a couple of rules. Click "Add Rule":

.. image:: images/dashboard-create-secgroup-04.png
   :align: center
   :alt: Dashboard - Create Security Group

Select "ALL ICMP" from the drop-down menu under "Rule". Leave the rest
at its default and click "Add". Repeat the process and select "SSH"
from the "Rule" drop-down menu, and the result should be:

.. image:: images/dashboard-create-secgroup-05.png
   :align: center
   :alt: Dashboard - Create Security Group

Go back to the **Instances** tab under Compute, and use the drop-down
menu to the right of your newly created virtual machine. Select "Edit
Security Groups":

.. image:: images/dashboard-instance-edit-secgroup-01.png
   :align: center
   :alt: Dashboard - Edit Security Group

The following will appear:

.. image:: images/dashboard-instance-edit-secgroup-02.png
   :align: center
   :alt: Dashboard - Edit Security Group

Add the "SSH and ICMP" security group and click "Save".


Accessing the virtual machine
-----------------------------

With a proper security group in place, the virtual machine is now
reachable from the Internet::

  $ ping 158.39.77.15
  PING 158.39.77.15 (158.39.77.15) 56(84) bytes of data.
  64 bytes from 158.39.77.15: icmp_seq=1 ttl=55 time=6.15 ms
  64 bytes from 158.39.77.15: icmp_seq=2 ttl=55 time=6.05 ms
  64 bytes from 158.39.77.15: icmp_seq=3 ttl=55 time=6.01 ms

You can log in to the virtual machine using the SSH key assigned to
the virtual machine. In case you let OpenStack create the keypair for
you (example with "test.pem" above)::

  $ ssh -i test.pem cirros@158.39.77.15
  $ uname -sr
  Linux 3.2.0-80-virtual
  $ sudo -i
  # whoami
  root

Each image has its own default user, for which the SSH public key is
added to it's SSH authorized_keys file. This varies with each image,
at the discretion of the image vendor. The most common are:

============== =========
Image          User
============== =========
CentOS         centos
Fedora         fedora
Ubuntu         ubuntu
Debian         debian
CirrOS         cirros
============== =========

This is a non-exhaustive list. For images not listed here, consult the
image vendor's documentation.

