# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/configshell/configshell-9999.ebuild,v 1.2 2012/10/19 04:56:43 patrick Exp $

EAPI=4

EGIT_REPO_URI="git://github.com/globaleaks/Tor2web-3.0"

inherit eutils distutils git-2 python

DESCRIPTION="HTTP proxy software that enables access to Tor Hidden Services"
HOMEPAGE="https://github.com/globaleaks/Tor2web-3.0/wiki"
SRC_URI=""

LICENSE="AGPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/twisted-core
	dev-python/twisted-mail
	dev-python/twisted-web"
RDEPEND="${DEPEND}"
