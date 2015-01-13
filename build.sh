#!/bin/sh

# pub build --output=assets
# pub update
pub build

rm -rf www/*
mv build/web/* www/
# cp config.xml www/
rm -rf build

cordova build
cp -f platforms/android/ant-build/CordovaApp-debug.apk ./

git add .
git commit -m "$(date '+%Y-%m-%H %X')"
# git push
git push -u origin master

cd www
git add .
git commit -m "$(date '+%Y-%m-%H %X')"
git push -u origin cordova




#cordova plugin add org.apache.cordova.geolocation
#cordova plugin add org.apache.cordova.device
#cordova plugin add org.apache.cordova.device-motion
#cordova plugin add org.apache.cordova.console
