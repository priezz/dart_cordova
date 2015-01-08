#!/bin/sh
# pub build --output=assets
pub build
# mv assets/web assets/www
# rm
# mv build/web www
git add .
git commit -m $(date "+%Y-%m-%H %X")
git push
