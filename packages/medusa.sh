#!/bin/bash
NAME=medusa
VERSION=2.2
TARBALL=http://www.foofus.net/jmk/tools/medusa-$VERSION.tar.gz
SCR=$(dirname $(readlink -f $0))

source $SCR/../lib/prep.sh

echo "FROM $baseimg
	RUN echo \"apt-get update && \
	apt install wget checkinstall libssl-dev libssh2-1-dev -y --force-yes --upgrade && \ 
	/script/make_$NAME.sh $VERSION\" > /build.sh && \
	chmod +x /build.sh
" | docker build -t $image_name -


source $SCR/../lib/make.sh
source $SCR/../lib/upload.sh
