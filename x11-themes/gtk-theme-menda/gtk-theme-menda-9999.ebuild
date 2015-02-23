# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="Manjaro's official GTK themes, based on Vertex by horst3180"
HOMEPAGE="https://github.com/manjaro/artwork-menda"
EGIT_REPO_URI="https://github.com/manjaro/artwork-menda.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="x11-themes/gtk-engines-murrine"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS LICENSE README.md )

src_install() {
	default

	insinto /usr/share/themes
	doins -r Menda{,-Dark}
}
