# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5

USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_TASK_DOC=""

# Tests depend on unpackaged factory_girl_rails
RUBY_FAKEGEM_RECIPE_TEST=""

RUBY_FAKEGEM_EXTRAINSTALL="app script spec"

inherit ruby-fakegem

DESCRIPTION="Code to define concerns in app/concerns that will automatically be included in matching classes"
HOMEPAGE="https://github.com/rapid7/metasploit-concern"
SRC_URI="https://github.com/rapid7/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

ruby_add_rdepend "
		>=dev-ruby/activerecord-3.2.10[postgres]
		dev-ruby/activesupport"
