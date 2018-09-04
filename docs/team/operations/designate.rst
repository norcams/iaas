=========================
OpenStack Designate (DNS)
=========================

.. WARNING::
   This document is under construction. Designate is not yet in
   production.

Managing top-level domains (TLDs)
=================================

.. _Internet Assigned Numbers Authority (IANA): https://www.iana.org/

We manage a list of legal top-level domains, in which the users can
create their zones. With such a list in place, zones may only be
created with the TLDs listed there. Without such a list, any TLD would
be legal, and users could also register zones such as "com", thus
preventing any other user to create a domain under the ".com" TLD.

A list of all valid top-level domains is maintained by the `Internet
Assigned Numbers Authority (IANA)`_ and is updated from time to
time. The list is available here:

* http://data.iana.org/TLD/tlds-alpha-by-domain.txt

This list can be imported into Designate via the himlarcli
command **dns.py**:

.. parsed-literal::
  
  $ **curl http://data.iana.org/TLD/tlds-alpha-by-domain.txt -o /tmp/tlds-alpha-by-domain.txt**
  $ **./dns.py tld_import --file /tmp/tlds-alpha-by-domain.txt**

The **tld_import** action will add any TLDs which aren't already
registered, with a special comment that marks the TLD as being bulk
imported. Any registered TLDs that aren't on the import list, and also
have the special bulk import comment, will be deleted. This means that
we can add our own TLDs if needed, as they will not be deleted by the
bulk import. The bulk import as show above is designed to run
automatically by cron etc.

The himlarcli command also have actions to create, delete and update a
TLD, and to view the list or a specific TLD.


Managing blacklists
===================

Blacklisting is done to prevent users from creating domains that we
don't want them to create. This is mostly done to protect a domain
from eventual future use. In order to prevent any users from creating
the domain **foo.com** and any subdomains:

.. parsed-literal::

  $ **./dns.py blacklist_create \\
      --comment 'Protect domain foo.com including subdomains' \\
      --pattern '^([A-Za-z0-9_\\\\-]+\.)\\*foo\\.com\\.$'**

If we want to only protect the domain itself, but allow users to
create subdomains in the domain, we can use a simpler pattern:

.. parsed-literal::

  $ **./dns.py blacklist_create \\
      --comment 'Protect domain foo.com allowing subdomains' \\
      --pattern '^foo\\.com\\.$'**

