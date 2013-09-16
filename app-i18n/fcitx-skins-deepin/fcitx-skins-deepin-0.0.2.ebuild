# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Sogou pinyin skin for fcitx"
HOMEPAGE="http://linuxdeepin.com"

MY_PN="fcitx-skins"
SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/f/${MY_PN}/${MY_PN}_${PV}.tar.gz"

LICENSE="unknown"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=app-i18n/fcitx-4.2"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"

src_prepare() {
	rm -r "${S}/debian" || die
}

src_install() {
	insinto "/usr/share/fcitx/skin/"
	doins -r "${S}/"*
}
