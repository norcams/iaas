Using vncviewer to access the console
=====================================

We configure the bmc (baseboard management controller) on our servers to enable
a VNC server feature. Accessing the console through VNC is easier and faster
than using the Java-based console available through the bmc web interface.

On CentOS/RedHat/Fedora, install the needed VNC client packages:

.. code:: bash

  yum -y install tigervnc tigervnc-server-minimal
  vncpasswd # -> enter the idrac password and confirm
  vncviewer -passwd ~/.vnc/passwd 1.2.3.4:5901

The *tigervnc-server-minimal* package is needed in order to get the *vncpasswd*
utility. This creates a passwd file that is used for providing a password when
connecting to the VNC server. The VNC server on the bmc's is listening on port
5901. Only a single connection is allowed by the server.

