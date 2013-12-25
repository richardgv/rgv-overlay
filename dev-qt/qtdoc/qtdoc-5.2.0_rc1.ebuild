# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qt5-build

DESCRIPTION="The Qt toolkit is a comprehensive C++ application development framework"

SRC_URI+="
http://download.qt-project.org/official_releases/qt/${PV%.*}/${PV/_/-}/submodules/qtbase-opensource-src-${PV/_/-}.tar.xz
"

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

QT5_TARGET_SUBDIRS=(
	doc
)

src_unpack() {
	qt5-build_src_unpack

	# Hard link qtbase files over
	cp -lrn "${WORKDIR}/qtbase-opensource-src-${PV/_/-}/"* "${S}" || die
}

src_install() {
	cd "${QT5_BUILD_DIR}/doc" || die
	mkdir -p "${QT5_BUILD_DIR}/doc/qtdoc" || die
	emake QT_INSTALL_DOCS="${S}" INSTALL_ROOT="${ED}" docs
	# cd "${QT5_BUILD_DIR}/doc" || die
	# emake INSTALL_ROOT="${ED}" install_inst_qch_docs
}
