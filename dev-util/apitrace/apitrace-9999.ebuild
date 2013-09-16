# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/apitrace/apitrace-3.0-r1.ebuild,v 1.4 2013/03/02 20:19:29 hwoarang Exp $

EAPI="5"
PYTHON_DEPEND="2:2.6"

inherit cmake-multilib eutils python git-2

DESCRIPTION="A tool for tracing, analyzing, and debugging graphics APIs"
HOMEPAGE="https://github.com/apitrace/apitrace"
# SRC_URI="https://github.com/${PN}/${PN}/tarball/${PV} -> ${P}.tar.gz"
EGIT_REPO_URI="git://github.com/apitrace/apitrace.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="android egl qt4"

RDEPEND="sys-apps/less
	media-libs/mesa[egl?]
	egl? ( || (
		>=media-libs/mesa-8.0[gles1,gles2]
		<media-libs/mesa-8.0[gles]
	) )
	x11-libs/libX11
	abi_x86_32? ( app-emulation/emul-linux-x86-baselibs )
	qt4? (
		>=dev-qt/qtcore-4.7:4
		>=dev-qt/qtgui-4.7:4
		>=dev-qt/qtwebkit-4.7:4
		>=dev-libs/qjson-0.8
	)
	android? ( dev-util/android-ndk )"
	# app-arch/snappy
	# media-libs/libpng
	# sys-libs/zlib
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-mine.patch
)
	# "${FILESDIR}"/${P}-system-libs.patch

ANDROID_VARIANTS="android-x86 android-armeabi-v7a"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	# sed -i 's/\(add_subdirectory (retrace)\)/if (ENABLE_CLI OR ENABLE_GUI)\n\t\1\nendif()/' "${S}/CMakeLists.txt" || die

	# base_src_prepare
	cmake-utils_src_prepare

	# rm -r "${S}/thirdparty/"{getopt,less,less.patch,libpng,qjson,snappy} || die
	# Workaround NULL DT_RPATH issues
	# sed -i -e "s/install (TARGETS/#\0/" gui/CMakeLists.txt || die
}

my_android_foreach_variant() {
	local variants="${MULTIBUILD_VARIANTS}"
	local MULTIBUILD_VARIANTS=( $ANDROID_VARIANTS )
	multibuild_foreach_variant ${@}
	MULTIBUILD_VARIANTS="${variants}"
}

my_src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_enable egl EGL)
		-DLIB_INSTALL_DIR:string="$(get_libdir)/${PN}"
		-DLIB_ARCH_INSTALL_DIR:string="$(get_libdir)/${PN}"
		-DDOC_INSTALL_DIR:string="share/doc/${P}"
	)
	if [ "${ABI}" = "${DEFAULT_ABI}" ]; then
		mycmakeargs+=(
			$(cmake-utils_use_enable qt4 GUI)
			-DENABLE_CLI=ON
			)
	else
		mycmakeargs+=(
			-DENABLE_GUI=OFF
			-DENABLE_CLI=OFF
			)
			# -DBUILD_LIB_ONLY=ON
	fi

	cmake-utils_src_configure
}

my_android_src_configure() {
	mycmakeargs=(
		-DCMAKE_TOOLCHAIN_FILE=cmake/toolchain/android.toolchain.cmake
		-DANDROID_NDK=/opt/android-ndk
	)
	case "${MULTIBUILD_VARIANT}" in
		android-x86)
			mycmakeargs+=(
				-DANDROID_ABI=x86
				-ANDROID_TOOLCHAIN_NAME=x86-clang3.2
				)
			;;
		android-armeabi-v7a)
			mycmakeargs+=(
				-DANDROID_ABI=armeabi-v7a
				-ANDROID_TOOLCHAIN_NAME=arm-linux-androideabi-clang3.2
				)
			;;
	esac

	mkdir -p "${BUILD_DIR}" || die
	cd "${BUILD_DIR}" || die
	echo cmake ${mycmakeargs[@]} "${S}"
	cmake ${mycmakeargs[@]} "${S}" || die
}

src_configure() {
	# Don't do it parallelly to avoid variable conflicts!
	multilib_foreach_abi my_src_configure

	use android && my_android_foreach_variant my_android_src_configure
}

src_compile() {
	cmake-multilib_src_compile
	use android && my_android_foreach_variant cmake-utils_src_compile
}

src_install() {
	cmake-multilib_src_install

	# dobin "${CMAKE_BUILD_DIR}"/{glretrace,apitrace}
	# use qt4 && dobin "${CMAKE_BUILD_DIR}"/qapitrace

	# for ABI in $(get_install_abis) ; do
	# 	CMAKE_BUILD_DIR="${WORKDIR}/${P}_build-${ABI}"
	# 	exeinto /usr/$(get_libdir)/${PN}/wrappers
	# 	doexe "${CMAKE_BUILD_DIR}"/wrappers/*.so
	# 	dosym glxtrace.so /usr/$(get_libdir)/${PN}/wrappers/libGL.so
	# 	dosym glxtrace.so /usr/$(get_libdir)/${PN}/wrappers/libGL.so.1
	# 	dosym glxtrace.so /usr/$(get_libdir)/${PN}/wrappers/libGL.so.1.2
	# done

	# dodoc {BUGS,DEVELOPMENT,NEWS,README,TODO}.markdown

	# exeinto /usr/$(get_libdir)/${PN}/scripts
	# doexe $(find scripts -type f -executable)
}
