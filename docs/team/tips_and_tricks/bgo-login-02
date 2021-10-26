======================================
Installasjon/bootstrap av bgo-login-02
======================================

Hvis man vil ha en ekstra login-node i BGO (virtuell i admin-laget) så er det forberedt for en slik *bgo-login-02*. Selve installasjonen er standard (data ligger i himlarcli). Men en del ekstra punkter som må tas hensyn til eller utføres:

*  Node installeres. Nett konfes men mye foreløpig kun "eksempelvis" (test01 feks), en del må trekkes inn på controller først før aktivt.
*  Etter at noden er installert så legg på et tredje interface koblet mot ``br3``. Inntil dette er gjort vil puppet feile.
   **OBS**: IKKE bli fristet til å lage dette interfacet før maskinen er oppe, da feiler det av for oss ukjente årsaker!
*  Når den installeres så avkommenter aktuell del i node-fil som muliggjør innlogging uten 2FA.
   Dette inntil brukere har kunnet sette opp dette for sine kontoer. Hver bruker kan velge å sette opp ny eller kopiere `Google Authenticator`-filen
   (~/.google_autehnticator) fra bgo-login-01.
*  Det er også en mulighet å sette opp iaas-brukeren i den første perioden.
   Begge disse to er det kode for i node-filen, det må bare avkommenteres/aktiveres inntil det igjen disables.
*  Noden er en del av `gitolite-clusteret`, men foreløpig uten aktiv sync (*nosync*-endelsen i gitolite-konfigen), slik at man må kjøre **gitolite push**
   når nødevndig som dokumentert.
*  `git`-bruker må få laget SSH-nøkkel, som så må inn i gitolite (erstatte nåværende). Deretter må gitoliten-noden `bootstrappes som dokumentert<https://iaas.readthedocs.io/team/operations/gitolite.html>`_ (veldig enkelt operasjon).
*  Maskinen er forberedt på å være del av repo-clusteret (**secrets-sync.sh**).
   Første gang må sync initieres fra master (``osl-login-01``), deretter kan sync initieres fra hvilken node som helst.
   * Slaver (bgo-nodene) syncer til/fra master (osl).
   * Master (osl) syncer til/fra begge, først 01, deretter 02.
     Man kan for hver node velge om man vil synce eller hoppe over.


