# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit vdr-plugin-2 git-2 eutils

EGIT_REPO_URI="git://github.com/FernetMenta/vdr-plugin-vnsiserver.git"
EGIT_MASTER="epgscan"
EGIT_SOURCEDIR="${WORKDIR}"

DESCRIPTION="VDR plugin: VNSI Streamserver Plugin (Odenkamp branch)"
HOMEPAGE="https://github.com/opdenkamp/xbmc-pvr-addons"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.7.14"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_prepare() {
	vdr-plugin-2_src_prepare

	fix_vdr_libsi_include demuxer.c
#	fix_vdr_libsi_include recplayer.c
	fix_vdr_libsi_include videoinput.c

#	epatch "${FILESDIR}"/${PN}-vdr213api.patch
}

src_install() {
	vdr-plugin-2_src_install

	insinto /etc/vdr/plugins/vnsiserver
	doins vnsiserver/allowed_hosts.conf
	diropts -gvdr -ovdr
}
