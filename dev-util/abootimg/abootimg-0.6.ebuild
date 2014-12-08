# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
EGIT_REPO_URI="git://gitorious.org/ac100/abootimg.git"
EGIT_COMMIT="v$PV"
DESCRIPTION="Manipulate boot images for the Android bootloader"
HOMEPAGE="http://android.git.kernel.org/?p=platform/system/core.git;a=summary"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 arm"
IUSE=""
DEPEND="sys-devel/gcc"

inherit git-2

src_compile () {
    make || die 'make failed.'
}

src_install() {
    dobin abootimg
    dodoc Changelog README
}
