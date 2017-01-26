#!/bin/bash
NAME=php
VERSION=7.1.0
if [[ $(echo $VERSION|grep -Pi "beta|alpha|rc") ]]; then
	TARBALL=https://downloads.php.net/~krakjoe/php-$VERSION.tar.gz
else
	TARBALL=http://ca2.php.net/get/php-$VERSION.tar.gz/from/this/mirror
fi
SCR=$(dirname $(readlink -f $0))

if [[ ! -z $2 ]]; then
    extra_name="-$2"
fi

source _prep.sh

echo "BUILD: arch=$arch extra_name=$extra_name"

echo "FROM $baseimg
        RUN echo \"echo 'deb http://repo.mysql.com/apt/ubuntu/ xenial mysql-5.7' >> /etc/apt/sources.list && \
        apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8C718D3B5072E1F5 && \
	apt-get update && \
	apt-get upgrade -y --force-yes && \
	apt install wget libxml2-dev libpcre3-dev libbz2-dev libcurl4-openssl-dev  libjpeg-dev libpng12-dev libxpm-dev libfreetype6-dev libmysqlclient-dev libgd2-xpm-dev libgmp-dev libxslt1-dev libmcrypt-dev libgd-dev libxslt1.1 -y --force-yes --upgrade && \
	/script/make_$NAME.sh $VERSION $extra_name\" > /build.sh && \
	chmod +x /build.sh
" | docker build -t $image_name -

source $SCR/_make.sh
source $SCR/_upload.sh
