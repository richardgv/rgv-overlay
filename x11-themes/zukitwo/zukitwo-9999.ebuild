# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Header: $

EAPI=5

inherit git-r3

DESCRIPTION="Theme for GNOME 2 and 3"
HOMEPAGE="http://gnome-look.org/content/show.php/Zukitwo?content=140562"
SRC_URI=""

EGIT_REPO_URI="https://github.com/lassekongo83/zuki-themes.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.10:2
	>=x11-libs/gtk+-3.8:3
	>=x11-themes/gnome-themes-standard-3.8
	>=x11-themes/gtk-engines-murrine-0.98.1.1
	!x11-themes/zukitwo-shell"
DEPEND="app-arch/unzip"

# S="${WORKDIR}"

DOCS=( README.md )

src_prepare() {
	# Gentoo uses normal nautilus, not nautilus-elementary
	find . -name 'gtkrc' -exec sed -e 's:apps/nautilus-e.rc:apps/nautilus.rc:' \
		-i '{}' ';' || die
}

src_install() {
	insinto /usr/share/themes
	doins -r ZukiShell Zukitre Zukitre-firefox-theme Zukitwo Zukiwi
	default
}

