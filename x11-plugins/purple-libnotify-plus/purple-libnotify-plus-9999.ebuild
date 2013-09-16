# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils autotools-utils git-2

DESCRIPTION="pidgin-libnotify provides popups for pidgin via a libnotify interface"
HOMEPAGE="https://github.com/sardemff7/purple-libnotify-plus"
SRC_URI=""
EGIT_REPO_URI="git://github.com/sardemff7/purple-libnotify-plus.git"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="nls"

RDEPEND=">=x11-libs/libnotify-0.5.0
	>=net-im/pidgin-2.6.0
	x11-libs/gdk-pixbuf:2
	dev-libs/glib:2
	x11-plugins/purple-events[nls?]
	sys-devel/gettext
	dev-util/intltool"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( README )

AUTOTOOLS_AUTORECONF=1

src_configure() {
	local myeconfargs=(
		$(use_enable nls)
	)

	autotools-utils_src_configure
}
