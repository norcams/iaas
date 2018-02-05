Building puppet-agent for PPC-based Cumulus Linux
=================================================

Puppet bruker sitt eget byggeverktøy kalt Vanagon for puppet-agent. Det kjøres
mot en remote target, i vårt tilfelle en Debian Wheezy installasjon for
PowerPC. En versjon som kan kjøres i qemu kan lastes ned fra
http://folk.uib.no/ava009/debian_wheezy_ppc.img.tar.gz
(0c27128c6ea2dad8f6d9cb8364e378a7). Er en i bestittelse av en fysisk
PowerPC-basert maskin (f.eks. en gammel Mac) vil byggingen gå betraktelig
raskere der.

Vanagon forsøker å SSH'e som root til target, imaget over tillater dette (med
passord). En kan også lage en SSH-nøkkel som man legger inn hos root-brukeren
på byggeboksen. Sett så VANAGON_SSH_KEY=<full-sti-til-privatnøkkel> hvor du
kjører Vanagon.

For å bygge for Debian 7 PPC trenger er en gcc, boost, cmake, yaml-cpp,
gettext og binutils i riktige versjoner. En får disse ved å klone
https://github.com/norcams/pl-build-tools-vanagon, bygge verktøyene med Vanagon
og installere dem på target hvor puppet-agent skal bygges. Plattformen heter
debian-7-powerpc (finnes kun i norcams-fork).

Deretter kloner en https://github.com/norcams/puppet-agent, sjekker ut branchen
1.10.9-powerpc og bygger for debian-7-powerpc (kun i i norcams-fork).
