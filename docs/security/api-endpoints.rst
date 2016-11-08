.. |date| date::

API endpoints
=============

Last changed: |date|

.. contents::

+-------------------------+---------------------+
| **Impact**              | High                |
+-------------------------+---------------------+
| **Implemented percent** | **66%** (4/6)       |
+-------------------------+---------------------+

.. _OpenStack Security Guide\: API endpoints: http://docs.openstack.org/security-guide/api-endpoints.html

From `OpenStack Security Guide\: API endpoints`_:

  *The process of engaging an OpenStack cloud is started through the
  querying of an API endpoint. While there are different challenges
  for public and private endpoints, these are high value assets that
  can pose a significant risk if compromised.*


API endpoint configuration recommendations
------------------------------------------

Internal API communications
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. _API endpoint configuration recommendations: http://docs.openstack.org/security-guide/api-endpoints/api-endpoint-configuration-recommendations.html

From OpenStack Security Guide:

  *OpenStack provides both public facing and private API endpoints. By
  default, OpenStack components use the publicly defined
  endpoints. The recommendation is to configure these components to
  use the API endpoint within the proper security domain.*

  *Services select their respective API endpoints based on the
  OpenStack service catalog. These services might not obey the listed
  public or internal API end point values. This can lead to internal
  management traffic being routed to external API endpoints.*

``[PASS]`` **Configure internal URLs in the Identity service catalog**
  The guide recommends that our Identity service catalog be aware of
  our internal URLs. This feature is not utilized by default, but may
  be leveraged through configuration. See `API endpoint configuration
  recommendations`_ for details.

  * All services have configured admin, internal and public endpoints.

``[PASS]`` **Configure applications for internal URLs**
  It is recommended that each OpenStack service communicating to the
  API of another service must be explicitly configured to access the
  proper internal API endpoint. See `API endpoint configuration
  recommendations`_.

  All service to service communication use internal endpoints within
  a region. This includes:

  * volume to identity
  * image to identity
  * network to identity
  * compute to identity
  * compute to image
  * compute to volume
  * compute to network

Paste and middleware
~~~~~~~~~~~~~~~~~~~~

From OpenStack Security Guide:

  *Most API endpoints and other HTTP services in OpenStack use the
  Python Paste Deploy library. From a security perspective, this
  library enables manipulation of the request filter pipeline through
  the application’s configuration. Each element in this chain is
  referred to as middleware. Changing the order of filters in the
  pipeline or adding additional middleware might have unpredictable
  security impact.*

``[N/A]`` **Document middleware**
  We should careful when implementating non-standard software in the
  middleware, and this should be thoroughly documented.

  * We are not using any non-standard middleware

API endpoint process isolation and policy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

From OpenStack Security Guide:

  *You should isolate API endpoint processes, especially those that
  reside within the public security domain should be isolated as much
  as possible. Where deployments allow, API endpoints should be
  deployed on separate hosts for increased isolation.*

``[N/A]`` **Namespaces**
  Linux supports namespaces to assign processes into independent
  domains.

  * All service endpoint run on different virtual hosts.

``[DEFERRED]`` **Network policy**
  We should pay special attention to API endpoints, as they typically
  bridge multiple security domains. Policies should be in place and
  documented, and we can use firewalls, SELinux etc. to enforce proper
  compartmentalization in the network layer.

  * FIXME: Implement and document this

``[DEFERRED]`` **Mandatory access controls**
  API endpoint processes should be as isolated from each other as
  possible. This should be enforced through Mandatory Access Controls
  (e.g. SELinux), not just Discretionary Access Controls.

  * FIXME: API processes protected by SELinux
