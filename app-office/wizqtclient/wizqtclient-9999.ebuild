# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils git-2

DESCRIPTION=""
HOMEPAGE="http://www.wiz.cn/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/WizTeam/WizQTClient.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bundled-libs"

DEPEND="dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qtxmlpatterns:4
	dev-qt/qtwebkit:4
	dev-cpp/clucene
	dev-db/sqlite:3"
RDEPEND="${DEPEND}"

src_prepare() {
	if ! use bundled-libs; then
		# Drop bundled clucene and crypto++
		rm -r "${S}/lib" || die
		sed -i \
			-e 's+add_subdirectory(lib/clucene)++' \
			-e 's+add_subdirectory(lib/cryptopp)++' \
			"${S}/CMakeLists.txt" || die
		sed -i \
			-e 's+^[[:space:]]*${CMAKE_BINARY_DIR}/lib.*$++' \
			-e 's+cryptlib+cryptopp+' \
			-e 's+\(clucene-[^- ]*\)-static++' \
			"${S}/src/CMakeLists.txt" || die
		cat >> "${S}/src/CMakeLists.txt" <<EOF
include(FindPkgConfig)
pkg_check_modules(CLUCENE REQUIRED libclucene-core)
add_definitions(\${CLUCENE_CFLAGS})
target_link_libraries(\${PROJECT_NAME} \${CLUCENE_LDFLAGS})
EOF

		# Drop bundled sqlite3
		rm -r "${S}/src/share/sqlite3.c" \
			"${S}/src/share/sqlite3.h" \
			"${S}/src/share/sqlite3ext.h" \
			|| die
		sed -i 's+share/sqlite3\(ext\)*\.\(c\|\h\)++' "${S}/src/CMakeLists.txt" || die
		# sed -i 's+share/sqlite3\.c++' "${S}/src/wiznote.pro" || die
		cat >> "${S}/src/CMakeLists.txt" <<EOF
include(FindPkgConfig)
pkg_check_modules(SQLITE3 REQUIRED sqlite3)
add_definitions(\${SQLITE3_CFLAGS})
target_link_libraries(\${PROJECT_NAME} \${SQLITE3_LDFLAGS})
EOF

	else
		# Fix underlinking in sqlite3
		sed -i 's+^\(target_link_libraries(${PROJECT_NAME}\)+\1 dl pthread+' "${S}/src/CMakeLists.txt" || die
	fi


	# Fix QA notice about .desktop file
	sed -i 's/QT/Qt/' "${S}/share/applications/wiznote.desktop" || die

	cmake-utils_src_prepare
}
