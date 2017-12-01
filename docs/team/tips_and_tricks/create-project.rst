====================
Create a new project
====================

**1**::

   ssh <user>@<loc>-login-01.<domain>
  
**2**::

   ssh iaas@<loc>-proxy-01.<domain>
   
**3**::

   sudo -i
   source openrc   
 
**4**::

   cd /opt/himlarcli
   source bin/activate      

**5**:: 
 
   run ./project.py 
   

Example
-------

.. code:: bash

   ./project.py create -t <admin> -a <email> -q <small> --end <enddate> --desc <"description"> --dry-run --debug

