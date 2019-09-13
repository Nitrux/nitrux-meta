#! /bin/sh

apt-get --yes update
apt-get --yes install wget equivs curl git

cd package/

DEPENDS=$( echo $(sed -e '/^#.*$/d; /^$/d; /^[[:space:]].*$/d' dependencies) | tr ' ' ',')

GIT_COMMIT=$(git rev-parse --short HEAD)

echo "
Section: misc
Priority: optional
Homepage: https://nxos.org
Package: nx-desktop
Version: 1.4.9.6-${GIT_COMMIT}
Maintainer: Uri Herrera <uri_herrera@nxos.org>
Depends: $DEPENDS
Architecture: amd64
Description: NX Desktop metapackage for Nitrux.
" > configuration

equivs-build configuration
