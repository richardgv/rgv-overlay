# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils autotools-utils git-2

DESCRIPTION="pidgin-libnotify provides popups for pidgin via a libnotify interface"
HOMEPAGE="https://github.com/sardemff7/purple-events"
SRC_URI=""
EGIT_REPO_URI="git://github.com/sardemff7/purple-events.git"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="nls"

RDEPEND=">=net-im/pidgin-2.6.0
	dev-libs/glib:2
	sys-devel/gettext
	dev-util/intltool"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

AUTOTOOLS_AUTORECONF=1

src_configure() {
	local myeconfargs=(
		$(use_enable nls)
	)

	autotools-utils_src_configure
}
