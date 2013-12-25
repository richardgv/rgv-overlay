# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="PE analysis toolkit "
HOMEPAGE="http://sourceforge.net/projects/pev"
SRC_URI="mirror://sourceforge/${PN}/${P}/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i 's/gzip -c -9 /cat /g' "${S}/src/Makefile" || die
	sed -i 's/sizeof(buff)/LINE_BUFFER/g' "${S}/src/pestr.c" || die
	sed -i 's/sizeof(str)/100/g' "${S}/src/pestr.c" || die
	sed -i 's/^[[:space:]]*\$(STRIP).*//g' "${S}/lib/libpe/Makefile" || die
}

src_install() {
	emake DESTDIR="${ED}" SHAREDIR="${ED}/usr/share" MANDIR="${ED}/usr/share/man/man1" install
}
