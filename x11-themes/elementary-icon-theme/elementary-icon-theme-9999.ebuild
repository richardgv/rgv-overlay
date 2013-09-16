# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit gnome2-utils bzr

DESCRIPTION="Elementary icon theme is designed to be smooth, sexy, clear, and efficient"
HOMEPAGE="https://launchpad.net/elementaryicons"
EBZR_REPO_URI="lp:elementaryicons"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

DOCS=( AUTHORS COPYING CONTRIBUTORS )

src_install() {
	default

	rm ${DOCS} || die

	insinto /usr/share/icons/elementary
	doins -r *
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
