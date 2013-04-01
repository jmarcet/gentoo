# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5
EGIT_REPO_URI="http://evilpiepirate.org/git/bcache-tools.git"

inherit git-2

DESCRIPTION="Userspace tools required for bcache"
HOMEPAGE="http://evilpiepirate.org/git/bcache-tools.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="sys-apps/util-linux"
RDEPEND="${DEPEND}"

src_prepare()
{
	grep -v man8 Makefile | sed -e 's:^CFLAGS:#CFLAGS:' > "${S}"/Makefile-new
	mv -f "${S}"/Makefile-new "${S}"/Makefile
}

src_install()
{
	dodir /usr/sbin
	dodir /sbin
	dodir /lib/udev/rules.d
	emake DESTDIR="${D}" install || die
	dodoc README
	doman *.8
	doinitd "${FILESDIR}"/bcache
}
