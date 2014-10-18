# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils versionator

DESCRIPTION="Eclipse IDE for Java developers (binary)"
HOMEPAGE="http://www.eclipse.org/cdt/"

MY_PN="eclipse-java"
MY_VM="luna"
MY_VS_RAW="$(get_version_component_range 3)"
if [ -z "$MY_VS_RAW" ]; then
	MY_VS="R"
else
	MY_VS="SR$(get_version_component_range 3)"
fi
MY_V="${MY_VM}-${MY_VS}"
MY_P="${MY_PN}-${MY_V}"

SRC_BASE="http://mirror.bit.edu.cn/eclipse/technology/epp/downloads/release/${MY_VM}/${MY_VS}/${MY_P}-linux-gtk"

SRC_URI="
	amd64? ( ${SRC_BASE}-x86_64.tar.gz )
	!amd64? ( x86? ( ${SRC_BASE}.tar.gz ) )
"
RESTRICT="mirror"

LICENSE="EPL-1.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="!dev-util/eclipse-sdk
	!dev-util/eclipse-cpp-bin"
RDEPEND="${DEPEND}
	>=virtual/jdk-1.6
	x11-libs/gtk+:2"

S="${WORKDIR}/eclipse"

src_install() {
	local base="/opt/${MY_PN}"
	dodir /opt
	cp -r "${S}" "${ED}/${base}" || die

	into /opt
	make_wrapper eclipse "${base}/eclipse"
}
