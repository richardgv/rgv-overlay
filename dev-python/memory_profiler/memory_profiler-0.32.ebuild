# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="A module for monitoring memory usage of a python program"
HOMEPAGE="https://github.com/fabianp/memory_profiler"
SRC_URI="mirror://pypi/m/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/psutil"
RDEPEND="${DEPEND}"

DOCS=( README.rst )
