# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Simple text-mode UEFI Boot Manager"
HOMEPAGE="http://freedesktop.org/wiki/Software/gummiboot"
SRC_URI="ftp://ftp.archlinux.org/other/gummiboot-efi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-fs/dosfstools
	sys-boot/efibootmgr
	sys-boot/gnu-efi"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -e 's|LIBDIR=|LIBDIR?=|g' -i "${S}/Makefile"
}

src_install() {
	newbin "${S}/loader-postinst.sh" "${PN}-loader-postinst.sh"
	insinto /usr/share/gummiboot
	newins "${S}/gummiboot.efi" "gummiboot_${ARCH}.efi"

	dodoc README TODO
}
