================
Release planning
================

.. contents:: Iterative release planning to reach production usage

Descriptive summary
===================

This document describes how we plan to release the IaaS service to users and
the parttaking organizations.

The plan will be concentrated around our two main goals

- Enable local testing and piloting to select users at each location as soon as
  possible.

- Deliver a production platform as described in the main project plan.

The list of milestones is not final and will be reviewed weekly as needed by
the project and its stakeholders.

Software versions as milestones
===============================

The UH IaaS project is focused on the value of *continuous improvement* within
the constraints of a larger, delivery focused plan. Thus as engineers it makes
sense for us to couple planning to what we are actually producing day to day -
which is code.

Our milestones will use software versioning as a method of describing the
iterative work needed to reach each of the main goals. For the testing and
piloting phase we'll use versioning numbers starting with 0, e.g the first
deliverable and consumable service will be version 0.x.y. x and y will be
numbers representing features, changes and work items.

0.x.y series release goals
--------------------------

This series concentrates on enabling testing and pilot access to select users
at each location.

The 0 series releases will move quickly and update the environments and service
as needed, in flight. Data in the service is to be considered volatile during
this phase. In release planning, if the second component in the version number
(x) is increased, it represents a complete rebuild of the components, and thus
loss of any existing data. If the last component (y) is increased, it
represents a non-breaking change that only has temporarily effect on service
availability.

Each 0 series release will represent testing and exposing one or more changes
towards the complete feature set.

Only select pilot users will have access to the systems during the 0-series.

1.x.y series release goals
--------------------------

This series will work towards delivery of a feature complete service as
described by the original project plan.

The first 1.x.y release will enable access for all users through integration
with FEIDE or FEIDE Connect.

Release plan
============

This is a description of the currently planned releases and what changes they
represent going forward. This list is reviewed weekly to provide a summary of
the current status. Data for this list is correlated from the UH IaaS Trello
board at https://trello.com/b/m7tD31zU/iaas and GithHub milestones and issues
at https://github.com/norcams/himlar/milestones

0.1.0 (current release)
-----------------------

- Internal testing only.

- Network implementation completed.

0.2.0
-----

*Due date*: 15.10.2015

- First release enabling pilot user access

- Performance will be limited/restricted

- compute and image services will use local disk

- IP addressing will be limited or non-public

0.3.0
-----

*Due date*: 06.11.2015

- Cinder (block storage) service with Ceph backend enabled

0.4.0 (on production hardware)
-----

*Due date*: 12.11.2015

- Service on production network and hardware

- Performance restrictions lifted


1.0.0
-----

*Due date*: 15.12.2015

- FEIDE/FEIDE Connect enabled

- A user can select one of three regions for workloads


Status reports
==============

UH IaaS will produce weekly status reports which describes ongoing and upcoming
work items, problem areas and milestone updates.

The status reports will be published on this site and emailed internally.

