#!/bin/bash
cd proxychains-ng-*
./configure --prefix=/usr
make -j4
make install

VERSION=$1
echo > description-pak
checkinstall << EOF
n
1
proxychains ng (new generation) - a preloader which hooks calls to sockets in dynamically linked programs and redirects it through one or more socks/http proxies.
2
proxychains
3
$VERSION
4
1
6
proxy
11
proxychains-ng, proxychains, libproxychains4
13
proxychains
EOF

