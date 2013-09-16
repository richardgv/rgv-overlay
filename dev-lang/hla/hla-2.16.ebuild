# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit flag-o-matic

DESCRIPTION="High Level Assembler"
HOMEPAGE="http://webster.cs.ucr.edu/AsmTools/HLA/dnld.html"
# hla depends on hlalib to build, hlalib depends on hla, so I use the binary
# hla to build hlalib, then use the built hlalib for building hla
SRC_URI="
	http://www.plantation-productions.com/Webster/HighLevelAsm/HLAv${PV}/linux.hlasrc.tar.gz
	http://www.plantation-productions.com/Webster/HighLevelAsm/HLAv${PV}/linux.hlalibsrc.tar.gz
	http://www.plantation-productions.com/Webster/HighLevelAsm/HLAv${PV}/linux.hla.tar.gz"
RESTRICT="mirror"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="static"

DEPEND="
	sys-devel/binutils
	!dev-lang/hla-bin
	amd64? ( app-emulation/emul-linux-x86-baselibs )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/usr/hla/hlasrc/trunk"
S_LIB="${WORKDIR}/usr/hla/hlalibsrc"
S_BIN="${WORKDIR}/usr/hla"

src_prepare() {
	use amd64 && append-flags -m32

	tc-export CC

	# Respect CFLAGS
	sed -i 's/gcc /$(CC) $(CFLAGS) $(LDFLAGS) /' makefile || die

	# flex MAXIMUM_MNS workaround
	sed -i "s/flex -8/flex -8 -Ca /" makefile || die

	use amd64 && sed -i 's/as /as --32 /' makefile || die
	use static ||
		(sed -i -e 's/-static-libgcc//' -e 's/-static//' makefile || die)
	sed -i "s+/usr/hla/hlalib/hlalib.a+${S_BIN}/hlalib/hlalib.a+" makefile || die

	# Workaround of a weird conflicting declaration error
	sed -i 's/extern int yyleng/extern size_t yyleng/' common.h || die

	cd "${S_LIB}" || die
	mv makefile.unix Makefile || die
	find . \( -name '*.make' -o -name 'Makefile' \) | xargs sed -i "s+/usr/hla+${S_BIN}+g"
}

src_compile() {
	cd "${S_LIB}/trunk" || die
	einfo "Building hlalib in ${S_LIB}/trunk ..."
	local oldpath="${PATH}"
	export PATH="${S_BIN}:${PATH}"
	export hlalib="${S_BIN}/hlalib"
	export hlainc="${S_BIN}/include"
	use amd64 && export hlaopt="-lmelf_i386"
	# -jX causes weird issues
	emake -j1

	cd "${S}" || die
	einfo "Building hla in ${S} ..."
	emake clean
	emake hla hlaparse

	cd "${S_LIB}" || die
	einfo "Building utils in ${S_LIB} ..."
	emake utils

	export PATH="${oldpath}"
}

src_install() {
	dodir /usr/hla
	cp "${S}/hla"{,parse} "${ED}/usr/hla" || die
	cp "${S_BIN}"/{hlacmp,delete,mkMake} "${ED}/usr/hla" || die
	dosym /usr/hla/hla /usr/bin/hla
	dosym /usr/hla/hlaparse /usr/bin/hlaparse

	cp -r "${S_BIN}/include" "${ED}/usr/hla" || die

	dodir /usr/hla/hlalib
	cp "${S_LIB}/trunk"/*.a "${ED}/usr/hla/hlalib" || die

	if use amd64; then
		dodir /etc/env.d
		echo 'hlaopt="-lmelf_i386"' >> "${ED}/etc/env.d/20hla"
	fi
}
