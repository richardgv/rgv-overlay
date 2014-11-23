# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Linux screen capture using pygtk, inspired by scrot"
HOMEPAGE="https://github.com/Roger/escrotum"
SRC_URI="mirror://pypi/e/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/pygtk:2[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
