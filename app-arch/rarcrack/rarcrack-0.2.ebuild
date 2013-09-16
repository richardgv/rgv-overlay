# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit toolchain-funcs

DESCRIPTION="Password recovery for 7zip, rar and zip archives"
HOMEPAGE="http://rarcrack.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	app-arch/unrar
	app-arch/unzip
	app-arch/p7zip"

src_compile() {
	emake CC=$(tc-getCC)
}

src_install() {
	mkdir -p "${ED}/usr/bin"
	emake DESTDIR="${ED}" PREFIX="${ED}/usr" install
}
