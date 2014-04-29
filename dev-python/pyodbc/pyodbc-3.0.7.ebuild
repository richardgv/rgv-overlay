# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyodbc/pyodbc-3.0.7.ebuild,v 1.3 2014/01/14 13:52:39 ago Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7,3_{2,3,4}} )

inherit distutils-r1

DESCRIPTION="python ODBC module to connect to almost any database"
HOMEPAGE="http://code.google.com/p/pyodbc"
SRC_URI="http://pyodbc.googlecode.com/files/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="mssql"

RDEPEND=">=dev-db/unixODBC-2.3.0
	mssql? ( >=dev-db/freetds-0.64[odbc] )"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools[${PYTHON_USEDEP}]"

# PYTHON_CXXFLAGS=("* + -fno-strict-aliasing")
