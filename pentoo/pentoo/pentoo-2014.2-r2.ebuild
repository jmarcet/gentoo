# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

KEYWORDS="amd64 arm x86"
DESCRIPTION="Pentoo meta ebuild to install all apps"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL-3"
IUSE="gtk livecd livecd-stage1 +analyzer bindist +bluetooth cdr +cracking +database +enlightenment +exploit +footprint +forensics +forging +fuzzers -kde mate +misc +mitm +mobile +proxies pulseaudio +qemu pentoo +radio +rce +scanner +voip +wireless +xfce X"

S="${WORKDIR}"

DEPEND="!pentoo/pentoo-etc-portage"

# Things needed for a running system and not for livecd
PDEPEND="!livecd? ( !pentoo/pentoo-livecd
		!app-misc/livecd-tools )"

PDEPEND="${PDEPEND}
	analyzer? ( pentoo/pentoo-analyzer )
	bluetooth? ( pentoo/pentoo-bluetooth )
	cracking? ( pentoo/pentoo-cracking )
	database? ( pentoo/pentoo-database )
	exploit? ( pentoo/pentoo-exploit )
	footprint? ( pentoo/pentoo-footprint )
	forensics? ( pentoo/pentoo-forensics )
	forging? ( pentoo/pentoo-forging )
	fuzzers? ( pentoo/pentoo-fuzzers )
	livecd? ( pentoo/pentoo-livecd )
	misc? ( pentoo/pentoo-misc )
	mitm? ( pentoo/pentoo-mitm )
	mobile? ( pentoo/pentoo-mobile )
	pentoo? ( pentoo/pentoo-system )
	proxies? ( pentoo/pentoo-proxies )
	radio? ( pentoo/pentoo-radio )
	rce? ( pentoo/pentoo-rce )
	scanner? ( pentoo/pentoo-scanner )
	voip? ( pentoo/pentoo-voip )
	wireless? ( pentoo/pentoo-wireless )"

# Window makers
PDEPEND="${PDEPEND}
	enlightenment? ( x11-wm/enlightenment:0.17
		x11-terms/terminology
		gnome-base/gnome-menus
		=x11-plugins/extramenu-9999
	)
	kde? ( kde-base/kdebase-meta
		kde-base/kate
		kde-base/kcalc
		kde-base/kgpg
		kde-base/kmix
		kde-base/knotify
		kde-base/ksnapshot
		kde-misc/plasma-nm
		net-misc/smb4k )
	mate? ( mate-base/mate
		x11-misc/mate-notification-daemon )
	xfce? ( xfce-base/xfce4-meta
		xfce-extra/xfce4-notifyd
		cdr? ( app-cdr/xfburn )
		app-editors/leafpad
		media-gfx/geeqie
		x11-terms/xfce4-terminal
		x11-themes/tango-icon-theme
		xfce-base/thunar
		xfce-extra/thunar-archive-plugin
		xfce-extra/thunar-vcs-plugin
		xfce-extra/thunar-volman
		xfce-extra/tumbler
		xfce-extra/xfce4-power-manager
		xfce-extra/xfce4-screenshooter
		pulseaudio? ( xfce-extra/xfce4-volumed-pulse )
		xfce-extra/xfce4-xkb-plugin
	)"

#X windows stuff
PDEPEND="${PDEPEND}
	X? (
		!livecd-stage1? ( || ( x11-base/xorg-server dev-libs/wayland ) )
		x11-apps/setxkbmap
		x11-apps/xbacklight
		x11-apps/xdm
		x11-apps/xinit
		x11-apps/xinput
		x11-apps/xrandr )
	gtk? (
		x11-misc/arandr
		x11-libs/gksu
		x11-misc/slim
		x11-proto/dri2proto
		x11-terms/rxvt-unicode
		x11-themes/gtk-theme-switch
		app-arch/file-roller
		app-text/evince
		pulseaudio? ( media-sound/pavucontrol )
		net-misc/rdesktop
		net-misc/tightvnc
		!arm? ( || ( www-client/chromium www-client/google-chrome ) )
		|| ( www-client/firefox www-client/firefox-bin )
	)"

# Basic systems
PDEPEND="${PDEPEND}
	qemu? ( app-emulation/virt-manager
		!livecd-stage1? ( sys-apps/usermode-utilities ) )
	app-admin/genmenu
"

src_install() {
	##here is where we merge in things from root_overlay which make sense
	exeinto /root
	newexe "${FILESDIR}"/b43-commercial-2012.1 b43-commercial
	insinto /root
	newins "${FILESDIR}"/motd-${PV} motd

	#/usr/bin
	use enlightenment && newbin "${FILESDIR}"/dokeybindings-2012.1 dokeybindings

	#/usr/sbin
	newsbin "${FILESDIR}"/flushchanges-${PV} flushchanges
	newsbin "${FILESDIR}"/makemo-${PV} makemo

	#/etc
	insinto /etc
	echo "Pentoo Release ${PV}" > pentoo-release
	doins pentoo-release

	dodir /etc/env.d
	use kde && echo 'XSESSION="KDE-4"' > "${ED}"/etc/env.d/90xsession
	use xfce && echo 'XSESSION="Xfce4"' > "${ED}"/etc/env.d/90xsession

	#/etc/portage/postsync.d
	exeinto /etc/portage/postsync.d
	doexe "${FILESDIR}"/layman-sync

	dodir /root
	use xfce && echo "exec startxfce4 --with-ck-launch" > "${ED}"/root/.xinitrc

	insinto /usr/share/${PN}/wallpaper
	doins "${FILESDIR}"/domo-roolz.jpg
	doins "${FILESDIR}"/domo-roolz-shmoocon2014.png
	doins "${FILESDIR}"/tux-winfly-killah.1600x1200.jpg
	doins "${FILESDIR}"/xfce4-desktop.xml
	dosym /usr/share/${PN}/wallpaper/domo-roolz.jpg /usr/share/backgrounds/xfce/domo-roolz.jpg
	dosym /usr/share/${PN}/wallpaper/domo-roolz-shmoocon2014.png /usr/share/backgrounds/xfce/domo-roolz-shmoocon2014.png
	dosym /usr/share/${PN}/wallpaper/tux-winfly-killah.1600x1200.jpg /usr/share/backgrounds/xfce/tux-winfly-killah.1600x1200.jpg

	if [ ! -e "${EROOT}/etc/env.d/02locale" ]
	then
		doenvd "${FILESDIR}"/02locale
	fi

	insinto /etc/fonts
	doins "${FILESDIR}"/local.conf
}
