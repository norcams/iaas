===================================
Rack overview and power consumption
===================================

.. Figurene er laget med draw.io. Kildekoden til hver av dem ligger
.. under images. De er eksportert til PNG for å brukes på web.

Rack placement and power consumption planning.

Region OSL
----------

Rack 1
~~~~~~

.. image:: images/osl-rack-1.png

Estimated power consumption:

================= ========================== =========== ===========
 Host              Vendor/Model               Typical     Maximum
================= ========================== =========== ===========
osl-login-01      Dell PowerEdge R610        200 W       300 W
osl-torack-01     ?                          200 W       370 W
osl-torack-02     ?                          200 W       370 W
osl-compute-01    Dell PowerEdge R630        354 W       541 W
osl-compute-02    Dell PowerEdge R630        354 W       541 W
osl-compute-03    Dell PowerEdge R630        354 W       541 W
osl-compute-04    Dell PowerEdge R630        354 W       541 W
osl-compute-05    Dell PowerEdge R630        354 W       541 W
osl-compute-06    Dell PowerEdge R630        354 W       541 W
osl-compute-07    Dell PowerEdge R640        499 W       702 W
osl-compute-08    Dell PowerEdge R640        499 W       702 W
osl-compute-09    Dell PowerEdge R640        499 W       702 W
osl-compute-10    Dell PowerEdge R640        499 W       702 W
osl-compute-17    Supermicro AS -4023S-TRT   300 W       500 W
osl-compute-42    Supermicro AS -4023S-TRT   300 W       500 W
osl-controller-01 Dell PowerEdge R630        232 W       380 W
osl-controller-02 Dell PowerEdge R630        232 W       380 W
osl-controller-03 Dell PowerEdge R630        232 W       380 W
osl-controller-04 Dell PowerEdge R620        242 W       398 W
**Total**                                    **6258 W**  **9632 W**
================= ========================== =========== ===========


Rack 2
~~~~~~

.. image:: images/osl-rack-2.png

Estimated power consumption:

================= ========================== =========== ===========
 Host              Vendor/Model               Typical     Maximum
================= ========================== =========== ===========
osl-leaf03        ?                          
osl-leaf04        ?                          
osl-mgmt-01       ?                          
osl-storage-01    Dell PowerEdge R730xd      368 W       572 W
osl-storage-02    Dell PowerEdge R730xd      368 W       572 W
osl-storage-03    Dell PowerEdge R730xd      368 W       572 W
osl-storage-04    Dell PowerEdge R730xd      368 W       572 W
osl-storage-05    Dell PowerEdge R730xd      368 W       572 W
osl-storage-06    Dell PowerEdge R740xd      388 W       602 W
osl-storage-07    Dell PowerEdge R740xd      388 W       602 W
osl-storage-08    Dell PowerEdge R730xd      476 W       680 W
osl-storage-09    Dell PowerEdge R730xd      476 W       680 W
osl-storage-10    Dell PowerEdge R730xd      476 W       680 W
osl-storage-11    Dell PowerEdge R730xd      476 W       680 W
osl-storage-12    Dell PowerEdge R730xd      476 W       680 W
**Total**                                    *4996 W*    *7464 W*
================= ========================== =========== ===========


Rack 3
~~~~~~

.. image:: images/osl-rack-3.png

Estimated power consumption:

================= ========================== =========== ===========
 Host              Vendor/Model               Typical   Maximum
================= ========================== =========== ===========
osl-mgmt-opx-02   ?                          
osl-nfs-01        Dell PowerEdge R710        300 W       400 W
osl-compute-11    Dell PowerEdge R7425       579 W       889 W
osl-compute-12    Dell PowerEdge R7425       579 W       889 W
osl-compute-13    Dell PowerEdge R7425       579 W       889 W
osl-compute-14    Dell PowerEdge R7425       579 W       889 W
osl-compute-15    Dell PowerEdge R7425       579 W       889 W
osl-compute-16    Dell PowerEdge R7425       579 W       889 W
osl-compute-21/24 Supermicro AS -2123BT-HTR  2000 W      3000 W
osl-compute-25/28 Supermicro AS -2123BT-HTR  2000 W      3000 W
**Total**                                    *7774 W*    *11734 W*
================= ========================== =========== ===========


Rack 4 (planned)
~~~~~~~~~~~~~~~~

.. image:: images/osl-rack-4.png
