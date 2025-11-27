============
Manage Sensu
============

.. WARNING::
  As allways when running scripts from ``himlarcli`` always check ``-h`` for
  each action to get all the options, input format and default values. 

Silence event
=============

It is easiest to use ``manage_sensu.py`` in ``himlarcli``. When we silence a check
it will also post a message to Slack (#vakt, #testvatk, etc) with the reason.

See current events::

  ./manage_sensu.py events
  ================================================================================
    Event list (is_silenced, state, check)                                      
  ================================================================================
  False failing bgo-builder-01/multiplex_rockylinux8
  False failing bgo-builder-01/multiplex_rockylinux8_uib_puppet
  False failing bgo-builder-01/multiplex_rockylinux9

Silence a check for a week::

  ./manage_sensu.py silence -H bgo-builder-01 -C multiplex_rockylinux8

This silence will be removed if the check is resolved OR after a week.

Using the option ``--no-resolve`` will only remove the silence after a week.

We can also set the ``-r`` for a reason (default 'silenced by himlarcli') and ``-e``
to set the expire time to shorter than a week (a week is max and default).

To silence all checks on a host we can use ``-C '*'`` (remember to quote the star!).

Silence known issues
====================

This will read from ``config/sensu/known_issues.yaml`` and silence all events defined for
a week::

  ./manage_sensu.py silence-known

This should be run each monday after reviewing the contents of ``known_issues.yaml``.

Show current silenced events
============================

This will list all current silenced check in a region::

  ./manage_sensu.py list-silenced

