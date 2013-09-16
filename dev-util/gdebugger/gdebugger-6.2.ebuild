# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION=""
HOMEPAGE="http://developer.amd.com/tools/heterogeneous-computing/amd-gdebugger/"
MY_PN="gDEBugger"
MY_PV="6.2.438"
SRC_URI="x86? ( http://developer.amd.com/wordpress/media/files/gDEBugger_LNX_6.2_32.tar.gz )
amd64? ( http://developer.amd.com/wordpress/media/files/gDEBugger_LNX6.2_64.tar.gz )"
RESTRICT="fetch"

LICENSE="unknown"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

pkg_setup() {
	use amd64 && S="${WORKDIR}/${MY_PN}${MY_PV}-x86_64"
}

src_install() {
	insinto /opt
	cp -r --preserve=mode "${S}" "${ED}/opt/gdebugger6" || die
}
