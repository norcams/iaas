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
\            grant       grant access for user to project
image.py     update      update images (gold or private)
\            usage       show image usage
\            purge       purge unused images
\            usage       check image usage
quota.py     update      update default quota
\            show        show default quota
usage.py     volume      show volume usage and quota in gb
=========== =========== ===========================================
