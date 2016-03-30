.. |date| date::

Introduction
============

Last changed: |date|

.. contents::

.. _OpenStack: https://www.openstack.org/
.. _OpenStack End User Guide: http://docs.openstack.org/user-guide/index.html

The UH-IaaS cloud is based on OpenStack_, which is a large framework
of software components used to deliver an Infrastructure-as-a-Service
consisting of compute, networking and storage resources.

This document is aimed at the end user. We'll borrow a lot from the
`OpenStack End User Guide`_, including linking to this guide where
appropriate.


Who can use the UH-IaaS cloud?
------------------------------

At the time of this writing, the UH-IaaS cloud is not yet in
production state. Only select testers can use the cloud at this stage.


What can you do with the UH-IaaS cloud?
---------------------------------------

As an OpenStack cloud end user, you can provision your own resources
within the limits set by cloud administrators.

The examples in this guide show you how to perform tasks by using the
following methods:

* OpenStack dashboard. Use this web-based graphical interface to view,
  create, and manage resources.

* OpenStack command-line clients. Each core OpenStack project has a
  command-line client that you can use to run simple commands to view,
  create, and manage resources in a cloud and automate tasks by using
  scripts.

You can modify these examples for your specific use cases.

In addition to these ways of interacting with a cloud, you can access
the OpenStack APIs directly or indirectly through cURL commands or
open SDKs. You can automate access or build tools to manage resources
and services by using the native OpenStack APIs or the EC2
compatibility API.

To use the OpenStack APIs, it helps to be familiar with HTTP/1.1,
RESTful web services, the OpenStack services, and JSON or XML data
serialization formats.
