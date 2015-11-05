===============================================
VAULT som SAFE og henting av data med envconsul
===============================================

Notater rundt installasjon, oppsett og grunnleggende bruk av `vault` som
"safe". Tanken er å kjøre `consul` som lagringsbackend. I tillegg er det
noen linjer rundt `envconsul`; hvordan hente verdier fra
vault/consul-komboen og bruke som verdier i andre applikasjoner.

Alt som står her er for test/POC-anvendelse!



VAULT
=====

.. ATTENTION::
   Forutsetter maskin med kjørende consul (hver vault-instans binder seg til
   consul lokalt i det oppsett som er beskrevet her). 'consul' kjører i et 
   cluster innenfor datasenteret.



`vault` er en enkelstående binær som kan hentes herfra::

  `vault 0.3.1 for Linux x86_64 <https://releases.hashicorp.com/vault/0.3.1/vault_0.3.1_linux_amd64.zip>`_

Kan selvsagt kompileres selv hvis man vil føle seg mer sikker.


Startes slik::

  vault -config <config> server
  
Konfigurasjonseksempel (se i `vault.hcl`)::
  
    backend "consul" {
      address = "127.0.0.1:8500"
      path = "vault"
    }
    
    listener "tcp" {
      address = ":8200"
      tls_disable = 1
    }


.. IMPORTANT::
   I produksjon selvsagt med tls aktivert. Må da generere sertifikater og nøkler.


Dette vil kjøre den i forgrunn. I annen terminal sjekk status::

  vault status -address=http://127.0.0.1:8200

Hvis første instans så er den ikke-initialisert. Før bruk må en av
instansene initialisers slik::

  vault init -address=http://127.0.0.1:8200

Dette gir som output nøkler for å bryte forseglingen samt en initiell
token for aksess (konto=`root`). Feks::

   Key 1: d80774d7bd88a330121d9b83998db38e03d75768c0e847bcc58bfc8c2b63989901
   Key 2: da33fba02fa722eea19c4552f52bd13b2e41a2441951794dffae1c957263517202
   Key 3: 2c3e9fc445c89c153e2a05106b385bf054444dcf33312d197507ef8817c9604603
   Key 4: d1f451d48c29188cf1de84a0819543586dbddd28bd45e28dfe18bc61c33f1ce204
   Key 5: 27f935b0e646a6776e68c4e21f86c99317b832a39725b6d974b14f7ca6952dd605
   Initial Root Token: 225eb5e2-5adc-be4d-2f3e-bbe331a577db


Kontoen `root` er innebygget og har en policy som gir både skrive- og
lese-tilgang til alt.


.. TIP::

   Sett miljøvariabel for å slippe å angi "-adress="-parameter ti hver kommando:
  
     *export VAULT_ADDR=http://127.0.0.1:8200*
  
   Sett miljøvariabel for autentisering:
  
     *export VAULT_TOKEN=225eb5e2-5adc-be4d-2f3e-bbe331a577db  (bytt med aktuell token)*


For å bruke en gitt vault-instans må forseglingen brytes::

  vault unseal

Det vil bli spurt om en av nøklene. Angi en av disse fra listen.
Deretter vil status på forseglingen angis. Prosedyren må repeteres 2
ganger til (hvilket ikke må utføres på samme system, så lenge det
kommuniseres mot den samme `vault`-instansen), hver gang med en ny
nøkkel fra listen. Når 3 unike nøkler er gitt vil instansen ikke lenger
være forseglet.


Når bruken er ferdig så forsegles instansen slik::

  vault seal



.. NOTE::
   Dersom initialisert fra før og minst en consul-instans i miljøet ennå
   eksisterer fra den tid så slett alle data fra denne før vault startes på
   nytt dersom man ikke lenger har nøkler:

     *curl -X DELETE http://localhost:8500/v1/kv/?recurse*




Sjekke tilstanden::

 vault read /sys/health

 Status Codes:

    200 if initialized, unsealed and active.
    429 if unsealed and standby.
    500 if not initialized or sealed.

 curl -sw '%{http_code}' -X GET http://127.0.0.1:8200/v1/sys/health




Eksempel på bruk
----------------

::

 POLICY='key "" { policy = "read" }'
 echo $POLICY | base64 | vault write consul/roles/readonly policy=-

Etterpå på vilkårlig unseal'ed vault-instans::

 vault read consul/roles/readonly | grep ^policy | cut -f2 | base64 -d

.. NOTE::
   'policies' forventes å være base64-kodet. Andre nøkler ikke.



envconsul
=========


Som for vault kan denne hentes ferdigkompilert eller kompileres selv fra github
(krever Go). Binær::

  `envconsul 0.6.0 for Linux x86_64<https://github.com/hashicorp/envconsul/releases/download/v0.6.0/envconsul_0.6.0_linux_amd64.zip>`_

Består kun av en enkeltstående binærfil.


Eksempel på bruk for å hente verdien lagret over og skrive ut miljøvariablene
inklusive de som ble hentet::

  envconsul -consul=<consul-IP>:8500 -secret consul/roles/readonly env

**Merk**: base64-dekodingen kun fordi akkurat denne nøkkelen lagres base64-kodet,
dette er ikke det normale. For å lese verdien i klartekst og bekrefte::

  envconsul -consul=<consul-IP>:8500 -secret consul/roles/readonly env | grep ^consul_roles_readonly_policy | cut -f2 -d= | base64 -d


**Merk**: dette krever at vault-instansen man snakker med ikke er
forseglet (dvs. ``vault status`` gir *Sealed: false*)! 

**Merk**: man
snakker uansett egentlig med den aktive vault-instansen
(ikke en i standby-modus, hvilket kan sees fra status-kommandoen til
vault). 


Arkitektur lokalt
=================

Tanker:

- consul:

  - som server på alle controller-noder
  - som agent på alle øvrige
  - hvert datasenter sitt eget cluster, med `consul-replicate` (feks.) til å replikere mellom sentrene

- vault:

  - på controller-noder?
  - har felles konfigurasjon hvor `consul` på localhost er satt som backend
  - provisjonering kan installere, konfigurere og starte vault
  - evt. initialisering aller første gang samt enhver bruting av forseglingen gjøres manuelt

