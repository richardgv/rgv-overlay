# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION="0.14"

AUTOTOOLS_AUTORECONF=1

inherit vala autotools-utils

DESCRIPTION="Stupidly simple dock"
HOMEPAGE="https://launchpad.net/plank"
SRC_URI="https://launchpad.net/plank/1.0/0.3.0/+download/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-libs/glib-2.32:2
	dev-libs/libgee:0
	x11-libs/gtk+:3
	x11-libs/bamf
	x11-libs/libX11
	x11-libs/libwnck:3"
DEPEND="${RDEPEND}
	$(vala_depend)
	dev-util/intltool
	gnome-base/gnome-common
	sys-devel/gettext
	virtual/pkgconfig"

src_prepare() {
	# Fix underlinking
	sed -i 's/\(plank_LDADD =\)/\1 $(LIBM)/' "${S}/src/Makefile.am" || die

	autotools-utils_src_prepare
	vala_src_prepare
}
