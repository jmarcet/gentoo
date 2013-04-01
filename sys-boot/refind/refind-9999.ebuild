# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

EGIT_REPO_URI="https://github.com/falstaff84/rEFInd.git"

inherit eutils git-2 mount-boot

DESCRIPTION="EFI boot manager"
HOMEPAGE="http://www.rodsbooks.com/refind"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc drivers tiano"

DEPEND="tiano? ( sys-boot/edk2 ) !tiano? ( sys-boot/gnu-efi )"
RDEPEND="${DEPEND}"
unset ARCH

src_prepare(){
	use tiano && ( epatch "${FILESDIR}"/make_tiano.patch || die )
}

src_compile(){
	use tiano && ( default_src_compile || die ) || \
		( make gnuefi || die )

	if use drivers ; then
		use tiano && ( make fs || die ) || \
			( make fs_gnuefi || die )
	fi
}

src_install(){
	
	insinto ${EROOT}/usr/share/${PF}
	doins *.txt install.sh refind.conf-sample refind/refind_*.efi
	doins -r icons keys
	
	use drivers && doins -r drivers_*

	insinto ${EROOT}/usr/share/${PF}/images
	doins images/*.{bmp,odt,png}

	use doc && dodoc -r docs/*
}

pkg_postinst(){

	elog "A sample configuration file is placed into ${EROOT}/usr/share/${PF}/refind.conf-sample."
	ewarn
	ewarn "This ebuild does not install files to the ESP"
	ewarn "You need to manually copy or use the provided install.sh script"
	ewarn
	elog "You'll then need to activate rEFInd in your EFI."
	elog "This can be done with tools such as 'efibootmgr' under Linux."
	if use doc ; then
		elog "See ${EROOT}/usr/share/doc/${PF}/refind/installing.html file for details."
	fi

}
