Build docs locally using Sphinx
===============================

This describes how to build the documentation from norcams/iaas locally

Build docs
----------

.. code:: bash

  # Make a virtual Python environment
  python3 -m venv .

  # activate the virtualenv
  source bin/activate

  # install latest pip in venv
  pip install --upgrade pip

  # install sphinx and other requirements
  pip install -r requirements.txt

  # Compile docs
  cd docs
  make html

  # Open in modern internet browser of choice
  xdg-open _build/html/index.html

  # Deactivate the virtualenv
  deactivate
