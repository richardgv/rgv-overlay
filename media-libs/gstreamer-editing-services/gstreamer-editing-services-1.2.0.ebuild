# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="GStreamer editing services"
HOMEPAGE="http://gstreamer.freedesktop.org"
SRC_URI="http://gstreamer.freedesktop.org/src/${PN}/${P}.tar.xz"

LICENSE="LGPL-2"
SLOT="1.0"
KEYWORDS="~amd64 ~x86"
# pyobject-4.22 is demanded for python support? And gst-validate?
IUSE=""

DEPEND=">=media-libs/gstreamer-1.2.0:1.0
	>=media-libs/gst-plugins-base-1.2.0:1.0
	>=media-libs/gnonlin-1.2.0:1.0"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS ChangeLog NEWS README RELEASE )
