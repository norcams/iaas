.. |date| date::

Dashboard
=========

Last changed: |date|

.. contents::

.. _OpenStack Security Guide\: Dashboard: http://docs.openstack.org/security-guide/dashboard.html

+-------------------------+---------------------+
| **Impact**              | High                |
+-------------------------+---------------------+
| **Implemented percent** | **52%** (15/29)     |
+-------------------------+---------------------+

From `OpenStack Security Guide\: Dashboard`_:

  *Horizon is the OpenStack dashboard that provides users a
  self-service portal to provision their own resources within the
  limits set by administrators. These include provisioning users,
  defining instance flavors, uploading VM images, managing networks,
  setting up security groups, starting instances, and accessing the
  instances through a console.*


Domain names, dashboard upgrades, and basic web server configuration
--------------------------------------------------------------------

.. _OpenStack Security Guide\: Dashboard - Domain names, dashboard upgrades, and basic web server configuration: http://docs.openstack.org/security-guide/dashboard/domains-dashboard-upgrades-basic-web-server-configuration.html

Ref: `OpenStack Security Guide\: Dashboard - Domain names, dashboard upgrades, and basic web server configuration`_

Domain names
~~~~~~~~~~~~

From OpenStack Security Guide:

  *We strongly recommend deploying dashboard to a second-level domain,
  such as https://example.com, rather than deploying dashboard on
  a shared subdomain of any level, for example
  https://openstack.example.org or
  https://horizon.openstack.example.org. We also advise against
  deploying to bare internal domains like https://horizon/. These
  recommendations are based on the limitations of browser
  same-origin-policy.*

``[FAIL]`` **Use second-level domain**
  We are not given our own second-devel domain. The dashboard is
  available as "dashboard.uh-iaas.no".

``[DEFERRED]`` **Employ HTTP Strict Transport Security (HSTS)**
  If not using second-level domain, we are advised to avoid a
  cookie-backed session store and employ HTTP Strict Transport
  Security (HSTS)

  * We need to revisit this as soon as possible.

Basic web server configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

From OpenStack Security Guide:

  *The dashboard should be deployed as a Web Services Gateway Interface
  (WSGI) application behind an HTTPS proxy such as Apache or nginx. If
  Apache is not already in use, we recommend nginx since it is
  lightweight and easier to configure correctly.*

``[PASS]`` **Is dashboard deployed as a WSGI application behind an HTTPS proxy?**
  Yes, dashboard is deployed using mod_wsgi on an Apache server.

Allowed hosts
~~~~~~~~~~~~~

From OpenStack Security Guide:

  *Configure the ALLOWED_HOSTS setting with the fully qualified host
  name(s) that are served by the OpenStack dashboard. Once this
  setting is provided, if the value in the “Host:” header of an
  incoming HTTP request does not match any of the values in this list
  an error will be raised and the requestor will not be able to
  proceed. Failing to configure this option, or the use of wild card
  characters in the specified host names, will cause the dashboard to
  be vulnerable to security breaches associated with fake HTTP Host
  headers.*

``[FAIL]`` **Is ALLOWED_HOSTS configured for dashboard?**
  The UH-IaaS should be accessible from mostly everywhere. Setting
  ALLOWED_HOSTS would limit the access to a select few, which isn't
  what we want.

Horizon image upload
~~~~~~~~~~~~~~~~~~~~

It is recommended that we disable HORIZON_IMAGES_ALLOW_UPLOAD unless
we have a plan to prevent resource exhaustion and denial of service.

``[DEFERRED]`` **Is HORIZON_IMAGES_ALLOW_UPLOAD disabled?**
  We are currently willing to accept the risk of DoS by allowing image
  uploads.


HTTPS, HSTS, XSS, and SSRF
--------------------------

.. _OpenStack Security Guide\: Dashboard - HTTPS, HSTS, XSS, and SSRF: http://docs.openstack.org/security-guide/dashboard/https-hsts-xss-ssrf.html

Ref: `OpenStack Security Guide\: Dashboard - HTTPS, HSTS, XSS, and SSRF`_

Cross Site Scripting (XSS)
~~~~~~~~~~~~~~~~~~~~~~~~~~

From OpenStack Security Guide:

  *Unlike many similar systems, the OpenStack dashboard allows the
  entire Unicode character set in most fields. This means developers
  have less latitude to make escaping mistakes that open attack
  vectors for cross-site scripting (XSS).*

``[N/A]`` **Audit custom dashboards**
  Audit any custom dashboards, paying particular attention to use of
  the ``mark_safe`` function, use of ``is_safe`` with custom template
  tags, the ``safe`` template tag, anywhere auto escape is turned off,
  and any JavaScript which might evaluate improperly escaped data.

  * We are not using custom dashboards

Cross Site Request Forgery (CSRF)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

From OpenStack Security Guide:

  *Dashboards that utilize multiple instances of JavaScript should be
  audited for vulnerabilities such as inappropriate use of the
  @csrf_exempt decorator.*

``[N/A]`` **Audit custom dashboards**
  We are not using custom dashboards

HTTPS
~~~~~

From OpenStack Security Guide:

  *Deploy the dashboard behind a secure HTTPS server by using a valid,
  trusted certificate from a recognized certificate authority (CA).*

``[PASS]`` **Use trusted certificate for dashboard**
  We are using a trusted CA

``[PASS]`` **Redirect to fully qualified HTTPS URL**
  HTTP requests to the dashboard domain are configured to redirect to
  the fully qualified HTTPS URL.

HTTP Strict Transport Security (HSTS)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It is highly recommended to use HTTP Strict Transport Security (HSTS).

``[DEFERRED]`` **Use HSTS**
  FIXME: Revisit this ASAP


Front-end caching and session back end
--------------------------------------

.. _OpenStack Security Guide\: Dashboard - Front-end caching and session back end: http://docs.openstack.org/security-guide/dashboard/front-end-caching-session-back-end.html

Ref: `OpenStack Security Guide\: Dashboard - Front-end caching and session back end`_

Front-end caching
~~~~~~~~~~~~~~~~~

``[PASS]`` **Do not use front-end caching tools**
  We are not using front-end caching.

Session back end
~~~~~~~~~~~~~~~~

It is recommended to use ``django.contrib.sessions.backends.cache`` as
our session back end with memcache as the cache. This as opposed to
the default, which saves user data in signed, but unencrypted cookies
stored in the browser.

``[DEFERRED]`` **Consider using caching back end**
  FIXME: Revisit this


Static media
------------

.. _OpenStack Security Guide\: Dashboard - Static media: http://docs.openstack.org/security-guide/dashboard/static-media.html

Ref: `OpenStack Security Guide\: Dashboard - Static media`_

  *The dashboard’s static media should be deployed to a subdomain of
  the dashboard domain and served by the web server. The use of an
  external content delivery network (CDN) is also acceptable. This
  subdomain should not set cookies or serve user-provided content. The
  media should also be served with HTTPS.*

``[DEFERRED]`` **Static media via subdomain**
  FIXME: Implemented this.

``[N/A]`` **Subdomain not serving cookies or user-provided content**
  FIXME: Make sure

``[N/A]`` **Subdomain via HTTPS**
  FIXME: Make sure


Secret key
----------

.. _OpenStack Security Guide\: Dashboard - Secret key: http://docs.openstack.org/security-guide/dashboard/secret-key.html

Ref: `OpenStack Security Guide\: Dashboard - Secret key`_

  *The dashboard depends on a shared SECRET_KEY setting for some
  security functions. The secret key should be a randomly generated
  string at least 64 characters long, which must be shared across all
  active dashboard instances. Compromise of this key may allow a
  remote attacker to execute arbitrary code. Rotating this key
  invalidates existing user sessions and caching. Do not commit this
  key to public repositories.*

``[----]`` **Randomly generated string at least 64 characters long**
  Randomly generated, but much shorter than 64 chars

``[PASS]`` **Not in public repo**
  We have internal stores for secret keys.


Cookies
-------

.. _OpenStack Security Guide\: Dashboard - Cookies: http://docs.openstack.org/security-guide/dashboard/cookies.html

Ref: `OpenStack Security Guide\: Dashboard - Cookies`_

``[----]`` **Session cookies should be set to HTTPONLY**
  FIXME: Make sure

``[PASS]`` **Never configure CSRF or session cookies to have a wild card domain with a leading dot**
  Configured in /etc/openstack-dashboard/local_settings::

    CSRF_COOKIE_SECURE = True

``[PASS]`` **Horizon’s session and CSRF cookie should be secured when deployed with HTTPS**
  Configured in /etc/openstack-dashboard/local_settings::

    SESSION_COOKIE_SECURE = True


Cross Origin Resource Sharing (CORS)
------------------------------------

.. _OpenStack Security Guide\: Dashboard - Cross Origin Resource Sharing (CORS): http://docs.openstack.org/security-guide/dashboard/cross-origin-resource-sharing-cors.html

Ref: `OpenStack Security Guide\: Dashboard - Cross Origin Resource Sharing (CORS)`_

  *Configure your web server to send a restrictive CORS header with
  each response, allowing only the dashboard domain and protocol*

``[----]`` **Restrictive CORS header**
  FIXME: Make sure


Checklist
---------

.. _OpenStack Security Guide\: Dashboard - Checklist: http://docs.openstack.org/security-guide/dashboard/checklist.html

Ref: `OpenStack Security Guide\: Dashboard - Checklist`_

See the above link for info about these checks.

``[N/A]`` **Check-Dashboard-01: Is user/group of config files set to root/horizon?**
  The "horizon" group does not exist in our case. The local_settings
  file has user/group "root root"::

    # ls -l /etc/openstack-dashboard/local_settings
    -rw-r--r--. 1 root root 30438 Oct 20 10:44 /etc/openstack-dashboard/local_settings

``[N/A]`` **Check-Dashboard-02: Are strict permissions set for horizon configuration files?**
  As the horizon user doesn't exist, and there are no real users, the
  only system users that needs to read the the local_settings file are
  root and apache. In our case, there is no reason to restrict the
  access to this file more than we already have, using mode 0644.

``[----]`` **Check-Dashboard-03: Is USE_SSL parameter set to True?**
  FIXME

``[PASS]`` **Check-Dashboard-04: Is CSRF_COOKIE_SECURE parameter set to True?**
  Yes

``[PASS]`` **Check-Dashboard-05: Is SESSION_COOKIE_SECURE parameter set to True?**
  Yes

``[----]`` **Check-Dashboard-06: Is SESSION_COOKIE_HTTPONLY parameter set to True?**
  FIXME

``[----]`` **Check-Dashboard-07: Is password_autocomplete set to False?**
  Is "off" the default?

``[----]`` **Check-Dashboard-08: Is disable_password_reveal set to True?**
  Is "true" the default?
