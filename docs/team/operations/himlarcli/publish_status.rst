================================================================
Publish status messages to Slack, Twitter and UH-IaaS status API
================================================================

Help
====

Publishing to all our communication channels is done by using a simple script
called publish_notify.py. Get usage info with the :file:`-h` option.
E.G::

  ./publish_status.py -h
  ./publish_status.py important -h
  ./publish_status.py info -h
  ./publish_status.py event -h

There are currently three commands:

* **important** will publish to Slack, Twitter and the status database displayed on
  status.uh-iaas.no. Use for important messages about events that will directly
  or indirectly affect users, like planned outages.  
* **info** will publish to Twitter and status database. Use for informal messages,
  of general interest, like if there's a new service or image available. 
* **event** will publish to the event database, which is mostly intended for 
  internal usage. Use for technical details about events that affected
  availability, stability, user experience etc. Publically available via API but
  not displayed on our status pages. 

Example usage
=============

The following example will publish an important status message to Slack,
Twitter and status API. It will be tagged 'important' in the status API,
meaning it will show up under "New issues and warnings" in our Grafana
dashboard. The `-l` option will add a single whitespace and a hardcoded message
linking to our status dashboard on messages going to Slack and Twitter::

  $ ./publish_status.py important -m "We're currently having some issues. Sorry for the inconvenience." -l

Which will return::

  The following message will be published: We're currently having some issues. Sorry for the inconvenience. For live updates visit https://status.uh-iaas.no
  Are you sure you want to publish? (yes|no)?

This has to be interactively confirmed by typing `yes`. Notice that you should
always use punctuation after the last sentence in your message or template.

This example uses a pre-made template instead of a command-line argument as
message, replacing the variables `$date` and `$region` with `-d` and `-r`::

  ./publish_status.py important -t ./misc/notify_maintenance.txt -r bgo -d 'September 20 between 15:00 and 16:00'

Which will return::

  The following message will be published: Services will be unavailable on September 20 between 15:00 and 16:00 in BGO due to maintenance. Running instances will not be affected.
  Are you sure you want to publish? (yes|no)?

This example will publish an info message about a new image on Twitter and
status API. It will be tagged 'info' in the status API, meaning it will show up
under "News" in our Grafana dashboard::

 ./publish_status info -m 'New image Fedora 28 is availible."
