#!/bin/sh

git clone ssh://git@bd.ysmood.org:8022/music-fe/sofia.git
cd sofia/lib
npm install
command -v bower >/dev/null 2>&1 || { npm install -g bower; exit 1; }
bower install
