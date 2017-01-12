====================
Puppet design policy
====================

This the policy for himlar puppet code.

Definitions
===========

* **himlar**: puppet code at https://github.com/norcams/himlar
* **module**: upstream module listed in :file:`Puppetfile`
* **profile**: a puppet module with classes for norcams adaptations.
  Found in himlar under :file:`profile/`
* **hieradata**: hierarchical yaml files with config data under :file:`hieradata/`

Profile
=======

* hieradata should include profile classes
* all modules should be included in a profile class (never in hieradata)
* profile classes should have boolean options to enable a feature with default
  value set to false
* enabling of profile features should be done either in
    - :file:`hieradata/common/modules/profile.yaml` for global settings
    - :file:`hieradata/common/role/` for enabling for only one role
* each openstack role should have one class named after itself that will include
  feature classes
* location hieradata override should always be done in the same module/role
  file as in the common version of module/role
* module hieradata should be grouped by module classes
