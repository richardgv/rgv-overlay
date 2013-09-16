# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="4"

inherit eutils autotools-utils

DESCRIPTION="Unagi Compositing Manager"
HOMEPAGE="http://projects.mini-dweeb.org/projects/unagi"

MY_SRC_ID="111"
SRC_URI="http://projects.mini-dweeb.org/attachments/download/${MY_SRC_ID}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc"

RDEPEND="
	>=x11-libs/libxcb-1.8
	x11-libs/xcb-util
	dev-libs/confuse
	>=x11-proto/xcb-proto-1.6
	>=dev-libs/libxdg-basedir-1.0.0
	x11-proto/xproto
	dev-libs/libev"
DEPEND="
	${RDEPEND}
	doc? ( app-doc/doxygen )
	sys-devel/autoconf-archive
	virtual/pkgconfig"

DOCS=( README AUTHORS ChangeLog INSTALL THANKS )

AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_IN_SOURCE_BUILD=1

src_configure() {
	local myeconfargs=(
			$(use_enable debug)
			$(use_enable doc doxygen-doc)
			# $(use_enable doc doxygen-man)
			$(use_enable doc doxygen-html)
	)

	autotools-utils_src_configure
}

src_install() {
	use doc && HTML_DOCS=( "${AUTOTOOLS_BUILD_DIR}/doc/api/html/" )

	autotools-utils_src_install
}
