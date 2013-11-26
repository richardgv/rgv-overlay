# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

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
	>=x11-proto/inputproto-2.1.99.6
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

src_install() {
	default

	local prefix="/usr"
	mv "${ED}${prefix}/share/doc/frame/"* "${ED}${prefix}/share/doc/${P}" || die
	rmdir "${ED}${prefix}/share/doc/frame/" || die
}
