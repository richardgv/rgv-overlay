# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/gnu-efi/gnu-efi-3.0s.ebuild,v 1.1 2012/11/25 04:27:08 vapier Exp $

EAPI="4"

inherit eutils multilib

MY_P="${PN}_${PV}"
DEB_VER="3.0i-4"
DESCRIPTION="Library for build EFI Applications"
HOMEPAGE="http://developer.intel.com/technology/efi"
SRC_URI="mirror://sourceforge/gnu-efi/${MY_P}.orig.tar.gz
	mirror://debian/pool/main/g/gnu-efi/${PN}_${DEB_VER}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

DEPEND="sys-apps/pciutils"
RDEPEND=""

S=${WORKDIR}/${P%?}

# These objects get run early boot (i.e. not inside of Linux),
# so doing these QA checks on them doesn't make sense.
QA_EXECSTACK="usr/*/lib*efi.a:* usr/*/crt*.o"

src_prepare() {
	EPATCH_OPTS="-p1" epatch "${WORKDIR}"/*.diff

	# Fedora patches
	epatch "${FILESDIR}/${PN}-disable-ms_abi-flag.patch"
	# epatch "${FILESDIR}/${PN}-libs-x86_64-call-fix.patch"
	epatch "${FILESDIR}/${PN}-3.0q-route80h.patch"
	epatch "${FILESDIR}/${PN}-3.0q-modelist.patch"
	epatch "${FILESDIR}/${PN}-3.0q-route80h-add-cougarpoint.patch"
	epatch "${FILESDIR}/${PN}-3.0q-machine-types.patch"
	epatch "${FILESDIR}/${PN}-3.0q-handle-uninitialized-gop.patch"
	epatch "${FILESDIR}/${PN}-3.0q-Add-.S-and-.E-rules.patch"

	sed -i -e '/^CFLAGS/s:$: -fno-stack-protector:' Make.defaults || die #444246
}

_emake() {
	emake prefix=${CHOST}- ARCH=${iarch} LIBDIR=$(get_libdir) "$@"
}

src_compile() {
	case ${ARCH} in
		ia64)  iarch=ia64 ;;
		x86)   iarch=ia32 ;;
		amd64) iarch=x86_64 ;;
		*)     die "unknown architecture: $ARCH" ;;
	esac
	# The lib subdir uses unsafe archive targets, and
	# the apps subdir needs gnuefi subdir
	_emake -j1
}

src_install() {
	_emake install INSTALLROOT="${D}"/usr
	dodoc README* ChangeLog
}
