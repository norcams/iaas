============================
Platform extension in Himlar
============================

Last changed: 2021-05-07

New ``hiera.yaml``:

.. code-block:: yaml

  - "secrets/nodes/%{::verified_host}.secrets.yaml"
  - "secrets/%{::location}-common.secrets.yaml"

  - "nodes/%{::location}/%{::verified_host}.yaml"

  #- "%{::location}/arch/%{::arch}.yaml"
  - "%{::location}/platform/%{::os}_%{os_version}.yaml"
  - "%{::location}/platform/%{::os}.yaml"
  - "%{::location}/roles/%{::role}-%{::variant}.yaml"
  - "%{::location}/roles/%{::role}.yaml"
  - "%{::location}/modules/*.yaml"
  - "%{::location}/common.yaml"

  #- "common/arch/%{::arch}.yaml"
  - "common/platform/%{::os}_%{os_version}.yaml"
  - "common/platform/%{::os}.yaml"
  - "common/roles/%{::role}-%{::variant}.yaml"
  - "common/roles/%{::role}.yaml"
  - "common/modules/*.yaml"
  - "common/common.yaml"

Example:
--------

arch = [ ``x86_64`` | ``aarch64`` | ``ppc64le`` | ``powerpc`` ]

os = [ ``ubuntu`` | ``el`` | ``cumulus`` | ``sonic`` ]

os_version = [ ``2004`` | ``7`` | ``8`` | ``10`` ]
