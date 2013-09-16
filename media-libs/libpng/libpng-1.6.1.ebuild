# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libpng/libpng-1.6.1.ebuild,v 1.2 2013/04/09 20:13:51 ssuominen Exp $

EAPI=5

inherit eutils libtool multilib

DESCRIPTION="Portable Network Graphics library"
HOMEPAGE="http://www.libpng.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.xz
	apng? ( mirror://sourceforge/libpng-apng/${P}-apng.patch.gz -> ${P}-apng-lfs.patch.gz )"

LICENSE="libpng"
SLOT="0/16"
KEYWORDS=""
IUSE="apng neon static-libs"

RDEPEND="sys-libs/zlib:="
DEPEND="${RDEPEND}
	app-arch/xz-utils"

DOCS=( ANNOUNCE CHANGES libpng-manual.txt README TODO )

src_prepare() {
	if use apng; then
		epatch "${WORKDIR}"/${PN}-*-apng-lfs.patch
		# Don't execute symbols check with apng patch wrt #378111
		sed -i -e '/^check/s:scripts/symbols.chk::' Makefile.in || die
	fi
	elibtoolize
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		--enable-arm-neon=$(usex neon on off)
}

src_install() {
	default
	# Even prune_libtool --all fails to remove libpng.la dead symlink wrt #436996
	find "${ED}" -name '*.la' -exec rm -f {} +
}

pkg_preinst() {
	has_version ${CATEGORY}/${PN}:1.5 && return 0
	preserve_old_lib /usr/$(get_libdir)/libpng15$(get_libname 15)
}

pkg_postinst() {
	has_version ${CATEGORY}/${PN}:1.5 && return 0
	preserve_old_lib_notify /usr/$(get_libdir)/libpng15$(get_libname 15)
}
