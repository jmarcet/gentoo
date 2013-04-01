# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
PYTHON_DEPEND="2:2.7"

inherit eutils git-2 python

DESCRIPTION="Automatic music downloader for SABnzbd"
HOMEPAGE="https://github.com/rembo10/headphones#readme"
SRC_URI=""
EGIT_REPO_URI="https://github.com/rembo10/headphones.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	>=dev-python/cherrypy-3.2.2
	dev-python/cheetah
	net-nntp/sabnzbd"

DOCS=( "COPYING.txt" "README.md" )

src_install() {
	# Init script
	newconfd "${FILESDIR}/${PN}.conf" "${PN}"
	newinitd "${FILESDIR}/${PN}.init" "${PN}"

	# Install
	insinto /usr/lib/${PN}

	for dir in bs4 data headphones html5lib lib mako ; do
		doins -r ${dir} || die "failed to install ${dir}"
	done
	doins Headphones.py || die "failed to install Headphones.py"

	# Create run, log & cache directories
	for runtime_dir in run log cache ; do
		keepdir /var/${runtime_dir}/${PN}
		fowners -R ftp:ftp /var/${runtime_dir}/${PN}
		fperms -R 775 /var/${runtime_dir}/${PN}
	done

	# Install bare-bone config file (NOTE: AFAICT, sickbeard will *always* look for it in its basedir...)
	insinto /usr/lib/${PN}
	doins "${FILESDIR}"/config.ini
	fowners root:sabnzbd /usr/lib/${PN}/config.ini
	fperms 660 /usr/lib/${PN}/config.ini

	# Fix perms
	fowners -R root:sabnzbd /usr/lib/${PN}
	fperms -R 775 /usr/lib/${PN}
}
