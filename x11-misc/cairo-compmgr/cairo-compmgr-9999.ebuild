# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION="0.20"
VALA_MAX_API_VERSION="0.20"

inherit autotools vala gnome2 git-2

DESCRIPTION="Cairo Composite Manager is a versatile and extensible composite manager using cairo for rendering."
HOMEPAGE="http://cairo-compmgr.tuxfamily.org/"
SRC_URI=""

# EGIT_REPO_URI="git://git.tuxfamily.org/gitroot/ccm/cairocompmgr.git"
EGIT_REPO_URI="https://github.com/gandalfn/Cairo-Composite-Manager.git"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE="gconf"

RDEPEND="gconf? ( gnome-base/gconf )
	>=x11-libs/gtk+-2.10.0
	>=x11-libs/cairo-1.4.10
	x11-libs/libXext
	x11-libs/libXdamage
	x11-libs/libXcomposite
	x11-libs/libXi
	x11-libs/libICE
	x11-libs/libSM
	virtual/opengl
	x11-libs/pixman
	x11-libs/libXrandr
	$(vala_depend)"
DEPEND="${RDEPEND}"
	# gnome-base/libgnomeui

AUTOTOOLS_AUTORECONF="1"
AUTOTOOLS_IN_SOURCE_BUILD="1"

src_prepare() {
	# Fix valac path
	# sed -i 's+\(AM_PROG_VALAC(\$VALA_REQUIRED)\)+\1\nVALAC=/usr/bin/valac-0.18+' configure.ac || die
	# export VALAC="$(type -p valac-$(vala_best_api_version))"
	vala_src_prepare

	# Vala-0.20
	sed -i -e 's/vala-0.18/vala-0.20/g' -e 's/VALA_REQUIRED=0.18.0/VALA_REQUIRED=0.20.0/g' "${S}/configure.ac" || die
	sed -i 's/vala-0.18/vala-0.20/g' "${S}/vapi/cairo-compmgr.deps" || die

	# Drop undesired flags
	sed -i -e 's+\(\[xcomposite\)+\1, gmodule-2.0+' \
		-e 's+-O3 -flto[[:space:]]*++' \
		configure.ac || die

	# Fix parallel build issues
	sed -i 's+\(--header\)=+\1 +' lib/Makefile.am || die
	sed -i 's+\(--header\)=+\1 +' build/plugin.am || die
	# sed -i 's+\(VALAFLAGS\s*=\)+PLUGIN_\1 +' build/plugin.am || die
	cat >> build/plugin.ex.am <<EOF
ifneq "\$(filter %.vala,\$(PLUGIN_SOURCES))" ""
  \$(PLUGIN).h: lib\$(subst -,_,\$(PLUGIN))_la_vala.stamp
	if test -f \$@; then :; else rm -f lib\$(subst -,_,\$(PLUGIN))_la_vala.stamp; \$(MAKE) \$(AM_MAKEFLAGS) \${derived}_vala.stamp; fi
endif
EOF
	echo '$(eval include $(top_srcdir)/build/plugin.ex.am)' >> build/plugin.am || die
	sed -i '1iM_LIBS = -lm\n' lib/Makefile.am || die
	# sed -i 's/--inject [^ ]*//' gir/Makefile.am || die

	# autotools-utils_src_prepare
	eautoreconf

	gnome2_src_prepare
}

src_configure() {
	G2CONF=""
	use gconf && G2CONF+="--enable-gconf"
	# local myeconfargs=(
	# 	--enable-gconf
	# 	# --enable-gobject-introspection
	# )

	# autotools-utils_src_configure
	gnome2_src_configure
}

# pkg_preinst() {
# 	gnome2_gconf_savelist
# }
# 
# pkg_postinst() {
# 	gnome2_gconf_install
# }
# 
# pkg_postrm() {
# 	gnome2_gconf_uninstall
# }
