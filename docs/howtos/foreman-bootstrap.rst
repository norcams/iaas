Hvordan bootstrap'e en Foreman-instans
======================================

Her beskrives hvordan et nytt miljø initialiseres ut fra en enslig fungerende
*login*-node. Øvrige bokser er fysisk installert (inklusive oppsett av
`BIOS`/`iDrac`) men forøvrig urørt.


Forutsetninger
--------------

- fungerende login-node (med oppdatert */opt/[himlar|repo]*-kataloger)
- maskinen er konfigurert med `puppet`
- ingen management-node er satt opp (`controller`)
- *hieradata/<loc>/common.yaml* er populert med aktuelle node-adressedata
- alle kommandoer kjøres som `root`


Prosedyre
---------

1. På login-node: **/usr/local/sbin/bootstrap-<loc>-controller-01.sh**
   
   .. NOTE::
      Feilmeldingen "curl: (33) HTTP server doesn't seem to support byte
      ranges. Cannot resume." er ufarlig dersom skriptet er kjørt også
      tidligere, da det betyr at filene som hentes allerede finnes lokalt.

#. Boot aktuell fysisk node
   Feks. via web-GUI mot `iDrac` eller kommandolinje på login-node:

        **idracadm -r <idrac-IP for kommende <loc>-controller-01> -u gaussian -p <idrac-pw> serveraction powercycle**

   .. NOTE::
      Sørg for at maskinen PXE-booter primært ved første boot!

#. Når ny kontroller er ferdig installert, må skriptet i punkt 1) stoppes dersom
   maskinen har PXE permanent satt som primær boot-metode (ellers blir det evig
   reinstallasjon)

#. Logg inn på ny kontroller-node

#. **/opt/himlar/provision/puppetrun.sh**

#. Åpne for trafikk mot port 8000:

   **iptables -I INPUT 1 -p tcp --dport 8000 -j ACCEPT**

#. **/usr/local/sbin/bootstrap-<loc>-foreman-01.sh**

   1. **virsh list** skal nå liste foreman-instansen som kjørende.
   #. Installasjonen kan monitoreres med VNC: **vncviewer <loc>-controller.01....**
      (bruk den vnc-viewer som foretrekkes)
   #. Meldingen "*Guest installation complete... restarting guest.*" kommer i
      terminalen skriptet ble kjørt i når installasjonen er klar.
   #. Installasjonen kan  sjekkes med **ssh iaas@<loc>-foreman-01...** fra
      login-noden.

#. Når installasjonen er klar kan trafikk mot port 8000 igjen sperres på
   kontroller-noden: **iptables -D INPUT 1**

#. Sync over */opt/repo* fra login-node til foreman-noden (husk å fikse
   `eier:gruppe` hvis aktuelt, skal være `root:root`)

#. Logg inn på ``foreman``-maskin fra login-noden (bruker `iaas` + sudo),
   sjekk gjerne logg fra installasjonen (*/root/install.post.log*)

#. **HIMLAR_CERTNAME=<certname> /opt/himlar/provision/puppetrun.sh**

   Kjør gjerne flere ganger.

#. **/opt/himlar/provision/foreman-settings.sh**

Nå skal det være en Foreman-instans kjørende som det kan logges inn i
GUI på (http/https). Denne kjører da i en egen virtuell libvirt-instans på den fysiske
kontroller-noden.


Etter Foreman-installasjon
--------------------------

Man bør få inn kontroller-noden i Foreman og få registrert denne som en *compute
resource* slik at man kan installere andre systemer som feks. master-noden, i
tillegg til å få registrert Foreman selv som kjørende her.

1. På kontroller-noden, kjør **puppet apply --test** et par ganger
#. I Foreman signer evt. sertifikatet dersom det står som pending
#. På Foreman-noden **/etc/puppet/node.rb --push-facts** (nødvendig?)
#. I Foreman-GUI registrer en ny libvirt-ressurs:

   a. ``Infrastructure -> Compute resources``
   #. ``New compute resource``
   #. :Name: hva man vil
      :Provider: Libvirt
      :URL: qemu+tcp://<loc>-controller-01.iaas.uio.no:16509/system
      :Display type: VNC

   #. Test gjerne forbindelsen: ``Test connection``
   #. ``Submit``

#. Klikk inn på den nye ressursen og gå til fanen `Virtual machines`;
   Foreman-noden skal nå automatisk være registrert her.

