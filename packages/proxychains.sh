#!/bin/bash
NAME=proxychains-ng
VERSION=4.11
TARBALL=https://github.com/rofl0r/proxychains-ng/archive/v$VERSION.tar.gz
SCR=$(dirname $(readlink -f $0))

source $SCR/../lib/prep.sh

echo "FROM $baseimg
        RUN echo \"apt-get update && \
	apt install wget checkinstall build-essential -y --force-yes --upgrade && \ 
	/script/make_$NAME.sh $VERSION\" > /build.sh && \
	chmod +x /build.sh
" | docker build -t $image_name -


source $SCR/../lib/make.sh
source $SCR/../lib/upload.sh
