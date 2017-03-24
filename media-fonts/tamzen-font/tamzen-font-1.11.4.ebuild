# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit font

DESCRIPTION="Bitmapped programming font, based on Tamsyn"
HOMEPAGE="https://github.com/sunaku/tamzen-font"
SRC_URI="https://github.com/sunaku/tamzen-font/archive/Tamzen-${PV}.tar.gz"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S="${WORKDIR}/${PN}-Tamzen-${PV}"
FONT_S="pcf"
FONT_SUFFIX="pcf"
DOCS="README.md"

src_install() {
	font_src_install

	insinto /usr/share/consolefonts
	doins psf/*.psf
}
