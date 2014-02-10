# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
inherit multilib webapp eutils

WEBAPP_MANUAL_SLOT="yes"

DESCRIPTION="Extract data from TCP/IP traffic"
HOMEPAGE="http://www.xplico.org"
SRC_URI="mirror://sourceforge/$PN/$P.tgz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="+geoip"
SLOT="1.0.0"

DEPEND="net-libs/libpcap"
RDEPEND="virtual/mysql
		media-sound/sox
		media-sound/lame
		dev-lang/php
		virtual/httpd-cgi
		dev-db/sqlite:3
		net-libs/libndpi
		geoip? ( dev-libs/geoip ) "
#		cups? ( app-text/ghostscript-gpl ) "
#videosnarf

src_prepare() {
	epatch "${FILESDIR}"/"${P}"-libndpi.patch
	epatch "${FILESDIR}"/"${P}"-dont-strip.patch
	epatch "${FILESDIR}"/"${P}"-sock.patch

	# fix CFLAGS
	sed -i "s|-g -ggdb -O0|$CFLAGS|g" Makefile
	sed -i "s|-g -ggdb|$CFLAGS|g" system/dema/Makefile
	if use geoip; then
		sed -i -e "s|GEOIP_LIB =.*|GEOIP_LIB = /usr/$(get_libdir)/libGeoIP.a|g" Makefile
		sed -i "s|GeoLiteCity.dat|/usr/share/GeoIP/GeoIP.dat|" common/geoiploc.c
		sed -i "s|-lpthread|-lpthread -lGeoIP|g" manipulators/www/Makefile\
		manipulators/mfbc/Makefile manipulators/mwmail/Makefile\
		manipulators/mfile/Makefile
	fi
}

src_compile() {
	emake -j1
}

src_install() {
	webapp_src_preinst
#	mv xi "${D}"/${MY_HTDOCSDIR}/xplico
	DESTDIR="${D}" emake -j1 install
	webapp_src_install
}
