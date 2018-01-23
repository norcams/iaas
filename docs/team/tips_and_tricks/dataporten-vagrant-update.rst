===============================
Dataporten in vagrant (updates)
===============================

If you create or edit Dataporten's Client ID and Client Secret from Oauth details while vagrant identity and access are up, 
you need to restart httpd, in addition to rsync and provision on both identity and access.

E.g.
- ssh access
- systemctl restart httpd
