===
GIT
===

New commit upstream before you can push
---------------------------------------

.. code:: bash

  $ git push upstream master
  To github.com:upstream/himlar
   ! [rejected]            master -> master (fetch first)
  error: failed to push some refs to 'github.com:upstream/himlar'

To fix

.. code:: bash

  git config pull.rebase true # needed once
  git pull --autostash upstream master
  git push upstream master

