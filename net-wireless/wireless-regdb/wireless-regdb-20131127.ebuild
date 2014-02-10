# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wireless-regdb/wireless-regdb-20131127.ebuild,v 1.1 2013/11/27 21:59:13 zerochaos Exp $

EAPI=5

inherit multilib

MY_P="wireless-regdb-${PV:0:4}.${PV:4:2}.${PV:6:2}"
DESCRIPTION="Binary regulatory database for CRDA"
HOMEPAGE="http://wireless.kernel.org/en/developers/Regulatory"
SRC_URI="https://www.kernel.org/pub/software/network/${PN}/${MY_P}.tar.xz"
LICENSE="ISC"
SLOT="0"

inherit eutils

KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
DEPEND="dev-libs/openssl
	dev-lang/python
	dev-python/m2crypto"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/extra-monitor.patch
}

src_compile() {
	emake install-distro-key || die "make install-distro-key failed"
	emake || die "emake failed"
}

src_install() {
	insinto /usr/$(get_libdir)/crda/
	doins regulatory.bin
	doins *.key.pub.pem

	doman regulatory.bin.5
	dodoc README db.txt
}
