#!/bin/sh

dir='sofia'
if [ $1 ]; then
    dir=$1
fi

git clone ssh://git@bd.ysmood.org:8022/music-fe/sofia.git $dir

cd $dir/lib

npm install

command -v bower >/dev/null 2>&1 || { npm install -g bower; exit 1; }
bower install
