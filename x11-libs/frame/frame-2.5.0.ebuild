# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Open Input Framework Frame Library"
HOMEPAGE="https://launchpad.net/frame"
SRC_URI="https://launchpad.net/frame/trunk/v${PV}/+download/frame-${PV}.tar.xz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-base/xorg-server
	>=x11-libs/libXi-1.5.99.1
	x11-base/xorg-proto
	"
DEPEND="${RDEPEND}
	app-text/asciidoc
	test? ( dev-cpp/gtest )"


src_configure() {
	local myeconfargs=(
		--enable-x11
		$(use_enable test integration-tests)
		)

	econf "${myeconfargs[@]}"
}
