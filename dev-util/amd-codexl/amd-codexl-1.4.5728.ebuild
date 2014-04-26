# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="a suite of CPU, GPU, OpenGL debugging / profiling tools"
HOMEPAGE="http://developer.amd.com/tools/heterogeneous-computing/codexl/"

MY_P="AMD_CodeXL_Linux_x86_64_${PV}"
SRC_URI="amd64? ( http://developer.amd.com/download/${MY_P}.tar.gz )"
RESTRICT="mirror"

LICENSE="unknown"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	media-libs/libpng:1.2"

S="${WORKDIR}/${MY_P}"

QA_PREBUILT="/opt/codexl/*"

src_install() {
	dodir /opt
	cp -rP "${S}" "${ED}/opt/codexl" || die
}
