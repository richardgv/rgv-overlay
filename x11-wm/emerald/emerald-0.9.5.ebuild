# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/emerald/emerald-0.8.8.ebuild,v 1.3 2012/08/30 11:49:44 pinkbyte Exp $

EAPI="5"

AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_IN_SOURCE_BUILD=1

inherit eutils autotools-utils

THEMES_RELEASE=0.5.2

DESCRIPTION="Emerald Window Decorator"
HOMEPAGE="http://www.compiz.org/"
SRC_URI="http://cgit.compiz.org/fusion/decorators/emerald/snapshot/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

# PDEPEND="~x11-themes/emerald-themes-${THEMES_RELEASE}"

RDEPEND="
	>=x11-libs/gtk+-2.8.0:2
	>=x11-libs/libwnck-2.14.2:1
	>=x11-wm/compiz-${PV}
"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	virtual/pkgconfig
	>=sys-devel/gettext-0.15
"

DOCS="AUTHORS ChangeLog INSTALL NEWS README TODO"

src_prepare() {
	autotools-utils_src_prepare
	# Fix pkg-config file pollution wrt #380197
	# epatch "${FILESDIR}"/${P}-pkgconfig-pollution.patch
	# fix build with gtk+-2.22 - bug 341143
	# sed -i -e '/#define G[DT]K_DISABLE_DEPRECATED/s:^://:' \
	# 	include/emerald.h || die
}

src_configure() {
	econf \
		--disable-static \
		--enable-fast-install \
		--disable-mime-update
}

src_install() {
	default
	prune_libtool_files
}
