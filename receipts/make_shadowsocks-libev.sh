#!/bin/bash
cd shadowsocks-libev-*
wget https://github.com/shadowsocks/libcork/archive/shadowsocks.tar.gz -O - |tar zxvf -
wget https://github.com/shadowsocks/ipset/archive/shadowsocks.tar.gz -O - |tar zxvf -
mv libcork{-shadowsocks/*,}
mv ipset-shadowsocks/* libipset
./autogen.sh
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
$SUBVERSION
6
proxy
10
libssl1.0.2,libpcre3,libsodium18,libev4,libudns0
11
ss-local,ss-server,ss-tunnel,ss-manager,ss-redir,shadowsocks-libev
EOF

