# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Cross-platform Text/Hex Editor, a fork of MadEdit with bug fixes and improvements"
HOMEPAGE="https://code.google.com/p/wxmedit/"
SRC_URI="mirror://sourceforge/wxmedit/prerelease/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/wxGTK
	dev-libs/icu
	dev-util/desktop-file-utils
	dev-libs/boost"
RDEPEND="${DEPEND}"
