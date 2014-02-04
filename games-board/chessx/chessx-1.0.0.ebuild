# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit games qt4-r2

DESCRIPTION="a Qt4 chess database application"
HOMEPAGE="http://chessx.sourceforge.net/"
MY_PV="${PV//./-}"
MY_P="${PN}-${MY_PV}"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${PV}/${PN}-${MY_PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

DEPEND="dev-qt/qtgui:4
	dev-libs/quazip"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# Drop bundled quazip because it doesn't work with Z_ prefixed zlib macros
	# in system zlib headers
	sed -i \
		-e '/src\/quazip/d' \
		-e 's/QUAZIP_STATIC//' \
		"${S}/${PN}.pro"
	cat >> "${S}/${PN}.pro" <<EOF
LIBS += -lquazip
INCLUDEPATH += /usr/include/quazip
EOF
	qt4-r2_src_prepare
}

src_configure() {
    eqmake4 "${S}/${PN}.pro"
}

src_install() {
	dodoc ChangeLog TODO
	dogamesbin "release/chessx"
}
