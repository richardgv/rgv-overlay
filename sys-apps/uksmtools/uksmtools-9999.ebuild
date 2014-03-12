# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="Simple tool to monitor and control UKSM."
HOMEPAGE="https://github.com/pfactum/uksmtools"
SRC_URI=""
EGIT_REPO_URI="https://github.com/pfactum/uksmtools.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${ED}" PREFIX=/usr install
	dodoc README.md
}
