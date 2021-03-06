# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libotr/libotr-4.0.0.ebuild,v 1.2 2013/06/20 14:50:40 polynomial-c Exp $

EAPI=5

inherit eutils

DESCRIPTION="(OTR) Messaging allows you to have private conversations over instant messaging"
HOMEPAGE="http://www.cypherpunks.ca/otr/"
SRC_URI="http://www.cypherpunks.ca/otr/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND=">=dev-libs/libgcrypt-1.2
	dev-libs/libgpg-error"
DEPEND="${RDEPEND}"

DOCS=( AUTHORS ChangeLog NEWS README UPGRADING )

src_prepare() {
	epatch "${FILESDIR}"/${P}-kopete_fix.patch || die
}
