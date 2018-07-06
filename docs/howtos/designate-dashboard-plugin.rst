How to create the designate-dashboard RPM package
=================================================

#. Install tools::
    
      yum install rpm-build

#. Get designate-dashboard from GitHub::

      git clone https://github.com/openstack/designate-dashboard.git
      cd designate-dashboard
      git checkout stable/pike

#. Build RPM::

      python setup.py bdist_rpm

