# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit unpacker

DESCRIPTION="A graphical diff and merge tool"
HOMEPAGE="http://www.scootersoftware.com"

MY_PN="bcompare"
MY_P="${MY_PN}-${PV}"
SRC_URI="http://www.scootersoftware.com/${MY_P}_i386.deb"
# Very bad to use RESTRICT=binchecks here, but we need to prevent scanelf from
# modifying the binaries
RESTRICT="binchecks mirror"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	>=media-libs/fontconfig-2.4.0[abi_x86_32]
	media-libs/freetype:2[abi_x86_32]
	>=sys-devel/gcc-4.1.1[cxx]
	>=x11-libs/libICE-1.0.0[abi_x86_32]
	x11-libs/libSM[abi_x86_32]
	x11-libs/libX11[abi_x86_32]
	>x11-libs/libXcursor-1.1.2[abi_x86_32]
	x11-libs/libXext[abi_x86_32]
	>x11-libs/libXft-2.1.1[abi_x86_32]
	x11-libs/libXi[abi_x86_32]
	x11-libs/libXinerama[abi_x86_32]
	x11-libs/libXrandr[abi_x86_32]
	x11-libs/libXrender[abi_x86_32]
	x11-libs/libXt[abi_x86_32]
	sys-libs/zlib[abi_x86_32]
	app-arch/bzip2[abi_x86_32]"

S="${WORKDIR}"

src_unpack() {
	unpack_deb "${A}"
}

src_install() {
	cp -r --preserve=mode,links * "${ED}" || die
}
