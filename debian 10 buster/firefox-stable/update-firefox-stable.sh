#!/bin/bash
# (c) inoro [201910272134]
# [update-firefox]

# RUN AS ROOT

#~ LANG="en-US"
LANG="es-ES"

wget -O FirefoxSetup.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=$LANG"
tar xjf FirefoxSetup.tar.bz2 -C /opt

rm FirefoxSetup.tar.bz2
