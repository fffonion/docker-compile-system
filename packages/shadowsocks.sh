#!/bin/bash
NAME=shadowsocks-libev
VERSION=2.4.8
TARBALL=https://github.com/shadowsocks/shadowsocks-libev/archive/v$VERSION.tar.gz
SCR=$(dirname $(readlink -f $0))

source $SCR/../lib/prep.sh

echo "FROM $baseimg
        RUN echo \"apt-get update && \
	apt install wget libssl-dev checkinstall -y --force-yes --upgrade && \
	/script/make_$NAME.sh $VERSION\" > /build.sh && \
	chmod +x /build.sh
" | docker build -t $image_name -


source $SCR/../lib/make.sh
source $SCR/../lib/upload.sh
