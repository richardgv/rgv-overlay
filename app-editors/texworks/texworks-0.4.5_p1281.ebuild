# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit qt4-r2 eutils


DESCRIPTION="An environment for authoring TeX (LaTeX, ConTeXt, etc) documentsfor casual and non-technical users."
HOMEPAGE="http://code.google.com/p/texworks"

MY_P="${P/_p/-r}"
SRC_URI="http://${PN}.googlecode.com/files/${MY_P}.tar.gz"
# ESVN_REPO_URI="http://texworks.googlecode.com/svn/trunk/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=dev-qt/qtcore-4.5.0
	 >=app-text/poppler-0.10.6[qt4]
	 >=app-text/hunspell-1.2.2"


S="${WORKDIR}/${P/_p*//}"

src_configure() {
	eqmake4 TeXworks.pro
}

src_install() {
	dobin texworks
	insinto /usr/share/applications
	doins "${FILESDIR}"/texworks.desktop || die "Install texwork.desktop failed!"
	insinto /usr/share/pixmaps
	doins "${FILESDIR}"/icon/texworks.png || die "Install texwork icon failed!"
}
