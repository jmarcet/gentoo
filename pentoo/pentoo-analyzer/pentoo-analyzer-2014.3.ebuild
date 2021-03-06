# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Pentoo analyzers meta ebuild"
HOMEPAGE="http://www.pentoo.ch"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="gnome ipv6 java gnome minipentoo ldap"

DEPEND=""
RDEPEND="${DEPEND}
	net-analyzer/dnsrecon
	net-analyzer/netcat6
	net-analyzer/scapy
	net-analyzer/snmpenum
	net-analyzer/sslyze
	net-analyzer/tcpdump
	net-analyzer/tcptraceroute
	net-analyzer/traceroute
	net-analyzer/wireshark
	gnome? (
		net-analyzer/etherape
		net-analyzer/gnome-nettool
	)

	!minipentoo? (
		ipv6? ( net-analyzer/thc-ipv6 )
		java? ( ldap? ( net-nds/jxplorer ) )
		x86? ( net-analyzer/angst )
		!arm? ( net-analyzer/xplico )
		net-analyzer/aimsniff
		net-analyzer/arpwatch
		net-analyzer/chaosreader
		net-analyzer/cloudshark
		net-analyzer/dnsa
		net-analyzer/dnsenum
		net-analyzer/dnstracer
		net-analyzer/ftester
		net-analyzer/mbrowse
		net-analyzer/mtr
		net-analyzer/netdiscover
		net-analyzer/ngrep
		net-analyzer/ntop
		net-analyzer/sniffit
		net-analyzer/snort
		net-analyzer/tcpreplay
		net-analyzer/thcrut
		net-misc/socat
	)"

#	net-nds/lat depends on mono
#	net-analyzer/driftnet
