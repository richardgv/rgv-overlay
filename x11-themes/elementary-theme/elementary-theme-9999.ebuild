# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit bzr

DESCRIPTION="Elementary GTK THEME designed to be smooth, attractive, fast, and usable"
HOMEPAGE="https://launchpad.net/egtk"
EBZR_REPO_URI="lp:egtk"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+gtk +gtk3"

DEPEND=""
RDEPEND="${DEPEND}
	gtk? (
		x11-libs/gtk+:2
		x11-themes/gtk-engines-murrine
	)
	gtk3? (
		x11-libs/gtk+:3
		x11-themes/gtk-engines-unico
	)"

DOCS=( AUTHORS CONTRIBUTORS COPYING )
THEMES="index.theme metacity-1 gtk-2.0 gtk-3.0"

src_prepare() {
	# Correct cursor theme name
	sed -i 's/DMZ-Black/Vanilla-DMZ-AA/' index.theme
}

src_install() {
	default

	insinto /usr/share/themes/elementary
	doins -r ${THEMES}
}

