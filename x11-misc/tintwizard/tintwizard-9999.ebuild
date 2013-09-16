# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/tintwizard/tintwizard-0.3.4-r1.ebuild,v 1.3 2010/08/20 07:46:16 fauli Exp $

EAPI="3"

PYTHON_DEPEND="2"

inherit python subversion

DESCRIPTION="GUI wizard which generates config files for tint2 panels"
HOMEPAGE="http://code.google.com/p/tintwizard/"
# SRC_URI="http://tintwizard.googlecode.com/files/${P}.tar.gz"
ESVN_REPO_URI="http://tintwizard.googlecode.com/svn/trunk/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="~x11-misc/tint2-${PV}
	dev-python/pygtk:2"

src_prepare() {
	python_convert_shebangs 2 tintwizard.py
}

src_install() {
	dodoc ChangeLog

	dobin tintwizard.py || die
	dosym /usr/bin/tintwizard.py /usr/bin/tintwizard || die
}
