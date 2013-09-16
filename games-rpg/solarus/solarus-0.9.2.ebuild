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

src_prepare() {
	# https://aur.archlinux.org/packages/so/solarus/PKGBUILD
	# ugly hack for gcc 4.7
	# it will be removed in solarus 0.9.3
	sed -i 's/-Werror//' src/CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs="
		-DDEFAULT_QUEST="${GAMES_DATADIR}/${PN}/zsdx"
		$(cmake-utils_use_enable debug-keys DEBUG_KEYS)"

	cmake-utils_src_configure
}

src_install() {
	dogamesbin "${CMAKE_BUILD_DIR}/src/${PN}"
	dodoc readme.txt ChangeLog

	prepgamesdirs
}
