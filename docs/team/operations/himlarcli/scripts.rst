===============
Script overview
===============

Help
====

All script will have updated help that can be accessed with the :file:`-h`
options. Most of the script actions will also have its help description.
E.G::

  ./image.py update -h

Options
=======

Common options for all scripts

* :file:`--debug`
* :file:`--dry-run`
* :file:`-c /path/to/config.ini`
* :file:`--format text|json`

Scripts
=======

Simple overview with some of the most important actions. More actions might
exist, so please refer to the help text.

=========== =========== ===========================================
script       actions     notes
=========== =========== ===========================================
project.py   list        list all projects
\            show        list project details and roles in project
\            create      create new project
\            delete      delete project and instances
image.py     update      update gold images
\            usage       show image usage
\            purge       purge unused images
\            usage       check image usage
quota.py     update      update default quota
\            show        show default quota
=========== =========== ===========================================
