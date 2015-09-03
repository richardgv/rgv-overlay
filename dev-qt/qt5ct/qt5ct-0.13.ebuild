# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qmake-utils

DESCRIPTION="Qt5 configuration utility"
HOMEPAGE="http://qt-apps.org/content/show.php?content=168066"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
RESTRICT=mirror

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-qt/qtgui-5.4.0:5
	>=dev-qt/qtsvg-5.4.0:5"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS ChangeLog ChangeLog.svn COPYING README TODO )

src_configure() {
	local myeqmakeargs=(
		${PN}.pro
		PREFIX="${EPREFIX}/usr"
		DESKTOPDIR="${EPREFIX}/usr/share/applications"
		ICONDIR="${EPREFIX}/usr/share/pixmaps"
	)
	eqmake5 ${myeqmakeargs[@]}
}

src_install() {
	emake INSTALL_ROOT="${ED}" install

	dodoc "${DOCS[@]}"

	doenvd "${FILESDIR}/45qt5ct"
}

pkg_postinst() {
	elog "The program sets QT_QPA_PLATFORMTHEME in /etc/env.d/45qt5ct and"
	elog "may conflict with other DE specific tools that configure Qt 5."
}
