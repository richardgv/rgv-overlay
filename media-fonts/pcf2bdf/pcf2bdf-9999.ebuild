# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2

DESCRIPTION="convert PCF fonts to BDF"
HOMEPAGE="https://github.com/ganaware/pcf2bdf"
SRC_URI=""
EGIT_REPO_URI="git://github.com/ganaware/pcf2bdf.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	mv Makefile.gcc Makefile
}

src_install() {
	emake DESTDIR="${ED}" PREFIX="${EPREFIX}/usr" install
}
