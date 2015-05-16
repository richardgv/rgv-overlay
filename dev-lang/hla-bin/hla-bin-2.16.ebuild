# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="High Level Assembler"
HOMEPAGE="http://webster.cs.ucr.edu/AsmTools/HLA/dnld.html"
SRC_URI="http://www.plantation-productions.com/Webster/HighLevelAsm/HLAv${PV}/linux.hla.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="
	!dev-lang/hla
	!dev-lang/hlalib"
RDEPEND="${DEPEND}
	sys-devel/binutils"

S="${WORKDIR}/usr/hla"

QA_EXECSTACK="usr/hla/*"

src_prepare() {
	rm makefile mkMake || die
}

src_install() {
	dodir /usr/hla
	cp -R "${S}"/* "${ED}"/usr/hla || die
	dosym /usr/hla/hla /usr/bin/hla
	dosym /usr/hla/hlaparse /usr/bin/hlaparse
}
