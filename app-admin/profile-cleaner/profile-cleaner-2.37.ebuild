# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Vacuum and reindex browser sqlite databases"
HOMEPAGE="https://github.com/graysky2/profile-cleaner"
SRC_URI="https://github.com/graysky2/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="app-shells/bash
	sys-devel/bc
	sys-apps/coreutils
	sys-apps/findutils
	sys-apps/grep
	sys-apps/sed
	sys-process/parallel
	dev-db/sqlite:3"

src_install() {
	default

	# Remove the symlink "profile-cleaner.1.gz" as the main man page will be
	# recompressed by Portage
	rm "${ED}usr/share/man/man1/${PN}.1.gz" || die
}
