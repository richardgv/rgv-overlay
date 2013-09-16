# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools-utils

DESCRIPTION="Medical Image Conversion Utility"
HOMEPAGE="http://xmedcon.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk png"

DEPEND="gtk? ( x11-libs/gtk+:2 )
	png? ( >=media-libs/libpng-1.2.1 )"
RDEPEND="${DEPEND}"

AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_IN_SOURCE_BUILD=1

src_configure() {
	local myconf="
		$(use_enable gtk gui)
		$(use_enable png)"

	econf ${myconf}
}

src_install() {
	autotools-utils_src_install

	dodoc AUTHORS COPYING* INSTALL NEWS README REMARKS

	dodir /usr/share/pixmaps
	insinto /usr/share/pixmaps
	# doins "${D}/etc/xmedcon.png"
}
