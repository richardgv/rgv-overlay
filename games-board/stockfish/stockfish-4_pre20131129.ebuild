# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games

MY_PV="dd"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="A UCI chess engine"
HOMEPAGE="http://www.stockfishchess.com/"
SRC_URI="https://s3.amazonaws.com/stockfish/${MY_P}-src.zip
	http://cl.ly/3x333m0G173F/download/stockfish-231-book.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="clang +c++0x icc +pgo +popcnt"
REQUIRED_USE="?? ( clang icc )"

DEPEND=""
RDEPEND="${DEPEND}"

pkg_setup() {
	S="${WORKDIR}/${MY_P}-src/src"
	use c++0x && S+="_c11"
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

	cd "${S}/.." || die
	insinto "${GAMES_DATADIR}/${PN}"
	doins logo.bmp polyglot.ini
	dodoc Readme.md

	cd "${WORKDIR}" || die
	doins Book.bin
}
