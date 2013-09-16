# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION=""
HOMEPAGE=""

MY_PN="gDEBugger"
MY_PV="${PV//.}"
MY_P="${MY_PN}${MY_PV}"
SRC_URI="amd64? ( http://files.gremedy.com/downloads/${MY_P}-x86_64.tar.gz )"

LICENSE="unknown"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"

pkg_setup() {
	use amd64 && S="${WORKDIR}/${MY_P}-x86_64"
}

src_install() {
	insinto /opt/gdebugger
}
