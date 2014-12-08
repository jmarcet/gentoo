# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
inherit base

DESCRIPTION="An implementation of the GEIS (Gesture Engine Interface and Support) interface."
SRC_URI="http://launchpad.net/geis/trunk/${PV}/+download/geis-${PV}.tar.gz"
HOMEPAGE="https://launchpad.net/geis"
KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2 LGPL-3"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	x11-libs/grail"

src_prepare() {
	sed -e 's/python >= 2.7/python-2.7/g' \
		-e 's/python3 >= 3.2/python-3.3/g' \
		-e 's/python3 python3.2 python3.1 python3.0/python3 python-3.3/g' \
		-r -i "${S}"/configure || die
		#-e 's/python-3.3/python-3.4/g' \
}
