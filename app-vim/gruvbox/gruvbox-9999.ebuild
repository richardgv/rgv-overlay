# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit vim-plugin git-r3

DESCRIPTION="vim plugin: Retro groove color scheme"
HOMEPAGE="https://github.com/morhetz/gruvbox"
LICENSE="MIT"
KEYWORDS=""

EGIT_REPO_URI="https://github.com/morhetz/${PN}.git"

src_prepare() {
	rm package.json || die
	rm gruvbox_256palette*.sh || die
}
