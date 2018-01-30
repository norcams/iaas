Building puppet-agent for PPC-based Cumulus Linux
=================================================

Puppet bruker sitt eget byggeverktøy kalt Vanagon for puppet-agent. Det kjøres
mot en remote target, i vårt tilfelle en Debian Wheezy installasjon for
PowerPC, En versjon som kan kjøres i qemu kan lastes ned fra
http://folk.uib.no/ava009/debian_wheezy_ppc.img.tar.gz
(0c27128c6ea2dad8f6d9cb8364e378a7). Jeg bruker en gammel Powerbook G4 til
formålet, som går betraktelig raskere enn emulering.

Vanagon forsøker å ssh'e som root til target, imaget over tillater dette (med
passord).

For å bygge for Debian 7 PPC, trenger er en gcc, boost, cmake, yaml-cpp,
gettext og binutils i riktige versjoner. En får disse ved å klone
https://github.com/norcams/pl-build-tools-vanagon, bygge verktøyene med Vanagon
og installere dem på target hvor puppet-agent skal bygges. Plattformen heter
debian-7-powerpc (denne finnes kun i norcams-fork).

Deretter kloner en https://github.com/norcams/puppet-agent og bygger for
debian-7-powerpc.
