#! /bin/sh

apt -qq update
apt -qq -yy install equivs curl git

git config --global --add safe.directory /home/travis/build/Nitrux/nx-desktop

deps=$(sed -e '/^#.*$/d; /^$/d; /^\s*$/d' package/dependencies | paste -sd ,)
git_commit=$(git rev-parse --short HEAD)

> configuration printf "%s\n" \
	"Section: misc" \
	"Priority: optional" \
	"Homepage: https://nxos.org" \
	"Package: nx-desktop-legacy" \
	"Version: 3.3.0-$git_commit" \
	"Maintainer: Uri Herrera <uri_herrera@nxos.org>" \
	"Depends: $deps" \
	"Conflicts: nx-desktop, synaptic" \
	"Architecture: amd64" \
	"Description: NX Desktop metapackage for Nitrux."

equivs-build configuration
