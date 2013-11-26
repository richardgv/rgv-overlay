# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Open Input Framework Grail Library "
HOMEPAGE="https://launchpad.net/grail"
SRC_URI="https://launchpad.net/grail/trunk/${PV}/+download/${P}.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=x11-libs/frame-2.5.0
	x11-libs/libX11
	x11-libs/libXext
	x11-base/xorg-server
	>=x11-libs/libXi-1.5.99.1
	>=x11-proto/inputproto-2.1.99.6
	"
DEPEND="${RDEPEND}
	test? ( dev-cpp/gtest )"


src_configure() {
	local myeconfargs=(
		--with-x11
		$(use_enable test integration-tests)
		)

	econf "${myeconfargs[@]}"
}
