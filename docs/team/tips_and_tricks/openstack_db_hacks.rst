=============================================
OpenStack database hacks to resolve gridlocks
=============================================

Sometimes the OpenStack services are in disagreement with the real
world, and often those situations cannot be resolved with the available
command line tools, prompting manual intervention in the databases
directly.


Non-existant volume attached to instance
----------------------------------------

In some cases a volume attachment is created with a volume in state 'reserved'.
This attachment, however, is not actually made, so it won't show up in
cinder attachment-list. It will, however, become an entry in the nova database
block_device_mapping table. As the volume is not referenced by cinder as 
attached, the volume may be deleted by the user, which will happen because of
the perpetual 'reserved' state. The instance will then go into 'error' state
as soon as actions like power-on and migrate are performed, complaining about
the non-existing volume.

To resolve the issue, the block device mapping must be deleted from the nova
database.

Log into the database node and select the nova database, then delete the alleged
attachment with

.. code:: bash

    delete from block_device_mapping where volume_id = '<volume_id of non-existing volume>';
