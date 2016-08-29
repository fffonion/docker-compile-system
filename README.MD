Docker Compile System
===================

This project is a bunch of scripts that are used to simplify the process of building Debian package.

Some ideas are from [OpenEmbedded](http://www.openembedded.org/wiki/Main_Page)

## How to use

By default this project is targeting Ubuntu 16.04 (Xenial). If you wish to compile packages for older platform, replace `xenial` in `./build-ubuntu32.sh` and `lib/prep.sh` to `trusty` (for 14.04) or `precise` (for 12.04).

### Prepare

- First you'll need docker to be installed on your Linux distribution.

- If it's your first time of using this script, run `sudo ./build-ubuntu32.sh` to build a 32bit Ubuntu 16.04 docker image. This script is modified from a gist but I can't find the original link now. Send a message to me if you know where it comes from so I can put it into credit.

- Create **/home/build/x86** and **/home/build/x64**

### Define a package

A package is a shell script stored under `packages/` directory. It defines what package we should build, and all the files we need to prepare before invoking `./configure` or `make`

Example:

```bash
#!/bin/bash
NAME=aria2
VERSION=1.26.1
TARBALL=https://github.com/aria2/aria2/releases/download/release-$VERSION/aria2-$VERSION.tar.gz
SCR=$(dirname $(readlink -f $0))

source $SCR/../lib/prep.sh

echo "FROM $baseimg
	RUN echo \"apt-get update && \
	apt install wget libssl-dev libgnutls-dev libc-ares-dev checkinstall -y --force-yes --upgrade && \
	/script/make_$NAME.sh $VERSION\" > /build.sh && \
	chmod +x /build.sh
" | docker build -t $image_name -


source $SCR/../lib/make.sh
source $SCR/../lib/upload.sh
```

You need to change `NAME`, `VERSION` and `TARBALL`. You may want to change docker `RUN` commands to install necessary header files and other tools.

### Define a receipt

A receipt is a shell script stored under `receipts` directory and contains the information about how to configure, compile and build the package. It should be named with "make_NAME.sh" where **NAME** is the package name we are building.

Example:

```bash
#!/bin/bash
cd aria2-*
./configure --without-libxml2 --without-gnutls --with-openssl --prefix=/usr
make -j4
make install

VERSION=$1
echo "High speed download utility
  Aria2 is a command line download client with resuming and segmented
  downloading. Supported protocols are HTTP/HTTPS/FTP/BitTorrent and it also
  supports Metalink." > description-pak
checkinstall << EOF
n
2
aria2
3
$VERSION
4
1
6
net
10
libssl1.0.2,libc-ares2
11
aria2c, aria2
EOF
```

### Build

Run `./packages/NAME.sh` or `./packages/NAME.sh 32` to build a 32bit package.

Run `./packages/NAME.sh 64` to build a 64bit package.

After that, a **.deb** file will be generated under `/home/build/ARCH/NAME-VERSION/`. For example, if you run `./packages/aria2.sh 64` as in the example above, the **.deb** file will be generated under `/home/build/x64/aria2-1.26.1`.

## TODO

- Replace **checkinstall** with standard debian packaging tools.

## See also

- Docker
- OpenEmbedded
