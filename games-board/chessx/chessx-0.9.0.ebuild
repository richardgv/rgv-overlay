# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit games qt4-r2 subversion

DESCRIPTION="a Qt4 chess database application"
HOMEPAGE="http://chessx.sourceforge.net/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

DEPEND="dev-qt/qtgui:4"
RDEPEND="${DEPEND}"

MY_PV="${PV//./-}"
ESVN_REPO_URI="http://chessx.svn.sourceforge.net/svnroot/chessx/tags/release-${MY_PV}"
ESVN_PROJECT="chessx-0.9.0"

src_configure() {
    eqmake4 "${S}"/chessx.pro
}

src_install() {
	dodoc ChangeLog TODO
	dogamesbin "release/chessx"
}
