#!/bin/sh
pub build --output=assets
mv assets/web assets/www
git add .
git commit -m 'First commit'
git push
