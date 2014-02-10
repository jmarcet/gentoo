# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/youtube-viewer/youtube-viewer-9999.ebuild,v 1.15 2013/12/26 16:39:47 hasufell Exp $

EAPI=5

inherit perl-module git-2

DESCRIPTION="A command line utility for viewing youtube-videos in Mplayer"
HOMEPAGE="http://trizen.googlecode.com"
SRC_URI=""
EGIT_REPO_URI="git://github.com/trizen/${PN}.git"

LICENSE="|| ( Artistic GPL-1+ )"
SLOT="0"
KEYWORDS=""
IUSE="gtk"

RDEPEND="
	>=dev-lang/perl-5.16.0
	dev-perl/Data-Dump
	dev-perl/libwww-perl
	|| ( media-video/mplayer[X,network]
		media-video/mplayer2[X,network] )
	virtual/perl-File-Spec
	virtual/perl-Getopt-Long
	virtual/perl-Term-ANSIColor
	virtual/perl-Text-ParseWords
	virtual/perl-Text-Tabs+Wrap
	|| ( dev-perl/LWP-Protocol-https 
		dev-perl/libwww-perl[ssl] )
	virtual/perl-MIME-Base64
	dev-perl/Term-ReadLine-Gnu
	dev-perl/Text-CharWidth
	dev-perl/XML-Fast
	net-misc/gcap
	virtual/perl-File-Temp
	virtual/perl-Scalar-List-Utils
	virtual/perl-threads
	gtk? (
		dev-perl/File-ShareDir
		>=dev-perl/gtk2-perl-1.244.0
		virtual/freedesktop-icon-theme
		x11-libs/gdk-pixbuf:2[X,jpeg]
	)"
DEPEND="virtual/perl-Module-Build"

EGIT_SOURCEDIR="${WORKDIR}"
S=${WORKDIR}/WWW-YoutubeViewer

SRC_TEST="do"

# build system installs files on "perl Build.PL" too
# do all the work in src_install
src_configure() { :; }
src_compile() { :; }

src_install() {
	local myconf
	if use gtk ; then
		myconf="--gtk-youtube-viewer"
	fi
	perl-module_src_configure
	perl-module_src_install
}

pkg_postinst() {
	perl-module_pkg_postinst
}
