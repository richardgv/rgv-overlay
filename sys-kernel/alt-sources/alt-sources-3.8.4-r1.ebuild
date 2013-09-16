# Copyright (C) 2013 Jonathan Vasquez <jvasquez1011@gmail.com>
# Distributed under the terms of the Simplified BSD License.

EAPI="4"

inherit eutils

# For System Rescue CD 3.5.0 (Alternate Kernel)
TAIL="alt350-amd64"
KERNEL="linux-${PV}-${TAIL}"
KERNEL_CONF="kernel-${PV}-${TAIL}.conf"
KV="3.8"
KERNEL_FILE="linux-${KV}.tar.bz2"

DESCRIPTION="Kernel Sources and Patches for the System Rescue CD Alternate Kernel"
HOMEPAGE="http://kernel.sysresccd.org/"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v3.x/${KERNEL_FILE}"

RESTRICT="mirror"
LICENSE="GPL-2"
SLOT="${PV}"
KEYWORDS="~amd64"

S="${WORKDIR}/${KERNEL}"

src_unpack()
{
	unpack ${KERNEL_FILE}
	mv ${KERNEL_FILE%.tar*} ${KERNEL}
}

src_prepare()
{
	epatch ${FILESDIR}/${PV}/${PN}-${KV}-01-stable-${PV}.patch.bz2 || die "alt-sources stable patch failed."
	epatch ${FILESDIR}/${PV}/${PN}-${KV}-02-fc17.patch.bz2 || die "alt-sources fedora patch failed."
	epatch ${FILESDIR}/${PV}/${PN}-${KV}-03-aufs.patch.bz2 || die "alt-sources aufs patch failed."
}

src_compile() {
	# Unset ARCH so that you don't get Makefile not found messages
	unset ARCH && return;
}

src_install()
{
	mkdir -p ${D}/usr/src
	mv ${S} ${D}/usr/src
	cd ${D}/usr/src/${KERNEL} && make distclean
	cp ${FILESDIR}/${PV}/${KERNEL_CONF} .config

	# Change local version
	sed -i -e "s%CONFIG_LOCALVERSION=\"\"%CONFIG_LOCALVERSION=\"-${TAIL}\"%" .config

	# Remove old initramfs path crap
	sed -i -e "s%CONFIG_INITRAMFS_SOURCE=\"/var/tmp/genkernel/initramfs-${PV}-${TAIL}.cpio\"%CONFIG_INITRAMFS_SOURCE=\"\"%" .config

	# Set CONFIG_USER_NS (User Namespaces) to no
	sed -i -e "s%CONFIG_USER_NS=y%CONFIG_USER_NS=n%" .config
}

