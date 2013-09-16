# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="pidgin-libnotify provides popups for pidgin via a libnotify interface"
HOMEPAGE="https://github.com/sardemff7/purple-events"
SRC_URI="mirror://github/sardemff7/${PN}/${P}.tar.xz"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=net-im/pidgin-2.6.0
	dev-libs/glib:2
	sys-devel/gettext"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
