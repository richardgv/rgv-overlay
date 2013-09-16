# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit toolchain-funcs mercurial

DESCRIPTION="Full-screen task-switcher"
HOMEPAGE="https://code.google.com/p/skippy-xd/"
# SRC_URI=""
EHG_REPO_URI="https://code.google.com/p/skippy-xd/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="media-libs/imlib2[X]
	x11-libs/libXext
	x11-libs/libX11
	x11-libs/libXinerama
	x11-libs/libXmu
	x11-libs/libXft"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xineramaproto
	virtual/pkgconfig"

pkg_setup() {
	tc-export CC
}

src_install () {
	emake PREFIX=/usr DESTDIR="${ED}" install

	dodoc skippy-xd.rc-default CHANGELOG
}
