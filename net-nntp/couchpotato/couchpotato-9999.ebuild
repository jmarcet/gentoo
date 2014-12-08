# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
PYTHON_DEPEND="2:2.7"

inherit eutils python

EGIT_REPO_URI="https://github.com/RuudBurger/CouchPotatoServer.git"
EGIT_MASTER="develop"
SRC_URI=""

inherit git-2

DESCRIPTION="Automatic NZB and torrent downloader"
HOMEPAGE="https://couchpota.to/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-nntp/sabnzbd"
DEPEND="${RDEPEND}
	dev-python/lxml"

DOCS=( "README.md" "changelog.md" "todo.md" )

pkg_setup() {
        python_set_active_version 2
}

src_install() {
	# Init script
	newconfd "${FILESDIR}/${PN}.conf" "${PN}"
	newinitd "${FILESDIR}/${PN}.init" "${PN}"

	# Install
	insinto /usr/lib/${PN}

	for i in couchpotato/core/_base/_core.py couchpotato/core/_base/_core.py; do
		sed -e 's:\<5050\>:8084:g' -i ${i}
	done

	for dir in couchpotato libs ; do
		doins -r ${dir} || die "failed to install ${dir}"
	done
	doins CouchPotato.py || die "failed to install CouchPotato.py"

	# Create run, log & cache directories
	for dir in run log cache ; do
		keepdir /var/${dir}/${PN}
		fowners -R sabnzbd:sabnzbd /var/${dir}/${PN}
		fperms -R 775 /var/${dir}/${PN}
	done

	# Install bare-bone config file (NOTE: AFAICT, sickbeard will *always* look for it in its basedir...)
	insinto /usr/lib/${PN}

	# Fix perms
	fowners -R root:sabnzbd /usr/lib/${PN}
	fperms -R 775 /usr/lib/${PN}
}
