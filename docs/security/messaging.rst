.. |date| date::

Message queuing
===============

Last changed: |date|

.. contents::

.. _OpenStack Security Guide\: Message queuing: http://docs.openstack.org/security-guide/messaging.html

+-------------------------+---------------------+
| **Impact**              | High                |
+-------------------------+---------------------+
| **Implemented percent** | **0%** (0/?)        |
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

``[----]`` **Ensure TLS is used for RabbitMQ**
  FIXME: yes/no

``[----]`` **Use an internally managed CA**
  FIXME: Document this

``[----]`` **Ensure restricted file permissions on certificate and key files**
  FIXME: yes/no

Queue authentication and access control
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

From OpenStack Security Guide:

  *We recommend configuring X.509 client certificates on all the
  OpenStack service nodes for client connections to the messaging
  queue and where possible (currently only Qpid) perform
  authentication with X.509 client certificates. When using user names
  and passwords, accounts should be created per-service and node for
  finer grained auditability of access to the queue.*

``[----]`` **Configure X.509 client certificates on all OpenStack service nodes**
  FIXME: Implement and document

``[----]`` **Any user names and passwords are per-service and node**
  FIXME: Implement and document

Message queue process isolation and policy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``[----]`` **Use network namespaces**
  Network namespaces are highly recommended for all services running
  on OpenStack Compute Hypervisors. This will help prevent against the
  bridging of network traffic between VM guests and the management
  network.

  * FIXME: Ensure and document

``[----]`` **Ensure queue servers only accept connections from management network**
  FIXME: Ensure and document

``[----]`` **Use mandatory access controls**
  FIXME: SELinux in enforcing mode on all nodes
