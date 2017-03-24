# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit font

DESCRIPTION="a programming typeface"
HOMEPAGE="https://github.com/madmalik/mononoki"
SRC_URI="https://github.com/madmalik/${PN}/releases/download/${PV}/${PN}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S="${WORKDIR}"
FONT_S="."
FONT_SUFFIX="ttf"
