Build docs locally using Sphinx
===============================

This describes how to build the documentation from norcams/iaas locally

Linux
----------

.. code:: bash

  git clone <repo> && cd <repo>

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

Windows Terminal
----------------

.. code:: powershell

  winget install python Git.Git ezwinports.make
  (re-login)
  git clone <repo>
  cd .\<repo>\
  python -m venv .
  .\Scripts\activate
  pip install -r .\requirements.txt
  cd .\docs\
  make html
  ii .\_build\html\index.html
  deactivate

