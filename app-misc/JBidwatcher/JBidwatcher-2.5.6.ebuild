# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

JAVA_PKG_IUSE="doc"

inherit java-pkg-2 java-ant-2 eutils

DESCRIPTION="Java-based eBay bidding, sniping and tracking tool"
HOMEPAGE="http://www.jbidwatcher.com/"
SRC_URI="http://www.jbidwatcher.com/download/${P}.jar"

LICENSE="CCPL-Attribution-ShareAlike-NonCommercial-3.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=virtual/jdk-1.4"
RDEPEND=">=virtual/jre-1.4"

src_unpack() {
	einfo "Nothing to unpack"
}

src_prepare() {
	einfo "Nothing to prepare"
}

src_install() {
	java-pkg_newjar "${DISTDIR}/${A}" ${PN}.jar || die
	java-pkg_dolauncher ${PN} --jar ${PN}.jar --java_args "-Xmx1024m -XX:MaxPermSize=512m" || die
	#newicon "${FILESDIR}/jbidwatch64.jpg" "${PN}.jpg" || die "newicon failed"
	make_desktop_entry "${PN}" "${MY_PN}" "${PN}.jpg" || die
}
