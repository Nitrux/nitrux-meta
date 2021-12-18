#! /bin/sh

apt -qq update
apt -qq -yy install equivs curl git

deps=$(sed -e '/^#.*$/d; /^$/d; /^\s*$/d' package/dependencies | paste -sd ,)
git_commit=$(git rev-parse --short HEAD)

> configuration printf "%s\n" \
	"Section: misc" \
	"Priority: optional" \
	"Homepage: https://nxos.org" \
	"Package: nx-desktop-wayland-legacy" \
	"Version: 0.0.2-$git_commit" \
	"Maintainer: Uri Herrera <uri_herrera@nxos.org>" \
	"Depends: $deps" \
	"Conflicts: nx-desktop-wayland" \
	"Architecture: amd64" \
	"Description: NX Desktop metapackage for Nitrux."

equivs-build configuration
