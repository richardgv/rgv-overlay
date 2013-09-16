# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit xorg-2

DESCRIPTION="a program to monitor X11/Client conversations"
HOMEPAGE="http://cgit.freedesktop.org/xorg/app/xscope/"
XORG_MODULE="app"
SRC_URI="http://cgit.freedesktop.org/xorg/app/xscope/snapshot/xscope-1.3.99.901.tar.gz"
RESTRICT="mirror"

XORG_EAUTORECONF="yes"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${DEPEND}"
RDEPEND="${DEPEND}"

