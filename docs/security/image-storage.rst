.. |date| date::

[2021] Image Storage (FIXME)
============================

``REVISION 2021-03-06``

.. contents::

.. _OpenStack Security Guide\: Image Storage: https://docs.openstack.org/security-guide/image-storage.html

+-------------------------+---------------------+
| **Impact**              | Medium              |
+-------------------------+---------------------+
| **Implemented percent** | **60%** (3/5)       |
+-------------------------+---------------------+

From `OpenStack Security Guide\: Image Storage`_:

  *OpenStack Image Storage (glance) is a service where users can
  upload and discover data assets that are meant to be used with other
  services. This currently includes images and metadata definitions.

  Image services include discovering, registering, and retrieving
  virtual machine images. Glance has a RESTful API that allows
  querying of VM image metadata as well as retrieval of the actual
  image.*


Checklist
---------

.. _OpenStack Security Guide\: Image Storage - Checklist: https://docs.openstack.org/security-guide/image-storage/checklist.html

Ref: `OpenStack Security Guide\: Image Storage - Checklist`_

See the above link for info about these checks.

``[PASS]`` **Check-Image-01: Is user/group ownership of config files set to root/glance?**
  Yes, except for **/etc/glance** which has "root root"::

    # stat -L -c "%U %G" /etc/glance/{,glance-api-paste.ini,glance-api.conf,glance-cache.conf,glance-manage.conf,glance-registry-paste.ini,glance-registry.conf,glance-scrubber.conf,glance-swift-store.conf,policy.json,schema-image.json,schema.json}
    root root
    stat: cannot stat ‘/etc/glance/glance-api-paste.ini’: No such file or directory
    root glance
    root glance
    stat: cannot stat ‘/etc/glance/glance-manage.conf’: No such file or directory
    stat: cannot stat ‘/etc/glance/glance-registry-paste.ini’: No such file or directory
    root glance
    root glance
    stat: cannot stat ‘/etc/glance/glance-swift-store.conf’: No such file or directory
    root glance
    root glance
    stat: cannot stat ‘/etc/glance/schema.json’: No such file or directory

``[FAIL]`` **Check-Image-02: Are strict permissions set for configuration files?**
  No (FIXME)::

    # stat -L -c "%a" /etc/glance/{,glance-api-paste.ini,glance-api.conf,glance-cache.conf,glance-manage.conf,glance-registry-paste.ini,glance-registry.conf,glance-scrubber.conf,glance-swift-store.conf,policy.json,schema-image.json,schema.json}
    755
    stat: cannot stat ‘/etc/glance/glance-api-paste.ini’: No such file or directory
    640
    640
    stat: cannot stat ‘/etc/glance/glance-manage.conf’: No such file or directory
    stat: cannot stat ‘/etc/glance/glance-registry-paste.ini’: No such file or directory
    640
    640
    stat: cannot stat ‘/etc/glance/glance-swift-store.conf’: No such file or directory
    640
    640
    stat: cannot stat ‘/etc/glance/schema.json’: No such file or directory

``[N/A]`` **Check-Image-03: Is keystone used for authentication?**
  Deprecated as of Stein release.

``[FAIL]`` **Check-Image-04: Is TLS enabled for authentication?**
  Communication is completely on the inside on a private network,
  which we consider to be an acceptible risk.

``[N/A]`` **Check-Image-05: Are masked port scans prevented?**
  The Glance v1 API is disabled.
