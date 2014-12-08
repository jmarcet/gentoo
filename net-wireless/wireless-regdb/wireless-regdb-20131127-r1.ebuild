# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wireless-regdb/wireless-regdb-20131127-r1.ebuild,v 1.1 2014/02/12 19:31:44 vapier Exp $

EAPI=5

inherit eutils multilib

MY_P="wireless-regdb-${PV:0:4}.${PV:4:2}.${PV:6:2}"
DESCRIPTION="Binary regulatory database for CRDA"
HOMEPAGE="http://wireless.kernel.org/en/developers/Regulatory"
SRC_URI="https://www.kernel.org/pub/software/network/${PN}/${MY_P}.tar.xz"

LICENSE="ISC"
SLOT="0"
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
	# This file is not ABI-specific, and crda itself always hardcodes
	# this path.  So install into a common location for all ABIs to use.
	insinto /usr/lib/crda
	doins regulatory.bin

	doins *.key.pub.pem

	doman regulatory.bin.5
	dodoc README db.txt
}
