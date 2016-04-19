.. |A| image:: /images/16x16_yes.png
.. |R| running
.. |O| image:: /images/16x16_no.png
.. |I| image:: /images/16x16_warning.png

=================
Compute reinstall
=================

Each compute node will be reinstalled every three weeks. This table
tries to explain the status of each node for a six week period:


=========== === === === === === ===
Node        16  17  18  19  20  21
=========== === === === === === ===
compute-01  |A| R   R   |I| R   R

compute-02  |O| |A| R   R   |I| R

compute-03  |O| |O| |A| R   R   |I|

=========== === === === === === ===

- R = running

- green = active (new instances spawn here)

- red = off

- yellow = reinstall, then active
