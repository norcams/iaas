====================
Hardware maintenance
====================


Upgrading firmware on Dell servers
==================================

Normal procedure:

#. Run Dell System Update::

    dsu

#. Press **a** + **ENTER** to select all available updates

#. Press **c** + **ENTER** to commit and start the upgrade

#. When it finishes, reboot the server::

    reboot

On older servers (tested on 11th gen), like we have in test, upgrading
firmware on storage components may fail. If this happens:

#. Fix libs::

     cd /opt/dell/srvadmin/lib64/
     ln -fs libstorelibir-3.so libstorelibir.so.5

#. Run dsu again::

     dsu

#. Press **a** + **ENTER** to select all available updates

#. Press **c** + **ENTER** to commit and start the upgrade

#. Return libs to default::

     cd /opt/dell/srvadmin/lib64/
     ln -fs libstorelibir.so.5.07-0 libstorelibir.so.5

#. Verify that libs are returned to normal::

     ls -l /opt/dell/srvadmin/lib64/libstorelibir.so.5

#. Reboot::

     reboot


iDRAC settings on Dell servers
==============================

Setting proper name on the iDRAC::

  racadm config -g cfgLanNetworking -o cfgDNSRacName $(hostname -s)

