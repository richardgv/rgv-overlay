# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools-multilib

DESCRIPTION="a C++ library to provide an implementation of MARISA"
HOMEPAGE="https://code.google.com/p/marisa-trie/"
SRC_URI="https://marisa-trie.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="popcnt sse2 sse3 ssse3 sse4_1 sse4_2 sse4 sse4a static-libs"

DEPEND=""
RDEPEND="${DEPEND}"

src_configure() {
	local myeconfargs=(
		$(use_enable popcnt)
		$(use_enable sse2)
		$(use_enable sse3)
		$(use_enable ssse3)
		$(use_enable sse4_1 sse4.1)
		$(use_enable sse4_2 sse4.2)
		$(use_enable sse4 sse4)
		$(use_enable sse4a)
	)
	multilib-minimal_src_configure
}

