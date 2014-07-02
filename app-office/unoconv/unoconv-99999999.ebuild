# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/unoconv/unoconv-99999999.ebuild,v 1.2 2012/03/31 11:57:35 scarabeus Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )
EGIT_REPO_URI="https://github.com/dagwieers/unoconv.git"

[[ ${PV} == 9999* ]] && SCM_ECLASS="git-r3"
inherit python-single-r1 eutils ${SCM_ECLASS}
unset SCM_ECLASS

DESCRIPTION="Convert between document formats supported by Libreoffice"
HOMEPAGE="http://dag.wieers.com/home-made/unoconv/"
[[ ${PV} == 9999* ]] || SRC_URI="http://dev.gentooexperimental.org/~scarabeus/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
[[ ${PV} == 9999* ]] || KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	!app-text/odt2txt
	|| (
		app-office/libreoffice-bin[${PYTHON_USEDEP}]
		app-office/libreoffice[${PYTHON_USEDEP}]
		python_single_target_python2_7? ( app-office/openoffice-bin )
		)
"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_prepare() {
	# epatch "${FILESDIR}/timeout.patch"
	python_fix_shebang "${S}"
}

src_compile() {
	emake doc
}

src_install() {
	emake DESTDIR="${ED}" install install-links
}
