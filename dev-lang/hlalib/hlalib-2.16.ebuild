# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="High Level Assembler standard library"
HOMEPAGE="http://webster.cs.ucr.edu/AsmTools/HLA/dnld.html"
SRC_URI="http://www.plantation-productions.com/Webster/HighLevelAsm/HLAv${PV}/linux.hlalibsrc.tar.gz"
RESTRICT="mirror"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="
	amd64? ( app-emulation/emul-linux-x86-baselibs )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/usr/hla/hlalibsrc"

src_prepare() {
	mv makefile.unix Makefile
}
