#!/bin/bash
# (c) inoro [202004051359]

# RUN AS ROOT

#~ LANG="en-US"
LANG="es-ES"

wget -O FirefoxNightlySetup.tar.bz2 "http://download.mozilla.org/?product=firefox-nightly-latest&os=linux64&lang=$LANG"
tar xjf FirefoxNightlySetup.tar.bz2 -C ./
rm -r /opt/firefox-nightly
mv ./firefox/* /opt/firefox-nightly

rm FirefoxNightlySetup.tar.bz2
rm -r ./firefox
