# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/x2x/x2x-1.27-r3.ebuild,v 1.9 2014/01/17 14:46:22 jer Exp $

EAPI=3
EGIT_REPO_URI="git://github.com/barak/x2x.git"
EGIT_MASTER="master"

inherit eutils toolchain-funcs git-2

DESCRIPTION="A utility to connect the Mouse and KeyBoard to another X"
HOMEPAGE="https://github.com/dottedmag/x2x"
LICENSE="x2x"
SLOT="0"
KEYWORDS="~amd64 ~arm ~mips ~ppc ~x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXtst
	x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-proto/inputproto
	app-text/rman
	x11-misc/imake
	x11-proto/xproto"

src_prepare() {
	./bootstrap.sh
}

src_compile() {
	econf || die
	emake || die
}

src_install () {
	einstall || die
}
