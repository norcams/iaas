=======================================
Gitolite / local Git repository cluster
=======================================

.. IMPORTANT::
   This is basically a document describing how to add a new node into the
   cluster, and as such assumes an already existing and useful master node.


Due to security or privacy issues, some repositories are hosted internally
instead of on *Github*. The hosts consists of the login nodes, with
``osl-login-01`` normally being the master and the other node(s) acting as
mirrors (slaves).

*Gitolite* is initialized by Puppet, using the `gitolite` module. This installs
the package and set up a *git* user. Additionally an admin is configured, with
an SSH public key as specified in hieradata (**module/gitolite.yaml**).

All nodes participating in the cluster must be listed in the `git` user specific
SSH options file, as *gitolite* makes extensive use of short names. Additionally
this user must be able to log in to each gitolite administered node using
*publickey* only. As the login nodes have Two factor authentication (TOTP and
publickey) the user and relevant nodes must be exempted.

**profile::base::common::users_ssh_options** (*common/roles/login.yaml*) should
have an entry for each host with a suitable short name.

**ssh::server::options** (*<loc>/roles/login.yaml*) should have an entry for
each of the nodes IP addresses allowing ``publickey`` only for the `git` user.

.. NOTE::
   osl-login-01 is a *bastard* and not fully configured by Puppet. This node may
   have to have it sshd configuration adapted by manual means.


gitolite configuration
----------------------

For each new mirror add this for the ``@all`` pseudo repo in
**conf/gitolite.conf** in the *gitolite* repository::

  RW+     =   server-<shortname>
  option mirror.copies.nosync = <shortname>

  or


<shortname> = short name used for server in SSH configuration

.. NOTE::
   The option contaning `nosync` should be used initially until the cluster is
   complete. The option exempts the slave from automatic push fr om master, and
   avoids error messages (to any user pushing whatever) until the slave is
   ready. Until this push any changes manually with the command described in the
   node bootstraping section.

   When everything is set up, complete the gitolite configuration:

   option mirror.copies.nosync = <shortname> -> option mirror.copies-# = <shortname>

   where # = a uniq number


Bootstraping the gitolite service
---------------------------------

As configured by Puppet after new node is installed, the gitolite service is
a local only service with one administrator (as set up in hieradata). To get it
to accept push from master, add this to **~git/.gitolite/conf/gitolite.conf**
for the ``gitolite-admin`` stanza (repo)::

  option mirror.master = osl
  option mirror.copies.nosync = <shortname>

<shortname> is short name for local system as entered in SSH configuration.
This example assumes *osl* is shortname of master. Adapt as necessary.

Afterwards activate the new set up like this::

  gitolite setup


At this stage the slave is still running with the initial (local) repositories only, but it will now accept
push from master. Update the mirror like this::

  [git@osl-login-01 ~] for repo in `gitolite list-phy-repos`; do gitolite mirror push <shortname> $repo; done

.. IMPORTANT::
   Since the configuration is basically data in a (special) repository **gitolite-admin** even the configuration
   will be overwritten! Make sure the central cluster configuration is
   up-to-date with the new node before this step.

