# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2

DESCRIPTION="tiling window manager based on binary space partitioning"
HOMEPAGE="https://github.com/baskerville/bspwm"
SRC_URI=""
EGIT_REPO_URI="https://github.com/baskerville/bspwm"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~x11-misc/sxhkd-${PV}
	x11-libs/libxcb
	x11-libs/xcb-util
	x11-libs/xcb-util-wm"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i 's/LDFLAGS += -s/LDFLAGS += /' "${S}/Makefile" || die
}

src_compile() {
	local tgt=all
	use debug && tgt=debug
	emake $tgt
}

src_install() {
	emake DESTDIR="${ED}" PREFIX="${EPREFIX}/usr" install
}
