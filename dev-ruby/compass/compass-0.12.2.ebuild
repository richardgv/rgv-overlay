# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Header: $

EAPI=4

USE_RUBY="ruby18 ruby19 ree18 jruby"

# RUBY_FAKEGEM_TASK_DOC=""
# RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.markdown"

RUBY_FAKEGEM_EXTRAINSTALL="examples frameworks features"

inherit ruby-fakegem

DESCRIPTION="a Sass-based Stylesheet Framework that streamlines the creation and maintainance of CSS"
HOMEPAGE="http://compass-style.org"
LICENSE="MIT"

KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

# ruby_add_bdepend "doc? ( >=dev-ruby/yard-0.5.3 >=dev-ruby/maruku-0.5.9 )"

ruby_add_rdepend ">=dev-ruby/chunky_png-1.2 >=dev-ruby/sass-3.1"

# RUBY_PATCHES=( "${FILESDIR}/${PN}-2001_frameworks_in_usr-share.patch" )
