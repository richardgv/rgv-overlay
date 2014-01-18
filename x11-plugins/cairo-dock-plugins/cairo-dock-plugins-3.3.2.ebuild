# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit cmake-utils eutils versionator

MY_PN="${PN/plugins/plug-ins}"
MM_PV=$(get_version_component_range '1-2')

DESCRIPTION="Official plugins for cairo-dock"
HOMEPAGE="http://www.glx-dock.org"
SRC_URI="http://launchpad.net/${MY_PN}/${MM_PV}/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE="alsa +exif +ical gmenu impulse indicator3 gnome kde mail mono python ruby +lm_sensors upower vala vte webkit xfce xgamma +xklavier zeitgeist"

RDEPEND="
	dev-libs/dbus-glib
	dev-libs/glib:2
	dev-libs/libxml2
	gnome-base/librsvg:2
	sys-apps/dbus
	x11-libs/cairo
	x11-libs/gtkglext
	~x11-misc/cairo-dock-${PV}
	x11-libs/gtk+:3
	alsa? ( media-libs/alsa-lib )
	ical? ( dev-libs/libical )
	exif? ( media-libs/libexif )
	gmenu? ( gnome-base/gnome-menus )
	kde? ( kde-base/kdelibs )
	vte? ( x11-libs/vte )
	vala? ( dev-lang/vala:0.12 )
	webkit? ( >=net-libs/webkit-gtk-1.0 )
	xfce? ( xfce-base/thunar )
	xgamma? ( x11-libs/libXxf86vm )
	xklavier? ( x11-libs/libxklavier )
	indicator3? (
		dev-libs/libindicator:3
		dev-libs/libdbusmenu:3[gtk]
		x11-libs/libido:3
		)
	ruby? ( dev-lang/ruby )
	mono? ( dev-lang/mono )
	zeitgeist? ( dev-libs/libzeitgeist )
	mail? ( net-libs/libetpan )
	impulse? ( media-sound/pulseaudio )
	upower? ( sys-power/upower )
	lm_sensors? ( sys-apps/lm_sensors )
	x11-libs/libXrandr
"

DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig
"

my_use_enable() {
	opt="$2"
	[ -z "$opt" ] && opt="$1"
	use "$1" || echo "-Denable-$opt=0"
}

src_configure() {
	local mycmakeargs=(
		$(my_use_enable indicator3 dbusmenu-support)
		$(my_use_enable indicator3 indicator-support)
		$(my_use_enable indicator3 libido-support)
		$(my_use_enable alsa alsa-mixer)
		$(my_use_enable ical ical-support)
		$(my_use_enable python python-interface)
		$(my_use_enable ruby ruby-interface)
		$(my_use_enable mono mono-interface)
		$(my_use_enable vala vala-interface)
		$(my_use_enable gmenu)
		$(my_use_enable gnome gnome-integration)
		$(my_use_enable impulse)
		$(my_use_enable kde kde-integration)
		$(my_use_enable xklavier keyboard-indicator)
		$(my_use_enable upower upower-support)
		$(my_use_enable mail)
		$(my_use_enable zeitgeist recent-events)
		$(my_use_enable exif exif-support)
		$(my_use_enable alsa sound-effects)
		$(my_use_enable alsa sound-effects)
		$(my_use_enable lm_sensors sensors-support)
		$(my_use_enable vte terminal)
		$(my_use_enable webkit weblets)
		$(my_use_enable xfce xfce-integration)
		$(my_use_enable xgamma)
	)

	cmake-utils_src_configure
}
