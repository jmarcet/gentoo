# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils flag-o-matic
append-flags "-fPIC"

DESCRIPTION="Phil Zimmermann's SDK for ZRTP"
HOMEPAGE="https://github.com/traviscross/libzrtp"
SRC_URI="ftp://foo.example.org/${P}.tar.gz"

LICENSE="AGPLv3 MPLv1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="fetch"
S=${WORKDIR}/${P}/projects/gnu

src_prepare() {
	cd "${WORKDIR}/${P}"
	epatch "${FILESDIR}"/zrtp_bnlib_pic.diff || die
	epatch "${FILESDIR}"/makefile_destdirfix.patch || die
}

src_install() {
	dolib "${S}"/build/libzrtp.a
	cd ../../
	dolib third_party/bnlib/libbn.a
	insinto /usr/include/libzrtp
	doins include/* third_party/bgaes/*.h third_party/bnlib/*.h
	dodoc AUTHORS ChangeLog README
}
