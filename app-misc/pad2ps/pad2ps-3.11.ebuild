# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION=""
HOMEPAGE="http://www.aerith.net/project/pad2ps-j.html"
MY_PV="3.1"
MY_P="${PN}-${MY_PV}"
SRC_URI="http://www.aerith.net/project/pad2ps/${MY_P}.tar.gz
	http://www.aerith.net/project/pad2ps/${MY_P}-${PV}.diff.gz"

LICENSE="unknown"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

src_unpack() {
	default
	epatch "${WORKDIR}/${MY_P}-${PV}.diff"
}

src_prepare() {
	sed -i -e 's/^\(FILE \*fp = \)stdout;/\1NULL;/' -e '/char *env;/i/fp = stdout;/' "${S}/src/pad2ps/pad2ps.c" || die
	sed -ir -e '/MAKE =/d' -e '/MFLAGS =/d' \
		-e 's/\(\(LIB\|BIN\|MAN\|STY\)DIR[[:space:]]*=[[:space:]]*\)/\1${DESTDIR}\//' \
		"${S}/Makefile.in" || die
	for i in sh2pad pad2ps mkpad main lib java2pad csh2pad c2pad awk2pad; do
		sed -ie 's/\(\(LIB\|BIN\|MAN\|STY\)DIR[[:space:]]*=[[:space:]]*\)/\1${DESTDIR}\//' "${S}/src/${i}/Makefile.in" || die
	done
}

src_configure() {
	econf --stydir=/usr/share/texmf-site/tex/latex/
}

src_install() {
	emake DESTDIR="${ED}" install install.man
	dodoc HISTORY README
}
