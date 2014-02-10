# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/youtube-viewer/youtube-viewer-3.0.9-r2.ebuild,v 1.1 2013/12/26 16:41:43 hasufell Exp $

EAPI=5

inherit gnome2-utils eutils perl-module vcs-snapshot

DESCRIPTION="A command line utility for viewing youtube-videos in Mplayer"
HOMEPAGE="http://trizen.googlecode.com"
SRC_URI="https://github.com/trizen/youtube-viewer/tarball/${PV} -> ${P}.tar.gz"

LICENSE="|| ( Artistic GPL-1+ )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
		!net-misc/gtk-youtube-viewer
		virtual/freedesktop-icon-theme
		x11-libs/gdk-pixbuf:2[X,jpeg]
	)"
DEPEND="virtual/perl-Module-Build"

SRC_TEST="do"

S=${WORKDIR}/${P}/WWW-YoutubeViewer

src_prepare() {
	perl-module_src_prepare
}

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

	if use gtk ; then
		domenu share/gtk-youtube-viewer.desktop
		doicon -s 256 share/gtk-youtube-viewer.png
	fi
}

pkg_preinst() {
	use gtk && gnome2_icon_savelist
	perl-module_pkg_preinst
}

pkg_postinst() {
	use gtk && gnome2_icon_cache_update
	perl-module_pkg_postinst
}

pkg_postrm() {
	use gtk && gnome2_icon_cache_update
	perl-module_pkg_postrm
}
