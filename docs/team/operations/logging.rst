=======
Logging
=======

We have a node called `logger` where we run rsyslog-server, Logstash, Kibana and
Elasticsearch. The other nodes can be set up to ship logs to `logger`.

rsyslog
-------

You can find the logs for each client under :file:`/opt/log/<hostname>`.

Some Openstack components have their own syslog facility::

  local0.* nova
  local1.* horizon (apache logs)
  local2.* keystone
  local3.* glance
  local4.* cinder
  local5.* neutron

Kibana
------

Access to `kibana` is limited to mgmt network on each site. You will need to
run :file:`sshuttle` or ssh port forwarding to the `login` node to gain
access. Point your browser to::

 bgo: http://bgo-logger-01.mgmt.iaas.intern:5601/
