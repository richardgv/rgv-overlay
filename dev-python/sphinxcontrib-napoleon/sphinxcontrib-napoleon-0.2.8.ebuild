# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Extension to parse Google / NumPy style documentation"
HOMEPAGE="https://pypi.python.org/pypi/sphinxcontrib-napoleon http://sphinxcontrib-napoleon.readthedocs.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/sphinx-1.2[${PYTHON_USEDEP}]
	>=dev-python/paver-1.2.0[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

src_prepare() {
	# Don't install 'tests' package
	sed -i "s/packages=find_packages()/packages=find_packages(exclude=('tests', 'tests.*'))/" "${S}/setup.py" || die

	distutils-r1_src_prepare
}
