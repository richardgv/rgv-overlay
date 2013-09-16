# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_DEPEND="2"

inherit python

DESCRIPTION="a tool for editing version-control repository history"
HOMEPAGE="http://catb.org/~esr/reposurgeon/"
SRC_URI="http://www.catb.org/~esr/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	python_convert_shebangs ${PYTHON_DEPEND} reposurgeon repopuller repodiffer
	emake DESTDIR="${ED}" prefix=/usr install
}
