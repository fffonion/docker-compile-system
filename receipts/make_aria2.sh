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
$SUBVERSION
6
net
10
libssl1.0.2,libc-ares2
11
aria2c, aria2
EOF

