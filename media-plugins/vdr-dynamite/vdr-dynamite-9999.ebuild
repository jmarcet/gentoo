# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit vdr-plugin-2 git-2

EGIT_REPO_URI="git://projects.vdr-developer.org/vdr-plugin-dynamite.git"

DESCRIPTION="VDR plugin: Dynamically attach & detach devices while vdr is running"
HOMEPAGE="http://projects.vdr-developer.org/projects/plg-dynamite"
SRC_URI=""
KEYWORDS="~x86 ~amd64"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=media-video/vdr-1.7[dynamite]"
RDEPEND="${DEPEND}"

src_prepare()
{
	vdr-plugin-2_src_prepare
	grep -v Make.global "${S}"/Makefile > "${S}"/Makefile-new
	mv -f "${S}"/Makefile-new "${S}"/Makefile
}
