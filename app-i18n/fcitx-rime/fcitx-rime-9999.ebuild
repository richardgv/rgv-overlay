# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/fcitx-rime/fcitx-rime-0.2.2.ebuild,v 1.1 2013/07/24 12:33:50 yngwin Exp $

EAPI=5

inherit cmake-utils git-2

DESCRIPTION="Rime support for Fcitx"
HOMEPAGE="http://fcitx-im.org/"
SRC_URI=""
EGIT_REPO_URI="https://github.com/fcitx/fcitx-rime.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=app-i18n/fcitx-4.2.8
	~app-i18n/librime-${PV}
	app-i18n/rime-data
	x11-libs/libnotify"
DEPEND="${RDEPEND}"

src_prepare() {
	# dont build data resource here, already provided by app-i18n/rime-data
	# sed -i -e 's|add_subdirectory(data)||' CMakeLists.txt || die
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DRIME_DATA_DIR=/usr/share/rime-data
	)
	cmake-utils_src_configure
}
