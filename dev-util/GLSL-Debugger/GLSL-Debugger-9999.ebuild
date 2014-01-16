# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib flag-o-matic cmake-utils git-r3

DESCRIPTION="GLSL source level debugger"
HOMEPAGE="https://github.com/XenonofArcticus/GLSL-Debugger"
SRC_URI=""
EGIT_REPO_URI="https://github.com/XenonofArcticus/GLSL-Debugger.git"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="virtual/opengl
	media-libs/glew
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qtopengl:4
	x11-libs/libX11
	media-libs/freeglut"
RDEPEND="${DEPEND}"

pkg_setup() {
	# -std=c++11 is added in CMakeLists.txt but cmake-utils.eclass overrides
	# it, so we add it back here
	append-cxxflags -std=c++11
}

src_install() {
	# CMake install rules are missing now, so...
	dobin "${BUILD_DIR}/bin/"*

	find "${BUILD_DIR}/lib/" -mindepth 1 -maxdepth 1 -type f -name '*.so' \
		| (while read i; do dolib "$i"; done)
	plugin_dir="/usr/$(get_libdir)/plugins"
	dodir "${plugin_dir}"
	insinto "${plugin_dir}"
	find "${BUILD_DIR}/lib/plugins" -mindepth 1 -maxdepth 1 -type f -name '*.so' \
		| (while read i; do doins "$i"; done)
}
