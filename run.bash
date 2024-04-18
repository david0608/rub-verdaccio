#!/bin/bash
set -e

dir=$(dirname $(realpath $0))

if ! [ -d $dir/storage ]
then
  mkdir $dir/storage
fi

chmod 777 $dir/conf
chmod 777 $dir/storage

docker run -itd \
  --name=verdaccio \
  -p 4873:4873 \
  -v $dir/conf:/verdaccio/conf \
  -v $dir/storage:/verdaccio/storage \
  verdaccio/verdaccio
