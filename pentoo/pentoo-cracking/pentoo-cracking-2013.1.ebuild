# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
KEYWORDS=""
DESCRIPTION="Pentoo cracking meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL"

IUSE_VIDEO_CARDS="video_cards_fglrx video_cards_nvidia"
IUSE="${IUSE_VIDEO_CARDS} livecd-stage1 cuda opencl"

DEPEND=""

RDEPEND="${DEPEND}
	!livecd-stage1? (
		!arm? ( app-crypt/hashcat-gui )
		video_cards_nvidia? ( opencl? ( net-wireless/pyrit )
					cuda? ( net-wireless/pyrit ) ) )
	app-crypt/SIPcrack
	!arm? ( app-crypt/chntpw )
	app-crypt/johntheripper
	app-crypt/ophcrack
	app-dicts/raft-wordlists
	app-text/cewl
	net-analyzer/hydra
	net-analyzer/medusa
	net-analyzer/ncrack
	net-analyzer/thc-pptp-bruter
	net-misc/rdesktop-brute"

#removed from stage2? because it doesn't build for me
#	app-crypt/cuda-rarcrypt
#	net-analyzer/authforce
#	app-crypt/md5bf

#stupid build system, doesn't work on hardened
#		app-crypt/hashkill
