#!/bin/bash
NAME=openresty
VERSION=1.11.2.1
TARBALL=https://openresty.org/download/openresty-$VERSION.tar.gz
SCR=$(dirname $(readlink -f $0))

if [[ ! -z $2 ]]; then
    extra_name="-$2"
fi

source _prep.sh

echo "BUILD: arch=$arch extra_name=$extra_name"

echo "FROM $baseimg
        RUN echo \"apt-get update && \
	apt-get update && \
	apt-get upgrade -y --force-yes && \
	apt install wget libgd-dev libxslt-dev libpcre3-dev libxml2-dev libzip-dev libssl-dev libexpat-dev libgeoip-dev checkinstall -y --force-yes --upgrade && \
	/script/make_$NAME.sh $VERSION $extra_name\" > /build.sh && \
	chmod +x /build.sh
" | docker build -t $image_name -

source $SCR/../lib/make.sh
source $SCR/../lib/upload.sh

# make new common-file
TARG=/tmp/openresty-common_$VERSION-1_all.deb
cp $SCR/../receipts/openresty/openresty-common_BASE.deb $TARG
W=$(mktemp -d)
cd $W
ar p $TARG control.tar.gz | tar -xz
sed -i -E "s/Version:.+/Version: $VERSION-1/" control
tar czf control.tar.gz *[!z]
ar r $TARG control.tar.gz
echo Upload $(basename $TARG)
## curl upload
rm -rf $W $TARG
