Build docs locally using Sphinx
===============================

This describes how to build the documentation from norcams/iaas locally

CentOS 6.x
----------

.. code:: bash

   sudo yum install python-virtualenv
   sudo easy_install pip
   sudo pip install virtualenvwrapper
   
   source /usr/bin/virtualenvwrapper.sh 
   mkvirtualenv docs
   # virtual python env is placed in .virtualenv in $HOME
   
   # activate the docs virtualenv
   workon docs
   # install sphinx into it
   pip install sphinx sphinx_rtd_theme
   
   cd iaas/docs
   make html
   
   # open in modern internet browser of choice
   xdg-open _build/html/index.html
   
   deactivate


