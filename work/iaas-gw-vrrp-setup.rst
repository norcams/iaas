VRRP setup on IaaS gateways
===========================

Shutdown the uplink interface
-----------------------------

.. code-block:: bash

  sudo ifdown swp48

Install packages
----------------

.. code-block:: bash

  sudo apt-get update
  sudo apt-get install -y vrrpd ifplugd

Configure the VRRP interface
----------------------------

Adjust IPs and routes as needed, this is just an example.

*/etc/network/interfaces*

.. code-block:: bash

  auto swp48
  iface swp48
      address 129.241.77.76/29
      up ifplugd -i $IFACE -b -d1 -p
      up ip route add default via 129.241.77.73
      post-up vrrpd -n -D -i $IFACE -v 1 -p 120 129.241.77.78
      pre-down kill $(cat /var/run/vrrpd_$IFACE_*.pid)
      down ifplugd -k -i $IFACE

The vrrpd *-p* option specifies *priority* of this host in the virtual
server and must be different on each gateway. We suggest using 120 and
100 as values.

Configure ifplugd
-----------------

This will configure *ifplugd* to to react as needed when link UP or DOWN
events are detected.

Disable execution of the default ifupdown script

.. code-block:: bash

  sudo chmod 0644 /etc/ifplugd/action.d/ifupdown

Create a file */etc/ifplugd/action.d/ifupdown-vrrp*

.. code-block:: bash

  #! /bin/bash
  #
  # $1 - interface name
  # $2 - up or down

  TMPFILE=/tmp/ifplugd.$1.tmp

  case $2 in
        down)   ip addr flush dev $1
                kill $(cat /var/run/vrrpd_${1}_*.pid 2>/dev/null) 2>/dev/null
                ;;
        up)     ifquery $1 > $TMPFILE
                ip addr add $(sed -n "s/^\s*address//p" $TMPFILE) dev $1
                ip route $(sed -n "s/^\s*up\ ip\ route//p" $TMPFILE)
                vrrpd $(sed -n "s/^\s*post-up\ vrrpd//p" $TMPFILE)
                rm -f $TMPFILE
                ;;
  esac

  exit 0

Make it executable

.. code-block:: bash

  sudo chmod 0755 /etc/ifplugd/action.d/ifupdown-vrrp

Start the interface
-------------------

.. code-block:: bash

  sudo ifup swp48
