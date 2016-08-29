#!/bin/bash
cd shadowsocks-libev-*
./configure --disable-documentation
make -j4
make install

VERSION=$1
echo > description-pak
checkinstall << EOF
n
1
Shadowsocks Libev
2
shadowsocks-libev
3
$VERSION
4
1
6
proxy
10
libssl1.0.2
11
ss-local,ss-server,ss-tunnel,ss-manager,ss-redir,shadowsocks-libev
EOF

