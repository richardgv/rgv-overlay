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

S="${WORKDIR}/${PN}"

src_prepare() {
	# Don't compress man page: Portage should take care of it
	sed -i 's/gzip -c -9 \([^ ][^ ]*\) > \([^ ][^ ]*\)\.gz /cp \1 \2 /g' "${S}/src/Makefile" || die

	# Don't strip: Portage should take care of it
	sed -i 's/^[[:space:]]*\$(STRIP).*//g' "${S}/lib/libpe/Makefile" || die
}

src_install() {
	emake DESTDIR="${ED}" datarootdir="${ED}/usr/share" install
}
