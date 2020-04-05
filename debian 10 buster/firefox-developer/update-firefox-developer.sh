#!/bin/bash
# (c) inoro [202004051359]

# RUN AS ROOT

#~ LANG="en-US"
LANG="es-ES"

wget -O FirefoxDeveloperSetup.tar.bz2 "http://download.mozilla.org/?product=firefox-devedition-latest&os=linux64&lang=$LANG"
tar xjf FirefoxDeveloperSetup.tar.bz2 -C ./
rm -r /opt/firefox-developer
mv ./firefox/* /opt/firefox-developer

rm FirefoxDeveloperSetup.tar.bz2
rm -r ./firefox
