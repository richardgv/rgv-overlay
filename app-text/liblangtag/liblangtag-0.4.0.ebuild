# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/liblangtag/liblangtag-0.4.0.ebuild,v 1.4 2013/01/12 13:20:59 scarabeus Exp $

EAPI=5

inherit autotools

DESCRIPTION="An interface library to access tags for identifying languages"
HOMEPAGE="http://tagoh.bitbucket.org/liblangtag/"
SRC_URI="https://bitbucket.org/tagoh/${PN}/downloads/${P}.tar.bz2"

LICENSE="|| ( LGPL-3 MPL-1.1 )"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="introspection static-libs test"

RDEPEND="
	dev-libs/glib
	dev-libs/libxml2
	introspection? ( >=dev-libs/gobject-introspection-0.10.8 )
"
DEPEND="${RDEPEND}
	sys-devel/gettext
	test? ( dev-libs/check )
"

# Upstream expect liblangtag to be installed when one runs tests...
RESTRICT="test"

src_prepare() {
	sed -i 's/\(reg2xml_LDFLAGS =\)/\1 -ldl/' data/Makefile.am || die
	sed -i 's/\(LIBS =\)/\1 -ldl/' tests/Makefile.am || die
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable introspection) \
		$(use_enable static-libs static) \
		$(use_enable test)
}

src_install() {
	default

	find "${ED}" -name '*.la' -exec rm -f {} +
}
