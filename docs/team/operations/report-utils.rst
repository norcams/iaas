============
Report UTILS
============

Last updated: 2021-06-18


The clients (as set up on NREC GOLD images) are set up with a systemd service
set, which downloads and run a script. The script collects data about the
instance and reports back to the `Report API`. The data collected include kernel
versions, uptime and so on.

Implementation - client (instance)
----------------------------------

The GOLD images get a wrapper script (*/usr/local/sbin/report_wrapper.h*) installed
together with a systemd.service (*report.service*) and timer (*service.timer*).
The timer starts the service at intervals, which again executes the wrapper
script. The only job of this is to download the latest version of the
*report.sh* script and execute it.

The *report*-script is the collector, which get all the data and delivers it to
the API.


report script distribution
--------------------------

As mentioned above, the wrapper script (started by systemd) donwloads the actual
report script from a web service on the report nodes (mainly ``bgo-report-01``).
This service was previously set up by a separate git module
(**norcams/report-utils**). This is now OBSOLETE, and the service is set up by
Puppet and configured through hieradata.


puppet code
\\\\\\\\\\\

The web serving area, containing all the scripts and links, is set up by the
Puppet code in ``profile/manifest/applications/report.pp``. It mainly creates
directories, scripts and links as configured in the variable *report_utils* (see
below). The content of the files is fetched from files contained in the Puppet
module, and ordered as configured in the variable.


Script code
\\\\\\\\\\\

The scripts are joined fragments, which are all stored inside the modules
`files` are (``profile/files/application/report``). The fragment to select is set
up in the *report_utils* variable, including any sub directories from this point
on. The ordering is relevant!


Configuration
\\\\\\\\\\\\\

Most set up is configured through the variable **report_utils**. Mainly using
Hieradata: *profile::application::report::report_utils* in the *report.yaml*
role file.

Structure
`````````

.. parsed-literal::
   <distribution>:
     scripts:
       <script name>: [ '<array of fragments in correct order>', '...' ]
       <...>:         [ ...]
     versions:
       <dist version>: <script name>
       <...>:          <script name>
   <...>


distributions:
  (short) name of OS/distribution (e.g. `el`, `ubuntu` and `windows`)
  This will create a directory hiearchy directly on the web service root

scripts:
  Builds the scripts

  * **keys**:  Describes the contents of a script created directly under the distribution sub directory
  * **value**: Lists the code fragments which forms the report script

versions:
  Creates the symbolic links for each version, pointing to the appropriate real
  script.

  * **keys**:  Creates a link `<distribution>/<key>/<app version>/report
  * **value**: The physical name under distribution root which to link to


Other configuration variables
`````````````````````````````

- *app_downloaddir* (default: '/opt/report-utils')

  Top web service directory.

- *app_version* (default: 'v1')

  One of the directory parts will contain this.
  Used if a new API version emerges.

- *report_linkname* (default 'report')

  The name of the links.
  This is what the clients will request.

