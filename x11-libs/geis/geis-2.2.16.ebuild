# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{3_2,3_3} )
AUTOTOOLS_AUTORECONF=1

inherit autotools-utils python-r1

DESCRIPTION="Open Input Framework Geis C API"
HOMEPAGE="https://launchpad.net/geis"
SRC_URI="https://launchpad.net/geis/trunk/${PV}/+download/${P}.tar.xz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=sys-apps/dbus-1.2.16
	>=x11-libs/grail-3.0.8
	>=x11-libs/frame-2.2
	>=x11-libs/libxcb-1.6
	x11-libs/libX11
	x11-libs/libXext
	>=x11-libs/libXi-1.3
	>=dev-lang/python-3.2"
DEPEND="${RDEPEND}
	test? (
		dev-cpp/gtest
		dev-libs/check
		)"

src_prepare() {
	python_export_best
	local python_best_ver=${EPYTHON/python}
	sed -e "s:python3:python-${python_best_ver}:" -i configure.ac || die
	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		$(use_enable test integration-tests)
		)

	autotools-utils_src_configure
}
