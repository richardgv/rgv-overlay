# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools-utils

DESCRIPTION="Cairo Composite Manager is a versatile and extensible composite manager using cairo for rendering."
HOMEPAGE="http://cairo-compmgr.tuxfamily.org/"
SRC_URI="http://download.tuxfamily.org/ccm/cairo-compmgr/${P}.tar.gz"
RESTRICT="mirror"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND="gnome-base/gconf
	gnome-base/libgnomeui
	>=x11-libs/gtk+-2.10.0
	>=x11-libs/cairo-1.4.10
	x11-libs/libXext
	x11-libs/libXdamage
	x11-libs/libXcomposite
	dev-lang/vala:0.10"
DEPEND="${RDEPEND}"

AUTOTOOLS_AUTORECONF="1"

G2CONF="${G2CONF} --enable-gconf"

src_prepare() {
	sed -i 's/vala-1.0/vala-0.10/' configure.ac || die

	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		--enable-gconf
	)

	autotools-utils_src_configure
}
