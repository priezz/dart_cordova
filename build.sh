#!/bin/sh
# pub build --output=assets
pub build
# mv assets/web assets/www
rm -rf www
mv build/web www
rm -rf build
git add .
git commit -m "$(date '+%Y-%m-%H %X')"
git push
