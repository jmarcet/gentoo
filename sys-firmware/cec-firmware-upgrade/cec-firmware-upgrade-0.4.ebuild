# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit eutils unpacker

DESCRIPTION="Firmware upgrade for the Pulse-Eight USB HDMI-CEC Adaptor"
HOMEPAGE="http://packages.pulse-eight.net/ubuntu/pool/stable/dists/"
MY_PV=`echo ${PVR} | /bin/sed -e 's:^\([0-9]\+\.\).\+r:\1:'`
SRC_URI="x86? ( http://packages.pulse-eight.net/ubuntu/pool/stable/dists/raring/cec-firmware-upgrade_${MY_PV}_i386.deb )
		 amd64? ( http://packages.pulse-eight.net/ubuntu/pool/stable/dists/raring/cec-firmware-upgrade_${MY_PV}_amd64.deb )"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/deb2targz
	!<sys-apps/portage-2.1.10.41"
RDEPEND="${DEPEND}
	virtual/libusb
	virtual/udev"

S=${WORKDIR}

src_setup() {
	einfo PV = $PV
	einfo MY_PV = $MY_PV
	die
}

src_unpack() {
	unpack_deb ${A}
}

#src_compile() {
#}

src_install() {
	insinto /usr/bin
	dobin usr/bin/cec-firmware-upgrade
	dodoc usr/share/doc/cec-firmware-upgrade/{ChangeLog,copyright}
}
