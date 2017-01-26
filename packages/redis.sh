#!/bin/bash
NAME=redis
VERSION=3.2.6
TARBALL=http://download.redis.io/releases/redis-$VERSION.tar.gz
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
