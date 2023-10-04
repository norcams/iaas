==============================
2FA on jumphosts (login nodes)
==============================

As an extra securiy measure there is now implemented Two-factor authentication for
access to the login nodes, and thus the management network. The two components
used are 

- SSH keys and
- TOTP

The latter by using the Google Authenticator mobile (or compatible) app on the client side.


Basic procedure for access
==========================

To get access to the internal infrastructure one has to first go through any of
the login nodes:

- osl-login-01.iaas.uio.no
- bgo-login-01.iaas.uib.no


All user logins must be authenticated by providing *two* independent components:

1. SSH key exchange
2. TOTP verification code

The public part of the user SSH key is provisioned using Puppet by publisizing
the key in `hieradata`. In addition the user must be allocated membership of the *wheel* group.

The TOTP setup is done by executing `/usr/bin/google-authenticator`.

From this point on any login for this account requires a verification code (in
addition to the automatic exchange of relevant SSH keys). [1]_


Step-by-step setup
==================


- add SSH public key to hieradata:
    file: `common/modules/accounts.yaml`

    key: ``accounts::ssh_keys``

- set up user to become member of the *wheel* group:
    file: as above

    key: ``accounts::users``

- ensure the account is created on hosts with the login role:
    file: `common/roles/login.yaml`

    key: ``accounts::accounts``

- on login nodes, as the user after the account is created:

  1. execute **google-authenticator** and reply to the questions

       Recommended answers:
  
       - Do you want authentication tokens to be time-based (y/n) **y**
  
       - Do you want me to update your "/home/i<user name>/.google_authenticator" file(y/n) **y**
  
       - Do you want to disallow multiple uses of the same authentication
         token? This restricts you to one login about every 30s, but it increases
         your chances to notice or even prevent man-in-the-middle attacks (y/n) **n**
  
       - By default, tokens are good for 30 seconds and in order to compensate for
         possible time-skew between the client and the server, we allow an extra
         token before and after the current time. If you experience problems with poor
         time synchronization, you can increase the window from its default
         size of 1:30min to about 4min. Do you want to do so (y/n) **n**
  
       - If the computer that you are logging into isn't hardened against brute-force
         login attempts, you can enable rate-limiting for the authentication module.
         By default, this limits attackers to no more than 3 login attempts every 30s.
         Do you want to enable rate-limiting (y/n) **y**

   2. Provide the user with the secret key which is printed, the QR code drawn or
      the URL displayed - all after the initial question.

   3. Install a TOTP client application on any of the compatibel user devices
      (mobile phone, tablets etc). Recommended application is *Google
      Authenticator*.

   4. In the TOTP application set up a new account following its instructions.
      The easiest method is if the app provides a mean to configure it through
      scanning a QR code and the user can be shown the QR code drawn during
      server initialization, alternatively using the URL. Otherwise enter the secret key printed.



Login procedure
===============

1. log in to a login node from an account with access to the private part of the SSH key
   provided

2. when prompted start the TOTP/2FA application on the user device and enter the
   6 digits displayed

3. login should be successfull


.. Important::
   It is paramount that the user device and the login node are in sync with
   regards to time!


Transfer to new device
======================

If the previous device is lost, then the set up procedure should be repeated to
configure a *new* code. But in those cases where a new device (mainly a phone)
is purchased etc, and one still has full control of the old, it is possible to
recreate the required QR-code like this:

#. username=<username>
#. location=osl  (or location=bgo)
#. secret=$(sudo head -1 /home/${username}/.google_authenticator)
#. qrencode -o $username.png -s 5 -lM "otpauth://totp/${location}-login-01?secret=$secret"
#. display ${username}.png
#. rm ${username}.png

.. NOTE::
   Remember to do this on both login nodes!

Emergency code
==============

If the situation should arise where the user does not have access to the device
where the 2FA application is installed, he/she can log in using any of the one
time passcodes created duirng setup:

- someone with access to the user configuration file [2]_ must retrieve one of the
  passcodes listed at the bottom

- log in as usual but enter the retrieved emergency code in place of a proper
  verification code

- after a successful login this particular emergency code is rendered invalid



.. [1] In the initial set up phase - to enable exisitng users to convert to
       2FA - access through SSH keys only is allowed. The "switch" for this
       is the availability of the user configuration file.
       To disable this behaviour remove the option `nullok` from any line in
       `/etc/pam.d/google-authenticator-wheel-only` (though
       hieradata: `common/roles/login.yaml` and key ``googleauthenticator::pam::mode::modes:``).
.. [2] Default ``$home/.google_authenticator``
