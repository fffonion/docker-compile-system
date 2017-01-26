#!/bin/bash
NAME=nmap
VERSION=7.40
TARBALL=https://nmap.org/dist/nmap-$VERSION.tgz
SCR=$(dirname $(readlink -f $0))

source $SCR/../lib/prep.sh

echo "FROM $baseimg
        RUN echo \"apt-get update && \
	apt-get update && \
	apt install wget libssl-dev libpcre3-dev checkinstall -y --force-yes --upgrade && \
	/script/make_$NAME.sh $VERSION\" > /build.sh && \
	chmod +x /build.sh
" | docker build -t $image_name -


source $SCR/../lib/make.sh
source $SCR/../lib/upload.sh
