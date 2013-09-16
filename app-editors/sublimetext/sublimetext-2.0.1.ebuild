# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="A sophisticated text editor for code, markup and prose"
HOMEPAGE="http://www.sublimetext.com"

SRC_URI_PREFIX="http://c758482.r82.cf2.rackcdn.com"
MY_PN="Sublime%20Text"
MY_P="${MY_PN}%20${PV}"
SRC_URI="
x86? ( ${SRC_URI_PREFIX}/${MY_P}.tar.bz2 )
amd64? ( ${SRC_URI_PREFIX}/${MY_P}%20x64.tar.bz2 )
"
RESTRICT="mirror"

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.24.8-r1:2"
RDEPEND="${DEPEND}"

S="${WORKDIR}/Sublime Text 2"

src_install() {
	dodir /opt/${PN}
	insinto /opt/${PN}
	into /opt/${PN}
	exeinto /opt/${PN}
	doins -r "lib"
	doins -r "Pristine Packages"
	doins "sublime_plugin.py"
	doins "PackageSetup.py"
	doexe "sublime_text"
	dosym "/opt/${PN}/sublime_text" /usr/bin/subl

	# Icon and .desktop for sublime-text
	for icon in $(find Icon -name '*.png') ; do
		insinto /usr/share/`dirname $icon | sed 's/Icon/icons\/hicolor/'`/apps
		doins $icon
	done
	dosym ../icons/hicolor/48x48/apps/sublime_text.png usr/share/pixmaps/sublime_text.png
	make_desktop_entry "subl" "Sublime Text Editor" "sublime_text" "Development;TextEditor"
}
