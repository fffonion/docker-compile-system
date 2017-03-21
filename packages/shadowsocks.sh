#!/bin/bash
NAME=shadowsocks-libev
VERSION=3.0.4
GIT="https://github.com/shadowsocks/shadowsocks-libev.git"
GIT_REV="v${VERSION}"
SCR=$(dirname $(readlink -f $0))

source $SCR/../lib/prep.sh

echo "FROM $baseimg
        RUN echo \"apt-get update && \
            apt install wget libssl-dev libpcre3-dev checkinstall libsodium-dev autoconf autotools-dev libudns-dev libev-dev pkg-config gnulib --no-install-recommends -y --force-yes --upgrade && \
	/script/make_$NAME.sh $VERSION\" > /build.sh && \
	chmod +x /build.sh
" | docker build -t $image_name -


source $SCR/../lib/make.sh
source $SCR/../lib/upload.sh
