# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="a suite of CPU, GPU, OpenGL debugging / profiling tools"
HOMEPAGE="http://developer.amd.com/tools/heterogeneous-computing/codexl/"

MY_P="CodeXL-Linux-${PV}-x86_64-release"
SRC_URI="amd64? ( http://developer.amd.com/download/${MY_P}.tar.gz )"
RESTRICT="mirror"

LICENSE="unknown"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	media-libs/libpng:1.2"

S="${WORKDIR}/${MY_P}/Output_x86_64/release"

src_install() {
	dodir /opt
	cp -rP "${S}/bin" "${ED}/opt/codexl" || die
	cp -rP "${S}/AMDAPPKernelAnalyzer2-V2.1.527.0" "${ED}/opt/AMDAPPKernelAnalyzer2" || die
}
