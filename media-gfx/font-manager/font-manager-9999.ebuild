# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

WANT_AUTOCONF=2.5
WANT_AUTOMAKE=1.11
AUTOTOOLS_AUTORECONF=1
VALA_MIN_API_VERSION=0.24

inherit gnome2-utils vala autotools-utils subversion

DESCRIPTION="A font management application for the GNOME desktop"
HOMEPAGE="http://code.google.com/p/font-manager"
SRC_URI=""
ESVN_REPO_URI="http://font-manager.googlecode.com/svn/trunk/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=dev-db/sqlite-3.8:3
	>=dev-libs/glib-2.4
	>=dev-libs/json-glib-0.15
	>=dev-libs/libgee-0.14:0.8
	>=dev-libs/libxml2-2.9
	>=gnome-extra/gucharmap-3.12:2.90
	>=media-libs/fontconfig-2.1
	>=media-libs/freetype-2.5
	>=x11-libs/cairo-1.1
	>=x11-libs/gtk+-3.12:3
	>=x11-libs/pango-1.3
	sys-devel/gettext
	"
DEPEND="${RDEPEND}
	$(vala_depend)
	app-arch/file-roller
	app-text/yelp-tools
	dev-util/intltool
	gnome-base/gnome-common
	"

# Doesn't do out-of-source build correctly
AUTOTOOLS_IN_SOURCE_BUILD=1

src_prepare() {
	vala_src_prepare
	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		--disable-schemas-compile
	)
	autotools-utils_src_configure
}

src_compile() {
	# Parallel build does not work
	autotools-utils_src_compile -j1
}

src_install() {
	autotools-utils_src_install

	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
