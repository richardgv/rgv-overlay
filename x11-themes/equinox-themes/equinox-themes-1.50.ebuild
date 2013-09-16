# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

MY_PN="equinox-themes"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="themes for the Equinox GTK engine"
HOMEPAGE="http://gnome-look.org/content/show.php/Equinox+GTK+Engine?content=121881"
SRC_URI="http://gnome-look.org/CONTENT/content-files/140449-equinox-themes-${PV}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="~x11-themes/gtk-engines-equinox-${PV}"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
	insinto /usr/share/themes
	doins -r "${S}/"*
}

pkg_postinst() {
	einfo "Chromium CRX have been installed to /usr/share/themes"
	einfo "under the relevant theme folder."
}
