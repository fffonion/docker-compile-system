#!/bin/bash
NAME=aria2
VERSION=1.31.0
TARBALL=https://github.com/aria2/aria2/releases/download/release-$VERSION/aria2-$VERSION.tar.gz
SCR=$(dirname $(readlink -f $0))

source $SCR/../lib/prep.sh

echo "FROM $baseimg
	RUN echo \"apt-get update && \
	apt install wget libssl-dev libgnutls-dev libc-ares-dev checkinstall -y --force-yes --upgrade && \
	/script/make_$NAME.sh $VERSION\" > /build.sh && \
	chmod +x /build.sh
" | docker build -t $image_name -


source $SCR/../lib/make.sh
source $SCR/../lib/upload.sh
