# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils

MY_PN="${PN//-/_}"
DESCRIPTION="Command line programmer for Teensy microcontrollers"
HOMEPAGE="http://pjrc.com/teensy/loader_cli.html"
SRC_URI="http://pjrc.com/teensy/${MY_PN}.${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="-examples +udev"

DEPEND="
	|| ( dev-libs/libusb dev-libs/libusbx )"
RDEPEND="$DEPEND"

S="${WORKDIR}/${MY_PN}"

pkg_setup() {
	use udev && enewgroup teensy
	#groupdel in pkg_postrm()?
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Don't strip the binary (remove -s flag)
	sed -i 's/$(CFLAGS) -s /$(CFLAGS) /' Makefile
}

src_compile() {
	emake OS=LINUX "CFLAGS=${CFLAGS}" "LDFLAGS=${LDFLAGS}"
}

src_install() {
	dobin teensy_loader_cli
	if use examples; then
		dodoc *.hex
	fi
	if use udev; then
		insinto /lib/udev/rules.d
		doins "${FILESDIR}/49-teensy.rules"
	fi
}

pkg_postinst() {
	if use udev; then
		elog "To be able to use Teensy devices, you need to be a"
		elog "member of the group 'teensy' which has just been added"
		elog "to your system. You can add your user to the group by"
		elog "running the following command as root:"
		elog
		elog "	usermod -a -G teensy youruser"
		elog
		elog "Please be aware that you need to either re-login or run"
		elog
		elog "	newgrp - teensy"
		elog
		elog "for the group membership to take effect."
	fi
}
