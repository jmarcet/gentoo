# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
PYTHON_DEPEND="2:2.7"

inherit eutils git-2 python

DESCRIPTION="TV shows PVR & episode guide"
HOMEPAGE="http://code.google.com/p/sickbeard/"
SRC_URI=""
#EGIT_REPO_URI="https://github.com/jmarcet/Sick-Beard.git"
#EGIT_REPO_URI="https://github.com/midgetspy/Sick-Beard.git"
EGIT_REPO_URI="https://github.com/junalmeida/Sick-Beard.git"
#EGIT_MASTER="development"
EGIT_MASTER="torrent_1080_subtitles"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	>=dev-python/cherrypy-3.2.0_rc1
	dev-python/cheetah
	dev-python/urllib3
	net-nntp/sabnzbd"

DOCS=( "COPYING.txt" "readme.md" )

src_install() {
	# Init script
	newconfd "${FILESDIR}/${PN}.conf" "${PN}"
	newinitd "${FILESDIR}/${PN}.init" "${PN}"

	# Install
	insinto /usr/lib/${PN}

	for sickb_dir in autoProcessTV data lib sickbeard ; do
		doins -r ${sickb_dir} || die "failed to install ${sickb_dir}"
	done
	doins SickBeard.py || die "failed to install SickBeard.py"

	# Create run, log & cache directories
	for sickb_runtime_dir in run log cache ; do
		keepdir /var/${sickb_runtime_dir}/${PN}
		fowners -R ftp:ftp /var/${sickb_runtime_dir}/${PN}
		fperms -R 775 /var/${sickb_runtime_dir}/${PN}
	done

	# Install bare-bone config file (NOTE: AFAICT, sickbeard will *always* look for it in its basedir...)
	insinto /usr/lib/${PN}
	doins "${FILESDIR}"/config.ini
	fowners root:ftp /usr/lib/${PN}/config.ini
	fperms 660 /usr/lib/${PN}/config.ini

	# Fix perms
	fowners -R root:ftp /usr/lib/${PN}
	fperms -R 775 /usr/lib/${PN}

	for i in `grep -l -r '\<8081\>' "${D}"`; do
		sed -e 's:\<8081\>:8083:g' -i ${i}
	done
}
