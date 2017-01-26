#!/bin/bash
cd redis-*
./configure --prefix=/usr
make -j4
make install

VERSION=$1
echo "Persistent key-value database with network interface
  Redis is a key-value database in a similar vein to memcache but the dataset
  is non-volatile. Redis additionally provides native support for atomically
  manipulating and querying data structures such as lists and sets.
  .
  The dataset is stored entirely in memory and periodically flushed to disk."> description-pak
checkinstall << EOF
n
2
redis
3
$VERSION
4
$SUBVERSION
6
database
10

11
redis-server, redis-cli, redis-common, redis-tools
13
redis-server, redis-cli, redis-common, redis-tools
EOF

