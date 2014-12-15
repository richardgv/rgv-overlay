# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bless/bless-0.6.0-r2.ebuild,v 1.1 2014/12/02 16:16:00 pacho Exp $

EAPI=5
GCONF_DEBUG="no"

inherit autotools eutils gnome2 mono-env

DESCRIPTION="GTK# Hex Editor"
HOMEPAGE="http://home.gna.org/bless/"
SRC_URI="http://download.gna.org/bless/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="
	>=dev-lang/mono-1.1.14
	|| (
		( >=dev-dotnet/gtk-sharp-2.12:2 >=dev-dotnet/glade-sharp-2.12:2 )
		>=dev-dotnet/gtk-sharp-2.12.21:2
		)
"
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=sys-devel/gettext-0.15
	virtual/pkgconfig
"

# See bug 278162
# Waiting on nunit ebuild entering the tree
RESTRICT="test"

pkg_setup() {
	# Stolen from enlightenment.eclass
	cp $(type -p gettextize) "${T}/" || die "Could not copy gettextize"
	sed -i -e 's:read dummy < /dev/tty::' "${T}/gettextize"
}

src_prepare() {
	# Use .NET 4.0 runtime instead of the default, 2.0
	# There's a bless-script.in in "${S}" as well, but it's not the working
	# one
	sed -i 's/^mono /mono --runtime=v4.0.30128 /' "${S}/src/bless-script.in" \
		|| die

	einfo "Running gettextize -f --no-changelog..."
	( "${T}/gettextize" -f --no-changelog > /dev/null ) || die "gettexize failed"
	epatch "${FILESDIR}/${P}-pixmap.patch"
	epatch "${FILESDIR}/${P}-docpath.patch"
	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--enable-unix-specific \
		$(use_enable debug)
}
