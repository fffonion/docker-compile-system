#!/bin/bash
cd medusa-*
./configure
make -j4
make install

VERSION=$1
echo > description-pak
checkinstall << EOF
n
1
medusa
2
medusa
3
$VERSION
4
1
6
security
10
libssl1.0.2,libssh2-1
11
medusa
EOF

