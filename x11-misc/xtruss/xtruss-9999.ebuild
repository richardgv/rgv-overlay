# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit subversion

DESCRIPTION="an easy-to-use X protocol tracing program"
HOMEPAGE="http://www.chiark.greenend.org.uk/~sgtatham/xtruss/"
SRC_URI=""
ESVN_REPO_URI="svn://svn.tartarus.org/sgt/xtruss"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-mine.patch"

	default
}

src_install() {
	dobin "${S}/xtruss"
	dodoc README
}
