#!/bin/bash
NAME=opencc4php
VERSION=0.1.2
TARBALL=https://github.com/NauxLiu/opencc4php/archive/master.tar.gz
SCR=$(dirname $(readlink -f $0))

source $SCR/_prep.sh

echo "FROM $baseimg
	RUN echo \"apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 7B52C1AA2F81268E && \
        echo 'deb http://dl.yooooo.us/build/ubuntu /' >> /etc/apt/sources.list && \
        echo 'deb http://dl.yooooo.us/mirror/ubuntu /' >> /etc/apt/sources.list && \
        apt-get update && \
	apt install wget opencc php7.1-dev checkinstall -y --force-yes --upgrade && \
        ln -s /usr/lib/libopencc.so.1.0.0 /usr/lib/libopencc.so && \
	/script/make_$NAME.sh $VERSION\" > /build.sh && \
	chmod +x /build.sh
" | docker build -t $image_name -


source $SCR/_make.sh
source $SCR/_upload.sh
