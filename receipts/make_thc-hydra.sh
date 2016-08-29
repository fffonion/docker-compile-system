#!/bin/bash
cd thc-hydra-*
./configure
make -j4
make install

VERSION=$1
echo > description-pak
checkinstall << EOF
n
1
hydra
2
hydra
3
$VERSION
4
1
6
security
10
libssl1.0.2,zlib1g,libidn11,libncurses5,libmysqlclient20,libssh-4,libpcre3
11
hydra
EOF

