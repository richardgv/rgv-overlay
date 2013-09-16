# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils

DESCRIPTION="Simple gettext replacement by SuperTux devs"
HOMEPAGE="http://tinygettext.googlecode.com/"
SRC_URI="ftp://ohnopub.net/mirror/${P}.tar.bz2
	http://protofusion.org/mirror/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_configure() {
	local mycmakeargs=(
		-DWERROR=OFF
	)

	cmake-utils_src_configure
}
