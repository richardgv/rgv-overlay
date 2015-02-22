# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/bspwm/bspwm-0.8.9.ebuild,v 1.1 2014/06/25 05:43:41 radhermit Exp $

EAPI=5
inherit eutils toolchain-funcs git-r3

DESCRIPTION="Tiling window manager based on binary space partitioning"
HOMEPAGE="https://github.com/baskerville/bspwm/"
EGIT_REPO_URI="https://github.com/baskerville/bspwm.git"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""
IUSE="debug examples"

DEPEND="
	x11-libs/libxcb
	x11-libs/xcb-util-wm
"
RDEPEND="${DEPEND}
	x11-misc/sxhkd
"

src_prepare() {
	epatch "${FILESDIR}"/${P}-flags.patch
}

src_compile() {
	local target="all"
	use debug && target="debug"
	emake PREFIX=/usr CC="$(tc-getCC)" "$target"
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr DOCPREFIX="/usr/share/doc/${P}" install
}
