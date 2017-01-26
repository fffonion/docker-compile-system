#!/bin/bash
NAME=opencc
VERSION=1.0.4
TARBALL=https://github.com/BYVoid/OpenCC/archive/master.tar.gz
SCR=$(dirname $(readlink -f $0))

source $SCR/_prep.sh

echo "FROM $baseimg
	RUN echo \"apt-get update && \
	apt install wget cmake doxygen python checkinstall -y --force-yes --upgrade && \
	/script/make_$NAME.sh $VERSION\" > /build.sh && \
	chmod +x /build.sh
" | docker build -t $image_name -


source $SCR/_make.sh
source $SCR/_upload.sh
