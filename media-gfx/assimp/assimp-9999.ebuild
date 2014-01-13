# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/assimp/assimp-3.0.1270.ebuild,v 1.1 2013/05/22 06:56:32 slis Exp $

EAPI=5

inherit cmake-utils versionator git-r3

DESCRIPTION="Importer library to import assets from 3D files"
HOMEPAGE="http://assimp.sourceforge.net/"
EGIT_REPO_URI="https://github.com/assimp/assimp.git"

LICENSE="BSD"
KEYWORDS=""
IUSE="+boost samples static tools"
SLOT="0"

DEPEND="${DEPEND}
	boost? ( dev-libs/boost )
	samples? (
		x11-libs/libX11
		virtual/opengl
		media-libs/freeglut
		)
	sys-libs/zlib
"
RDEPEND="${DEPEND}
${RDEPEND}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_build samples ASSIMP_SAMPLES) \
		$(cmake-utils_use_build tools ASSIMP_TOOLS) \
		$(cmake-utils_use_build static STATIC_LIB) \
		$(cmake-utils_use_enable !boost BOOST_WORKAROUND)
	)

	cmake-utils_src_configure
}
