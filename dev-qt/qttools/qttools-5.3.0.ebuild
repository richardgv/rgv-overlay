# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qt5-build

# makeqpf don't build without qtbase source around
MY_PV="${PV/rc/RC}"
MY_PV="${MY_PV/_/-}"
QTBASE_P="qtbase-opensource-src-${MY_PV}"
SRC_URI+=" http://download.qt-project.org/official_releases/qt/${PV%.*}/${MY_PV}/submodules/${QTBASE_P}.tar.xz"

DESCRIPTION="The Qt toolkit is a comprehensive C++ application development framework"

if [[ "${QT5_BUILD_TYPE}" == live ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
fi

IUSE="+accessibility"

DEPEND="
	~dev-qt/qtcore-${PV}[debug=]
	~dev-qt/qtgui-${PV}[accessibility=,debug=]
	~dev-qt/qtwidgets-${PV}[accessibility(+)=,debug=]
	~dev-qt/qtnetwork-${PV}[debug=]
	~dev-qt/qtsql-${PV}[debug=]
	~dev-qt/qtprintsupport-${PV}[debug=]
	~dev-qt/qtxml-${PV}[debug=]
"
RDEPEND="${DEPEND}"

# Somehow, order changes may break some builds
QT5_TARGET_SUBDIRS=(
	src/pixeltool
	src/qtestlib
	src/qtpaths

	src/qtconfig
	src/qev
	src/qconfig
	src/kmap2qmap

	src/tools/qdoc
)

# Separate ebuild in Qt overlay
# src/linguist
# src/qdbus

# Can't work on Linux
# src/macdeployqt

# Dropped?
# https://qt.gitorious.org/qt/qtbase/commit/d7e424ee6686f663f5134666e09c2875bb3e42b6
# src/makeqpf

# Seemingly those should be included in qtconcurrent?
# src/qtconcurrent/codegenerator
# src/qtconcurrent/generaterun

PATCHES=( "${FILESDIR}/${P}-qtconfig.patch" )

src_unpack() {
	qt5-build_src_unpack

	# Hard link qtbase files over
	cp -lrn "${WORKDIR}/${QTBASE_P}/"* "${S}" || die
}

src_prepare() {
	# Fix qtconfig
	# sed -i 's/\(#if defined(Q_WS_X11) && !defined(QT_NO_XIM)\)$/\1 && 0' ${S}/src/qtconfig/mainwindow.cpp || die

	# Fix sandbox violation when building with qt-tools already installed
	find "${S}" -name '*.pro' -exec sed -i 's/\$\$QT\.designer\.bins//' '{}' + || die

	# Fix sandbox violation when runing qmake
	sed -i 's+\$\$eval(QT\.uitools\.libs)/++' "${S}/src/linguist/linguist.pro" || die

	# Fix QT_SOURCE_TREE
	sed -i 's+\$\$QT_SOURCE_TREE+'"${S}"'+g' "${S}/src/tools/qdoc/qdoc.pro" || die

	qt5-build_src_prepare
}

src_configure() {
	local myconf=(
		$(qt_use accessibility)
	)

	qt5-build_src_configure
}

src_install() {
	qt5-build_src_install

	# into /usr/lib/qt5
	#
	# dobin \
	# 	"${QT5_BUILD_DIR}/src/kmap2qmap/kmap2qmap" \
	# 	"${QT5_BUILD_DIR}/src/qconfig/qconfig" \
	# 	"${QT5_BUILD_DIR}/src/qev/qev"
}
