#!/bin/bash
cd v8*
make -j8 release
make install

VERSION=$1
echo > description-pak
checkinstall << EOF
n
1
aria2
2
aria2
3
$VERSION
4
$SUBVERSION
6
downloader
10
libssl1.0.2,libc-ares2
11
aria2c, aria2
EOF

