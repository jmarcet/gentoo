# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KEYWORDS="-*"
DESCRIPTION="Pentoo bluetooth meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL"
IUSE="gnome kde"

DEPEND=""

RDEPEND="${DEPEND}
	x86? ( net-wireless/bluemaho )
	net-wireless/bt-audit
	net-wireless/btscanner
	net-wireless/kismet-ubertooth
	net-libs/libbtbb[wireshark]
	net-wireless/ubertooth
	net-wireless/haraldscan
	gnome? ( net-wireless/gnome-bluetooth )
	kde? ( net-wireless/bluedevil )"
