# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit eutils games flag-o-matic cmake-utils

DESCRIPTION="A game similar to Super Mario Bros"
HOMEPAGE="http://supertux.lethargik.org/"
SRC_URI="https://supertux.googlecode.com/files/${P}.tar.bz2
	!bundled-libs? ( ftp://ohnopub.net/mirror/${PN}-r6591-crazy-system-findlocale-notinygettext.patch )"
RESTRICT=mirror

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~amd64 ~x86"
IUSE="+bundled-libs opengl curl debug"

RDEPEND="dev-games/physfs
	!bundled-libs? (
		dev-lang/squirrel
		dev-libs/findlocale
		dev-libs/tinygettext
		)
	media-libs/libsdl[joystick]
	media-libs/libvorbis
	media-libs/openal
	media-libs/sdl-image[png,jpeg]
	opengl? ( media-libs/glew
		virtual/opengl )
	curl? ( net-misc/curl )"

DEPEND="${RDEPEND}
	dev-libs/boost"

# pkg_setup() {
# 	append-cppflags "-DNULL=0"
# }

src_prepare() {
	sed -i 's_<curl/types\.h>_<curl/curl.h>_' src/addon/addon_manager.cpp || die
	if ! use bundled-libs; then
		epatch "${FILESDIR}"/${PN}-0.3.3-externals.patch
		rm -rf externals/{findlocale,tinygettext,squirrel} || die
	fi
}

src_configure() {
	local mycmakeargs=( -DWERROR=OFF
		-DINSTALL_SUBDIR_SHARE=share/games/supertux2
		-DINSTALL_SUBDIR_BIN=games/bin
		-DINSTALL_SUBDIR_DOC=share/doc/${P}
		$(cmake-utils_use_enable opengl OPENGL)
		$(cmake-utils_use_enable debug SQDBG)
		$(cmake-utils_use debug DEBUG)
		)
	! use bundled-libs && mycmakeargs+=( -DEXTERNAL_LIBSQUIRREL=YES )

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	dodoc README WHATSNEW.txt data/credits.txt
	prepgamesdirs
}
