# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 eutils

DESCRIPTION="Transform DocBook using TeX macros"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://dblatex.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="
	app-text/texlive
	dev-texlive/texlive-latexextra
	dev-texlive/texlive-latexrecommended
	dev-texlive/texlive-mathextra
	dev-texlive/texlive-pictures
	dev-texlive/texlive-xetex
	dev-libs/libxslt
	app-text/docbook-xml-dtd
	gnome-base/librsvg
"
DEPEND="${RDEPEND}"

python_prepare_all() {
	sed -e "s:base=package_base:base='/usr/share/dblatex/':" \
		-i scripts/dblatex || die
	sed -e 's/"inkscape.*" % /"rsvg-convert -f %s -o %s %s" % /' \
		-i lib/dbtexmf/core/imagedata.py || die

	epatch "${FILESDIR}/${PN}-0.3.4-install_layout.patch"
}

python_install_all() {
	python_doscript "${S}"/scripts/dblatex

	mv "${D}"/usr/share/doc/${PN} "${D}"/usr/share/doc/${PF} || die "mv doc"
}
