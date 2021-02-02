====================
Create a new project
====================


- ssh <user>@<loc>-login-01.<domain>
  
- ssh iaas@<loc>-proxy-01.<domain>
   
- sudo -i
- source openrc   
 
- cd /opt/himlarcli
- source bin/activate
      
- run ./project.py 
   

Example
-------

.. code:: bash

   ./project.py create -t <type> -a <email> -q <small> --end <enddate> --desc <"description"> --rt <number> -m --dry-run --debug

