# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 

EAPI=5

inherit toolchain-funcs

DESCRIPTION="Repairs fried PNG files found inside iPhone/iPad .ipa files."
HOMEPAGE="http://www.jongware.com/pngdefry.html"
SRC_URI="http://www.jongware.com/binaries/pngdefry.zip"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}/source"

pkg_setup() {
	export CC=$(tc-getCC)
}

src_compile() {
	default
	${CC} "${S}/${PN}.c" -o "${PN}" || die
}

src_install() {
	default

	dobin "${S}/${PN}"
	doman "${S}/../man/"*
}
