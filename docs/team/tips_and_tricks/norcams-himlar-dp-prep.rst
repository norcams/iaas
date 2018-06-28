=====================
nocams/himlar-dp-prep
=====================

Runnig himlar-dp-prep in the development environment
----------------------------------------------------

In Vagrant:

.. code:: bash

    vagrant ssh access
    /usr/local/sbin/dpapp_develop.sh
    (skal kjøres uten feil)
    cd /opt/dpapp.develop
    source bin/activate
    cp /opt/dpapp/production.ini .
    (update production.ini if needed, e.g. add host=0.0.0.0)
    systemctl stop iptables

    python setup.py develop or python setup.py install

    pserve --reload developent.ini or pserve production.ini
