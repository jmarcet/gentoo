# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7} pypy pypy2_0 )

inherit distutils-r1

MY_P="mod_${P}"

DESCRIPTION="WebSocket server and extension for Apache HTTP Server for testing"
HOMEPAGE="https://code.google.com/p/pywebsocket/"
SRC_URI="https://pywebsocket.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}/src

#python_install_all() {
#	distutils-r1_python_install_all
#	dodoc doc/{ARCHITECTURE,Changes,TODO,interface_class,walker}
#}
