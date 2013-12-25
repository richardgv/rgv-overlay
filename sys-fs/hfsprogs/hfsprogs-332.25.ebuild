# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="HFS/HFS+ user space utils"
HOMEPAGE="http://www.opensource.apple.com/"
SRC_URI="mirror://debian/pool/main/h/hfsprogs/hfsprogs_${PV}.orig.tar.gz
mirror://debian/pool/main/h/hfsprogs/hfsprogs_${PV}-10.debian.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/libbsd"
RDEPEND="${DEPEND}"

S="${WORKDIR}/diskdev_cmds-${PV}"

src_prepare() {
	EPATCH_SUFFIX="" EPATCH_FORCE="yes" \
		EPATCH_EXCLUDE="80-remove_see-also_from_manpage.patch 90-fix_manpage_typos.patch series" \
		epatch "${WORKDIR}/debian/patches"
	sed -i -e 's/.*aggregate\.make.*//' -e 's/.*platform\.make.*//' "${S}/Makefile"

	default
}

src_compile() {
	emake
}
