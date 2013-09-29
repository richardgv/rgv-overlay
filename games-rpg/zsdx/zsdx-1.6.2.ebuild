# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit games cmake-utils

DESCRIPTION="A free 2D Zelda fangame."
HOMEPAGE="http://www.zelda-solarus.com/"
SRC_URI="http://www.zelda-solarus.com/downloads/${PN}/${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="
	>=games-rpg/solarus-1.0.0"
RDEPEND="${DEPEND}"

src_install() {
	cmake-utils_src_install

	local datadir="${GAMES_DATADIR}/solarus/${PN}"
	echo "#!/bin/sh" > "${PN}"
	echo "solarus ${datadir}" >> "${PN}"
	dogamesbin "${PN}"

	dodir "${datadir}"
	insinto "${datadir}"
	doins "${D}/${PREFIX}/share/solarus/${PN}/data.solarus"

	rm -r "${D}/${PREFIX}/bin" || die
	rm -r "${D}/${PREFIX}/share/solarus" || die

	dodoc readme.txt ChangeLog

	prepgamesdirs
}
