# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

# No package file are provided so need to get the source directly from git.
EGIT_REPO_URI="git://github.com/albertz/shairport.git"
EGIT_COMMIT="master"

inherit eutils git-2

DESCRIPTION="Airtunes emulation library"
HOMEPAGE="http://mafipulation.org"

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="dev-libs/openssl
	media-libs/libao";
RDEPEND="${DEPEND}"
