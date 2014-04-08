# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit python cmake-utils eutils subversion

# MY_P="${PN}-${PV/_/-}"

DESCRIPTION="A lightweight panel/taskbar"
HOMEPAGE="http://code.google.com/p/tint2/"
# SRC_URI="http://tint2.googlecode.com/files/${MY_P}.tar.bz2"
ESVN_REPO_URI="http://tint2.googlecode.com/svn/trunk"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="battery examples tint2conf"

COMMON_DEPEND="dev-libs/glib:2
	x11-libs/cairo
	x11-libs/pango[X]
	x11-libs/libX11
	x11-libs/libXinerama
	x11-libs/libXdamage
	x11-libs/libXcomposite
	x11-libs/libXrender
	x11-libs/libXrandr
	media-libs/imlib2[X]
	!x11-misc/tintwizard"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	x11-proto/xineramaproto"
RDEPEND="${COMMON_DEPEND}"

# S="${WORKDIR}/${MY_P}"

src_prepare() {
	default
	# epatch "${FILESDIR}/battery_segfault.patch" # bug 343963
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable battery BATTERY)
		$(cmake-utils_use_enable examples EXAMPLES)
		$(cmake-utils_use_enable tint2conf TINT2CONF)

		# bug 296890
		"-DDOCDIR=/usr/share/doc/${PF}"
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	use tint2conf && python_convert_shebangs 2 "${ED}/usr/bin/tintwizard.py"
}
