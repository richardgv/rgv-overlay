# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit linux-mod eutils

DESCRIPTION="Fancy beep daemon"
HOMEPAGE="http://www.carcosa.net/jason/software/beep/"
SRC_URI="http://www.carcosa.net/jason/software/beep/beep-2.6.24+.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/beep-2.6.24"

MODULE_NAMES="beep(drivers/input/misc:${S}:${S})"
BUILD_TARGETS="default"

src_prepare() {
	sed -i 's/`uname -r`/'"$KV_FULL"'/g' Makefile
	epatch "${FILESDIR}/${P}-new-kern.patch"

	default
}

src_install() {
	linux-mod_src_install

	dodoc README
	dodoc -r daemons
}
