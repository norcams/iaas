Build docs locally using Sphinx
===============================

This describes how to build the documentation from norcams/iaas locally

RHEL, CentOS, Fedora
--------------------

You'll need the python-virtualenvwrapper package from EPEL

.. code:: bash

  sudo yum -y install python-virtualenvwrapper
  # Restart shell
  exit

Ubuntu (trusty)
---------------

.. code:: bash

	sudo apt-get -y install virtualenvwrapper make
	# Restart shell
	exit

Build docs
----------

.. code:: bash

  # Make a virtual Python environment
  # This env is placed in .virtualenv in $HOME
  mkvirtualenv docs

  # activate the docs virtualenv
  workon docs
  # install sphinx into it
  pip install sphinx sphinx_rtd_theme

  # Compile docs
  cd iaas/docs
  make html

  # Open in modern internet browser of choice
  xdg-open _build/html/index.html

  # Deactivate the virtualenv
  deactivate
