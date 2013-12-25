# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION=""
HOMEPAGE="http://www.numberworld.org/y-cruncher/"
MY_P="${PN} v${PV/_alpha/ Alpha}"
SRC_URI="http://www.numberworld.org/${PN}/${MY_P// /%20}.tar.gz"
RESTRICT="strip"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN} Linux v${PV/_alpha/}"

src_install() {
	insinto "/opt/${PN}"
	exeinto "/opt/${PN}"
	for i in "${S}/"*.out; do
		newexe "$i" ${PN}-$(basename "$i" | tr -d ' ~' | sed 's/\.out$//')
	done
	doins "${S}/"*.txt
}
