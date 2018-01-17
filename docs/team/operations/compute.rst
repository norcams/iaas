.. |A| image:: /images/16x16_yes.png
.. |O| image:: /images/16x16_no.png
.. |I| image:: /images/16x16_warning.png

=================
Compute reinstall
=================

Each compute node will be reinstalled every three weeks. This table
tries to explain the status of each node for a six week period:


=========== === === === === === ===
Node        22  23  24  25  26  27
=========== === === === === === ===
compute-01  |A| R   R   |I| R   R

compute-02  |O| |A| R   R   |I| R

compute-03  |O| |O| |A| R   R   |I|

=========== === === === === === ===

- R = running

- green = active (new instances spawn here)

- red = off

- yellow = reinstall, then active

Ansible script
==============
NB! Stop the running instances before you start!

To reinstall a compute host with `ansible <ansible/index.html>`_ run::

  cd <ansible-repo>
  bin/rebuild_compute.sh <HOST> --force

Make sure puppet is run at least once after the host is reinstalled.

Switch active compute host
==========================

After the new host is reinstalled set it to enable with Openstack cli or horizon.
Set the last weeks compute host to disable.
