# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit base cmake-utils subversion

DESCRIPTION="Simple gettext replacement by SuperTux devs"
HOMEPAGE="http://tinygettext.googlecode.com/"
SRC_URI=""
ESVN_REPO_URI="http://tinygettext.googlecode.com/svn/trunk"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/trunk"

src_configure() {
	local mycmakeargs=( -DWERROR=OFF )

	cmake-utils_src_configure
}
