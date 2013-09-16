# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit font

DESCRIPTION="Monospaced programming font"
HOMEPAGE="http://www.fial.com/~scott/tamsyn-font/"
SRC_URI="http://www.fial.com/~scott/tamsyn-font/download/${P}.tar.gz"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

FONT_SUFFIX="pcf"
DOCS="README"

src_install() {
	font_src_install
	
	insinto /usr/share/consolefonts
	doins *.psf.gz
}
