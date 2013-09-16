# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PLOCALES="ar_SA bg_BG cs_CZ de_DE el_GR it_IT lt_LT ru_RU uk_UA vi_VN zh_CN"

inherit l10n qt4-r2 git-2

DESCRIPTION="Feature-rich dictionary lookup program"
HOMEPAGE="http://goldendict.org/"
SRC_URI=""

EGIT_REPO_URI="git://github.com/goldendict/goldendict.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="debug kde"

RDEPEND="
	>=app-text/hunspell-1.2
	media-libs/libogg
	media-libs/libvorbis
	sys-libs/zlib
	x11-libs/libXtst
	>=dev-qt/qtcore-4.5:4[exceptions,qt3support]
	>=dev-qt/qtgui-4.5:4[exceptions,qt3support]
	>=dev-qt/qtwebkit-4.5:4[exceptions]
	!kde? ( || (
		>=dev-qt/qtphonon-4.5:4[exceptions]
		media-libs/phonon
	) )
	kde? ( media-libs/phonon )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

S=${WORKDIR}

# PATCHES=( "${FILESDIR}/${P}-gcc-4.7.patch" )

src_prepare() {
	qt4-r2_src_prepare

	l10n_for_each_disabled_locale_do editpro

	# do not install duplicates
	sed -e '/[icon,desktop]s2/d' -i ${PN}.pro || die
}

src_configure() {
	PREFIX="${EPREFIX}"/usr eqmake4
}

src_install() {
	qt4-r2_src_install
	l10n_for_each_locale_do insqm
}

editpro() {
	sed -e "s;locale/${1}.ts;;" -i ${PN}.pro || die
}

insqm() {
	insinto /usr/share/apps/${PN}/locale
	doins locale/${1}.qm
}
