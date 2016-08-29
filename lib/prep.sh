#!/bin/bash
if [[ "$1" -eq "64" ]]; then
	arch=x64
	image=ubuntu:xenial
	docker_opts=
else
	arch=x86
	image=i386/ubuntu
	docker_opts="--security-opt seccomp:unconfined"
fi

baseimg=buildbase-$arch
builddir=/home/build

echo "FROM $image
	RUN echo 'deb http://ppa.launchpad.net/ondrej/php/ubuntu xenial main' >> /etc/apt/sources.list && \
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C && \
	apt-get update && \
  apt install wget libssl-dev zlib1g-dev checkinstall -y --force-yes && \
	apt autoclean && apt clean all \
" | docker build -t $baseimg -

image_name=build-$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 16 | head -n 1)

pushd $builddir/$arch
sudo rm -rf $NAME-*

wget $TARBALL -O $NAME-$VERSION.tar.gz
tar zxvf $NAME-$VERSION.tar.gz
