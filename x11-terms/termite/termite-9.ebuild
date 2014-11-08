# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

UTIL_REV="62faf9e46b8c4ab213ac42aaf6343dea9e2dfc1e"
DESCRIPTION="A keyboard-centric VTE-based terminal"
HOMEPAGE="https://github.com/thestinger/termite/"
SRC_URI="https://github.com/thestinger/termite/archive/v${PV}.tar.gz -> ${P}.tar.gz
https://github.com/thestinger/util/archive/${UTIL_REV}.zip -> thestinger-util-${UTIL_REV}.zip"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/gtk+:3
	x11-libs/vte:2.91"
RDEPEND="${DEPEND}"

src_unpack() {
	default

	# Move the submodule content over
	mv "${WORKDIR}/util-${UTIL_REV}/"* "${S}/util" || die
}

src_prepare() {
	# Check whether x11-libs/vte:2.91 is patched
	local has_obj=$(objdump -T /usr/lib/libvte-2.91.so \
		| grep -F vte_terminal_set_cursor_position)
	if [ -z "$has_obj" ]; then
		ewarn "To compile ${P}, x11-libs/vte:2.90 needs to be patched with:"
		ewarn "https://raw.githubusercontent.com/thestinger/termite/f9f285e5bac1ab0a865bb604e1ef499b7c52f74e/expose_select_text.patch"
	fi

	# Strip LDFLAGS
	sed -i 's/\(CXXFLAGS :=.*\) -O3/\1/' "${S}/Makefile" || die

	# Strip LDFLAGS
	sed -i 's/\(LDFLAGS :=.*\) -s -Wl,--as-needed/\1/' "${S}/Makefile" || die
}

src_compile() {
	emake VERSION="v9"
}

src_install() {
	emake PREFIX=/usr DESTDIR="${ED}" install
}
