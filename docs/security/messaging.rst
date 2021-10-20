.. |date| date::

[2021] Message queuing
======================

``REVISION 2021-10-20``

.. contents::

.. _OpenStack Security Guide\: Message queuing: http://docs.openstack.org/security-guide/messaging.html

+-------------------------+---------------------+
| **Impact**              | High                |
+-------------------------+---------------------+
| **Implemented percent** | **50%** (4/8)       |
+-------------------------+---------------------+

From `OpenStack Security Guide\: Message queuing`_:

  *Message queues effectively facilitate command and control functions
  across OpenStack deployments. Once access to the queue is permitted
  no further authorization checks are performed. Services accessible
  through the queue do validate the contexts and tokens within the
  actual message payload. However, you must note the expiration date
  of the token because tokens are potentially re-playable and can
  authorize other services in the infrastructure.*

  *OpenStack does not support message-level confidence, such as message
  signing. Consequently, you must secure and authenticate the message
  transport itself. For high-availability (HA) configurations, you
  must perform queue-to-queue authentication and encryption.*

.. NOTE::
   We are using RabbitMQ as message queuing service back end.

Messaging security
------------------

.. _OpenStack Security Guide\: Message queuing - Messaging security: http://docs.openstack.org/security-guide/messaging/security.html

Ref: `OpenStack Security Guide\: Message queuing - Messaging security`_

Messaging transport security
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

From OpenStack Security Guide:

  *We highly recommend enabling transport-level cryptography for your
  message queue. Using TLS for the messaging client connections
  provides protection of the communications from tampering and
  eavesdropping in-transit to the messaging server.*

``[FAIL]`` **Ensure TLS is used for RabbitMQ**
  * TLS is NOT used for the messaging service

``[FAIL]`` **Use an internally managed CA**
  * No CA as TLS is not used

``[FAIL]`` **Ensure restricted file permissions on certificate and key files**
  * No CA as TLS is not used

Queue authentication and access control
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

From OpenStack Security Guide:

  *We recommend configuring X.509 client certificates on all the
  OpenStack service nodes for client connections to the messaging
  queue and where possible (currently only Qpid) perform
  authentication with X.509 client certificates. When using user names
  and passwords, accounts should be created per-service and node for
  finer grained auditability of access to the queue.*

``[FAIL]`` **Configure X.509 client certificates on all OpenStack service nodes**
  * Currently no TLS/user certificates set up

``[PASS]`` **Any user names and passwords are per-service and node**
  All services have their own queue, using their own username and
  password combination.

Message queue process isolation and policy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``[N/A]`` **Use network namespaces**
  Network namespaces are highly recommended for all services running
  on OpenStack Compute Hypervisors. This will help prevent against the
  bridging of network traffic between VM guests and the management
  network.

  * Instance traffic is not bridged on the hypervisors, and instance
    traffic directed to the internal services is dropped (blackholed)
    on the hypervisor itself

``[PASS]`` **Ensure queue servers only accept connections from management network**
  Only internal traffic is allowed to the MQ nodes

``[PASS]`` **Use mandatory access controls**
  SELinux in enforcing mode on all nodes
