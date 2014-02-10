#!/bin/sh
VERSION=$(date +%Y%m%d)
PACKAGE="mplayer-1.2_pre${VERSION}"

git clone git://gitorious.org/vaapi/mplayer.git ${PACKAGE}

pushd ${PACKAGE} > /dev/null
	# ffmpeg is in git now so no svn external anymore
	rm -rf ffmpeg
	git clone git://source.ffmpeg.org/ffmpeg.git ffmpeg/
	../dump_ffmpeg.sh
	STORE_VERSION=$(LC_ALL=C svn info 2> /dev/null | grep Revision | cut -d' ' -f2)
	printf "$STORE_VERSION" > snapshot_version
popd > /dev/null

find "${PACKAGE}" -type d -name '.svn' -prune -print0 | xargs -0 rm -rf
find "${PACKAGE}" -type d -name '.git' -prune -print0 | xargs -0 rm -rf

tar cJf ${PACKAGE}.tar.xz ${PACKAGE}
#rm -rf ${PACKAGE}/

echo "Tarball: \"${PACKAGE}.tar.xz\""

echo "** all done **"
