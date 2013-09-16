# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit font

DESCRIPTION="a family of monospaced bitmap fonts"
HOMEPAGE="http://www.mpi-inf.mpg.de/~uwe/misc/uw-ttyp0/"
SRC_URI="http://www.mpi-inf.mpg.de/~uwe/misc/${PN}/${P}.tar.gz"

LICENSE="WTFPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="x11-apps/bdftopcf
	dev-lang/perl"
RDEPEND=""

src_prepare() {
	sed 's/\(ENCODINGS = uni\).*$/\1/' -i "${S}/TARGETS.dat"
}

src_configure() {
	local prefix="${EPREFIX}/usr"
	./configure --prefix="${prefix}" \
		--pcfdir="${prefix}/share/fonts/X11/${PN}"
}

src_install() {
	default

	dodoc README DESIGN FAQ
}
