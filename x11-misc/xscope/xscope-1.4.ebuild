# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

XORG_EAUTORECONF="yes"

inherit xorg-2

DESCRIPTION="a program to monitor X11/Client conversations"
HOMEPAGE="http://cgit.freedesktop.org/xorg/app/xscope/"
XORG_MODULE="app"
SRC_URI="http://xorg.freedesktop.org/archive/individual/app/${P}.tar.bz2"
RESTRICT="mirror"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${DEPEND}"
RDEPEND="${DEPEND}"
