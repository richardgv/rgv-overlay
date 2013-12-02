# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="ARP scanning and fingerprinting tool"
HOMEPAGE="http://www.nta-monitor.com/tools-resources/security-tools/arp-scan"
SRC_URI="http://www.nta-monitor.com/files/${PN}/${P}.tar.gz"
RESTRICT=mirror

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-libs/libpcap"
RDEPEND="${DEPEND}"

src_install() {
	default

	dodoc ChangeLog NEWS README TODO AUTHORS
}

