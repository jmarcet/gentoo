# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5
#EGIT_REPO_URI="git://git.marcet.info/libcec.git"
EGIT_REPO_URI="https://github.com/Pulse-Eight/libcec.git"

inherit autotools eutils linux-info git-2

DESCRIPTION="Library for communicating with the Pulse-Eight USB HDMI-CEC Adaptor"
HOMEPAGE="http://libcec.pulse-eight.com"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug static-libs"

RDEPEND="virtual/udev"
DEPEND="${RDEPEND}
	dev-libs/lockdev
	virtual/pkgconfig"

CONFIG_CHECK="~USB_ACM"

src_prepare() {
	sed -i '/^CXXFLAGS/s:-fPIC::' configure.ac || die
	sed -i '/^CXXFLAGS/s:-Werror::' configure.ac || die
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static) \
	$(use_enable debug) \
	--enable-optimisation \
	--disable-rpi \
	--disable-cubox
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.la' -delete
}
