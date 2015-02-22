# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="libMirage test application"
HOMEPAGE="http://cdemu.org/about/analyzer/"
SRC_URI="mirror://sourceforge/cdemu/${P}.tar.bz2"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-libs/libmirage-${PV}:=
	dev-libs/libxml2
	x11-libs/gtk+:3
	sci-visualization/gnuplot"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs="-DPOST_INSTALL_HOOKS=OFF"

	cmake-utils_src_configure
}
