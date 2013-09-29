# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit games cmake-utils

DESCRIPTION="An open-source Zelda-like 2D game engine used by the games zsxd and zsdx."
HOMEPAGE="http://www.zelda-solarus.com"
SRC_URI="http://www.zelda-solarus.com/downloads/${PN}/${P}-src.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug-keys"

DEPEND="
	=dev-lang/lua-5.1*
	media-libs/libsdl
	media-libs/sdl-ttf
	media-libs/sdl-image[png]
	media-libs/openal
	media-libs/libvorbis
	media-libs/libmodplug
	dev-games/physfs[zip]"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs="
		-DDEFAULT_QUEST="${GAMES_DATADIR}/${PN}/zsdx"
		-DCMAKE_INSTALL_PREFIX="${GAMES_PREFIX}"
		$(cmake-utils_use_enable debug-keys DEBUG_KEYS)"

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	dodoc readme.txt ChangeLog

	prepgamesdirs
}
