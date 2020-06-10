====================
Hardware maintenance
====================

Dell PowerEdge servers
======================

Upgrading firmware
------------------

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


iDRAC settings
--------------

Setting proper name on the iDRAC::

  racadm config -g cfgLanNetworking -o cfgDNSRacName $(hostname -s)


Hardware inventory
------------------

An easy way to get the inventory of a Dell server is to run the
monitoring plugin in debug mode, from the monitor server::

  /usr/lib64/nagios/plugins/check_openmanage -H test02-controller-01 -d

iDRAC reset
-----------

If we have problems with the iDRAC, e.g. the redfish endpoint do not respond,
we can reset the iDRAC from the host os::

  yum install srvadmin-idrac.x86_64
  /opt/dell/srvadmin/bin/idracadm7 racreset
