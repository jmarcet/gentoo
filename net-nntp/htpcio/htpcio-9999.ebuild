# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
PYTHON_DEPEND="2:2.7"

inherit eutils python

EGIT_REPO_URI="https://github.com/styxit/HTPC-Manager.git"
SRC_URI=""

inherit git-2

DESCRIPTION="HTPC Manager. Manage your Htpc from everywhere"
HOMEPAGE="http://htpc.io/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-tv/xbmc
	net-nntp/sabnzbd
	net-nntp/couchpotato
	net-nntp/sickbeard"
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

	for dir in htpc interfaces libs modules; do
		doins -r ${dir} || die "failed to install ${dir}"
	done
	doins Htpc.py || die "failed to install CouchPotato.py"

	# Create run, log & cache directories
	keepdir /var/run/${PN}
	fowners -R sabnzbd:sabnzbd /var/run/${PN}
	fperms -R 775 /var/run/${PN}

	# Fix perms
	fowners -R root:sabnzbd /usr/lib/${PN}
	fperms -R 775 /usr/lib/${PN}
}
