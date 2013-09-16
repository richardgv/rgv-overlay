# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="Sogou pinyin for fcitx"
HOMEPAGE="http://linuxdeepin.com/"
SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/f/fcitx-sogoupinyin/${PN}_0.0.0.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=app-i18n/fcitx-4.2.6"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_prepare() {
	# Drop predefined LDFLAGS
	sed -i 's/-Wl,--as-needed //' "${S}/CMakeLists.txt" || die

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
	)
	cmake-utils_src_configure
}
