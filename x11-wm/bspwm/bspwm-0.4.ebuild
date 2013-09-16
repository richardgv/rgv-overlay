# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="tiling window manager based on binary space partitioning"
HOMEPAGE="https://github.com/baskerville/bspwm"
SRC_URI="https://github.com/baskerville/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="x11-libs/libxcb
	x11-libs/xcb-util
	x11-libs/xcb-util-wm"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${ED}" PREFIX="${EPREFIX}/usr" install
}
