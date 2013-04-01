# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_REPO_URI="https://github.com/traviscross/libzrtp.git"
inherit eutils flag-o-matic git-2
append-flags "-fPIC"

DESCRIPTION="Phil Zimmermann's SDK for ZRTP"
HOMEPAGE="https://github.com/traviscross/libzrtp"

LICENSE="AGPLv3 MPLv1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_prepare() {
	./bootstrap.sh
	#epatch "${FILESDIR}"/zrtp_bnlib_pic.diff || die
	epatch "${FILESDIR}"/makefile_destdirfix-master.patch || die
}

src_install() {
	dolib libzrtp.a
	dolib third_party/bnlib/libbn.a
	insinto /usr/include/libzrtp
	doins include/* third_party/bgaes/*.h third_party/bnlib/*.h
	dodoc AUTHORS COPYING ChangeLog INSTALL README
}
