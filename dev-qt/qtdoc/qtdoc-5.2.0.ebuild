# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qt5-build

DESCRIPTION="The Qt toolkit is a comprehensive C++ application development framework"

SRC_URI="http://download.qt-project.org/official_releases/qt/${PV%.*}/${PV/_/-}/single/qt-everywhere-opensource-src-${PV/_/-}.tar.xz"

RESTRICT=mirror

if [[ "${QT5_BUILD_TYPE}" == live ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
fi

IUSE="+accessibility"

DEPEND="
	~dev-qt/qtcore-${PV}[debug=]
	~dev-qt/qtxml-${PV}[debug=]
	~dev-qt/qttools-${PV}[debug=]
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/qt-everywhere-opensource-src-${PV/_/-}"

# QT5_TARGET_SUBDIRS=(
# 	doc
# )

src_configure() {
	qt5_base_configure
}

src_compile() {
	mkdir -p "${S}/qtbase/bin" || die
	cp "${QT5_BINDIR}/qdoc" "${QT5_BINDIR}/qhelpgenerator" "${S}/qtbase/bin" || die
	emake docs
}

src_install() {
	emake INSTALL_ROOT="${S}" install_docs
}
