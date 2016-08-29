#!/bin/bash
NAME=thc-hydra
VERSION=8.2
TARBALL=https://github.com/vanhauser-thc/thc-hydra/archive/v$VERSION.tar.gz
SCR=$(dirname $(readlink -f $0))

source $SCR/../lib/prep.sh

echo "FROM $baseimg
	RUN echo \"echo 'deb http://repo.mysql.com/apt/ubuntu/ xenial mysql-5.7' >> /etc/apt/sources.list && \
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8C718D3B5072E1F5 && \
	apt-get update && \
	apt install wget checkinstall libssl-dev zlib1g-dev libidn11-dev libncurses5-dev libmysqlclient-dev libssh-dev libpcre3-dev -y --force-yes --upgrade && \
	/script/make_$NAME.sh $VERSION\" > /build.sh && \
	chmod +x /build.sh
" | docker build -t $image_name -


source $SCR/../lib/make.sh
source $SCR/../lib/upload.sh
