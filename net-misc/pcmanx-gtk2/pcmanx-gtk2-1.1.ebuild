# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools-utils

DESCRIPTION="an easy-to-use telnet client mainly targets BBS users formerly
writen by gtk2"
HOMEPAGE="http://pcmanx-gtk2.googlecode.com"
SRC_URI="http://pcmanx-gtk2.googlecode.com/files/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +iplookup +libnotify +nancy proxy"

DEPEND="
	>=x11-libs/gtk+-2.4
	libnotify? ( x11-libs/libnotify )"
RDEPEND="${DEPEND}"

# http://code.google.com/p/pcmanx-gtk2/issues/detail?id=52&can=1&q=FcFontSort
PATCHES=(
	"${FILESDIR}/${P}-fcfontsort.patch" 
)

src_prepare() {
	sed -i 's/^\(Categories=.*\)$/\1;/' pcmanx.desktop.in || die

	autotools-utils_src_prepare
}

src_configure() {
        local myeconfargs=(
                $(use_enable debug)
                $(use_enable libnotify)
                $(use_enable proxy)
                $(use_enable nancy)
                $(use_enable iplookup)
        )
        autotools-utils_src_configure
}

src_install() {
        autotools-utils_src_install
}
