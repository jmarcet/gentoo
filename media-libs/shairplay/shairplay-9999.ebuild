# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

# No package file are provided so need to get the source directly from git.
EGIT_REPO_URI="https://github.com/juhovh/shairplay.git"
EGIT_COMMIT="master"

inherit eutils git-2

DESCRIPTION="Free portable AirPlay server implementation similar to ShairPort"
HOMEPAGE="https://github.com/juhovh/shairplay"

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="media-libs/libao";
RDEPEND="${DEPEND}
		net-dns/avahi[mdnsresponder-compat]"

src_prepare() {
	epatch "${FILESDIR}"/key.patch
	./autogen.sh
	cd AirTV-Qt/qtsingleapplication
	qmake
}

src_compile() {
	emake || die
	cd AirTV-Qt/qtsingleapplication
	emake || die
}

src_install() {
	einstall || die
	cd AirTV-Qt/qtsingleapplication
	einstall || die
	insinto /var/lib/${PN}
	doins "${S}"/airport.key
}
