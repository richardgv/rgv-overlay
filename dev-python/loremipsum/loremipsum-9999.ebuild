# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy )

inherit git-r3 distutils-r1

DESCRIPTION="A Lorem Ipsum text generator"
HOMEPAGE="http://projects.monkeython.com/loremipsum"
EGIT_REPO_URI="https://github.com/monkeython/loremipsum.git"

LICENSE="BSD"
KEYWORDS=""
SLOT="0"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}/${P}-find-packages.patch" )
