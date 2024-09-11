Customizing the OpenStack Horizon Dashboard theme
=================================================

How to install a custom theme [#f1]_.

Created a custom theme, based on the SUSE branding for the OpenStack Horizon dashboard [#f2]_: ``nrec-darkblue-theme.tar``.

.. code-block:: console
   
   cd /usr/share/openstack-dashboard/openstack_dashboard/local/local_settings.d/
   cp _10_set_custom_theme.py.example _10_set_custom_theme.py
   vim _10_set_custom_theme.py
   edit _10_set_custom_theme.py as below
   cd /usr/share/openstack-dashboard/openstack_dashboard/themes
   # rsync and untar nrec-darkblue-theme.tar here, creating the folder darkblue
   systemctl restart httpd

_10_set_custom_theme.py:

.. code-block:: console

   # override the AVAILABLE_THEMES variable with this settings snippet
   AVAILABLE_THEMES=[
         ('default', 'Default', 'themes/default'),
         ('darkblue', 'Dark Blue', 'themes/darkblue'),
         ('material', 'Material', 'themes/material')
   ]
   SITE_BRANDING = 'NREC'
   DEFAULT_THEME = 'darkblue'

default and material are the existing themes, while darkblue is the new theme.
Most of the customizations, such as colors are specified in ``darkblue/static/_variables.scss``.

.. figure:: ../images/darkblue-horizon-theme.png
	 :align: center
	 :figwidth: image

	 Figure 1: Screenshot of the Horizon dashboard with the darkblue theme enabled.

.. rubric:: Footnotes

.. [#f1] https://docs.openstack.org/horizon/latest/configuration/themes.html

.. [#f2] https://github.com/SUSE/openstack-dashboard-theme-SUSE

