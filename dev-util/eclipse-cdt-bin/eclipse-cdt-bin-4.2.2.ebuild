# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="C/C++ enviroment for Eclipse (binary)"
HOMEPAGE="http://www.eclipse.org/cdt/"

MY_PN="eclipse-cpp"
MY_VS="SR2"
MY_V="juno-SR2"
MY_P="${MY_PN}-${MY_V}"

SRC_URI="
	amd64? ( http://mirror.bjtu.edu.cn/eclipse/technology/epp/downloads/release/juno/${MY_VS}/${MY_P}-linux-gtk-x86_64.tar.gz )
	x86? ( http://mirror.bjtu.edu.cn/eclipse/technology/epp/downloads/release/juno/${MY_VS}/${MY_P}-linux-gtk.tar.gz )
"
RESTRICT="mirror"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/eclipse"

src_install() {

	dodir /opt/eclipse
	
	cp -r "${S}" "${ED}/opt"

	into /opt
	newbin "${FILESDIR}/eclipse.sh" eclipse
}
