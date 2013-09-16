# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games

DESCRIPTION="A UCI chess engine"
HOMEPAGE="http://www.stockfishchess.com/"
SRC_URI="http://cl.ly/2n1O3h2d3u2W/download/stockfish-3-linux.zip
	http://cl.ly/3x333m0G173F/download/stockfish-231-book.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="clang +c++0x icc +pgo +popcnt"
REQUIRED_USE="?? ( clang icc )"

DEPEND=""
RDEPEND="${DEPEND}"

pkg_setup() {
	if use c++0x; then
		S="${WORKDIR}/${P}-linux/src_c11"
	else
		S="${WORKDIR}/${P}-linux/src"
	fi
}

src_prepare() {
	sed -i 's/CXXFLAGS += -flto/CXXFLAGS += -flto -fuse-linker-plugin -fno-fat-lto-objects -flto-partition=none/' "${S}/Makefile" || die
}

src_compile() {
	local ARCH=x86-32
	if use amd64; then
		ARCH=x86_64
		use popcnt && ARCH=x86-64-modern
	fi
	local COMP=gcc
	use clang && COMP=clang
	use icc && COMP=icc
	local TGT=build
	use pgo && TGT=profile-build

	emake ARCH="${ARCH}" COMP="${COMP}" "${TGT}"
}

src_install() {
	dogamesbin "${PN}"

	cd "${WORKDIR}/${P}-linux"
	insinto "${GAMES_DATADIR}/${PN}"
	doins logo.bmp polyglot.ini
	dodoc Readme.txt

	cd "${WORKDIR}"
	doins Book.bin
}
