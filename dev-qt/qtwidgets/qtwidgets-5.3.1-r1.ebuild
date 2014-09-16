# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

QT5_MODULE="qtbase"

inherit qt5-build

DESCRIPTION="The Qt toolkit is a comprehensive C++ application development framework"

if [[ ${QT5_BUILD_TYPE} == live ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
fi

IUSE="accessibility gtkstyle"

DEPEND="
	~dev-qt/qtcore-${PV}[debug=]
	~dev-qt/qtgui-${PV}[debug=]
	gtkstyle? (
		x11-libs/cairo[-qt4]
		x11-libs/gtk+:2
	)
"
RDEPEND="${DEPEND}"

PATCHES=(
	# http://blog.martin-graesslin.com/blog/2014/06/where-are-my-systray-icons/
	"${FILESDIR}/${PN}-5.3.1-prefer-qpa.patch"
)

QT5_TARGET_SUBDIRS=(
	src/tools/uic
	src/widgets
	src/plugins/accessible
)

src_configure() {
	local myconf=(
		$(qt_use accessibility)
		$(qt_use gtkstyle)
	)

	qt5-build_src_configure
}