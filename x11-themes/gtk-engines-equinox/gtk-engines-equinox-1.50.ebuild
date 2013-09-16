# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

MY_PN="equinox"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="a heavily modified version of the Aurora engine"
HOMEPAGE="http://gnome-look.org/content/show.php/Equinox+GTK+Engine?content=121881"
SRC_URI="http://gnome-look.org/CONTENT/content-files/121881-${MY_P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="x11-libs/gtk+:2"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# glib header file inclusion fix
	sed -i 's/^#include <glib\/gtimer\.h>/#include <glib.h>/' src/animation.c || die;
}
src_configure() {
	econf --enable-animation
}
