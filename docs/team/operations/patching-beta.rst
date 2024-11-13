
===================
Patching (BETA)
===================

Per region:
-----------

Before maintenance window
~~~~~~~~~~~~~~~~~~~~~~~~~

#. Prepatch nodes::

     sudo ansible-playbook --forks 30 -e "myhosts=${location}-nodes exclude=httpd*,MariaDB*,mod_ssl,nfs-utils" lib/yumupdate.yaml

#. Install DSU on controllers::

     sudo ansible-playbook -e "myhosts=${location}-controller" lib/install_dsu.yaml

#. Make sure Puppet is enabled::

     sudo ansible-playbook --forks 30 -e "myhosts=${location}-nodes action=enable" lib/toggle_puppet.yaml
     sudo ansible-playbook -e "myhosts=${location}-controller action=enable" lib/toggle_puppet.yaml

#. Patch and stop resolver-02:

   .. code-block:: bash

     [root@osl-resolver-02 ~]# yum upgrade --refresh
     [root@osl-resolver-02 ~]# shutdown -h now

#. Patch controller-08::

     sudo ansible-playbook -e "async=1" -e "myhosts=${location}-controller-08" lib/yum_update_controller.yaml

#. Firmware controller-08:

   .. code-block:: bash

     [root@osl-controller-08 ~]# dsu

#. Stop all nodes on controller-08::

     sudo ansible-playbook -e "myhosts=${location}-controller-08 action=stop" lib/manage_nodes.yaml

#. Check that all nodes are shutoff on controller-08:

   .. code-block:: bash

     [root@osl-controller-08 ~]# virsh list --all
      Id   Name                    State
     ----------------------------------------
      -    osl-admin-01            shut off
      -    osl-builder-01          shut off
      -    osl-dashboard-mgmt-01   shut off
      -    osl-logger-01           shut off
      -    osl-login-02            shut off
      -    osl-monitor-01          shut off
      -    osl-proxy-01            shut off
      -    osl-resolver-02         shut off

#. Reboot controller-08:

   .. code-block:: bash

     [root@osl-controller-08 ~]# reboot

     
During maintenance window
~~~~~~~~~~~~~~~~~~~~~~~~~
     
#. Patch all nodes::

     sudo ansible-playbook --forks 30 -e "myhosts=${location}-nodes" lib/yumupdate.yaml

#. Check that all nodes are updated::

     sudo ansible-playbook --forks 30 -e "myhosts=${location}-nodes" lib/checkupdate.yaml

#. Patch all controllers::

     sudo ansible-playbook -e "myhosts=${location}-controller" lib/yumupdate.yaml

#. Check that all controllers are updated::

     sudo ansible-playbook -e "myhosts=${location}-controller" lib/checkupdate.yaml

#. Check status for cephmon-object::

     sudo ssh iaas@${location}-cephmon-object-01 'sudo ceph status'

#. Move routing for table private to nat-02 (c06) for osl-compute:

   - OSL::

       sudo ansible -m shell -a "ip route del default table private; ip route add default via 172.18.32.27 table private" osl-compute

   - BGO::

       sudo ansible -m shell -a "ip route del default table private; ip route add default via 172.18.0.27 table private" bgo-compute

#. move routing for resolver-01 (c07) to nat-02 (c06):

   - OSL:
   
     .. code-block:: bash

       [root@osl-resolver-01 ~]# ip route del default ; ip route add default via 172.18.32.27

   - BGO:

     .. code-block:: bash

       [root@bgo-resolver-01 ~]# ip route del default ; ip route add default via 172.18.0.27

#. Turn off nodes on controller-05::

     sudo ansible-playbook -e "myhosts=${location}-controller-05 action=stop" lib/manage_nodes.yaml

#. Check that all nodes on controller-05 are shut off:
   
   .. code-block:: bash

     [root@osl-controller-05 ~]# virsh list --all
      Id   Name                    State
     ----------------------------------------
      -    osl-api-01              shut off
      -    osl-cephmds-01          shut off
      -    osl-cephmon-object-01   shut off
      -    osl-db-global-01        shut off
      -    osl-db-regional-01      shut off
      -    osl-identity-01         shut off
      -    osl-image-01            shut off
      -    osl-mq-01               shut off
      -    osl-nat-01              shut off
      -    osl-network-01          shut off
      -    osl-novactrl-01         shut off
      -    osl-report-01           shut off
      -    osl-rgw-01              shut off
      -    osl-volume-01           shut off

#. Upgrade firmware on controller-05:

   .. code-block::

      [root@osl-controller-05 ~]# dsu

#. Reboot controller-05::

     sudo ansible-playbook -e "myhosts=${location}-controller-05" lib/reboot.yaml

#. Turn off nodes on controller-06::

     sudo ansible-playbook -e "myhosts=${location}-controller-06 action=stop" lib/manage_nodes.yaml

#. Check that all nodes on controller-06 are shut off:
   
   .. code-block:: bash

     [root@osl-controller-06 ~]# virsh list --all
      Id   Name                    State
     ----------------------------------------
      -    osl-cephmds-02          shut off
      -    osl-cephmon-object-02   shut off
      -    osl-dashboard-01        shut off
      -    osl-dns-01              shut off
      -    osl-identity-02         shut off
      -    osl-image-02            shut off
      -    osl-nat-02              shut off
      -    osl-network-02          shut off
      -    osl-novactrl-02         shut off
      -    osl-ns-01               shut off
      -    osl-rgw-02              shut off
      -    osl-status-01           shut off
      -    osl-volume-02           shut off

#. Upgrade firmware on controller-06:

   .. code-block::

      [root@osl-controller-06 ~]# dsu

#. Reboot controller-06::

     sudo ansible-playbook -e "myhosts=${location}-controller-06" lib/reboot.yaml

#. Turn off nodes on controller-07::

     sudo ansible-playbook -e "myhosts=${location}-controller-07 action=stop" lib/manage_nodes.yaml

#. Check that all nodes on controller-07 are shut off:
   
   .. code-block:: bash

     [root@osl-controller-07 ~]# virsh list --all
      Id   Name                    State
     ----------------------------------------
      -    osl-access-01           shut off
      -    osl-cephmds-03          shut off
      -    osl-cephmon-object-03   shut off
      -    osl-console-01          shut off
      -    osl-identity-03         shut off
      -    osl-image-03            shut off
      -    osl-metric-01           shut off
      -    osl-network-03          shut off
      -    osl-novactrl-03         shut off
      -    osl-proxy-02            shut off
      -    osl-resolver-01         shut off
      -    osl-rgw-03              shut off
      -    osl-telemetry-01        shut off

#. Upgrade firmware on controller-07:

   .. code-block::

      [root@osl-controller-07 ~]# dsu

#. Reboot controller-07 (must be done manually):

   .. code-block:: bash

     [root@osl-controller-07 ~]# reboot

