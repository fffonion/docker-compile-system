#!/bin/bash

docker run $docker_opts --rm -v $builddir/$arch:/build -v $SCR/../receipts:/script -w /build $image_name bash /build.sh
docker rmi $image_name

rm $NAME*.tar.gz
popd
