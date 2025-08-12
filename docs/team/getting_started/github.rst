===============================
Work with source code on github
===============================

Source code
===========

When we speak of the source code, we typically refer to `norcams/himlar` on
Github. This is the puppet code, hieradata and bootstrap scripts to get every
component up and running the way we need.

First make sure you have a Github account and then fork the `norcams/himlar`
repo. You should try to make this repo the origin and then add another
remote for `norcams/himlar`

Policy
======

When you need to make a change the rule of thumb is the following:

* Minor changes can be done directly to master on `norcams/himlar`. E.g.
  hieradata for one location, minor code change for none critical components.

* All other changes will need a :abbr:`PR (pull request)` on Github

* All code change should also be deployed first on a development location
  (e.g. `test01`) or using Vagrant
