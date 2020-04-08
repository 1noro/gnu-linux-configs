#!/bin/bash
# (c) inoro [202004051359]

# RUN AS ROOT

#~ LANG="en-US"
LANG="es-ES"

FILE=./FirefoxNightlySetup.tar.bz2
if [ -f "$FILE" ]; then
    rm "$FILE"
fi

wget -O FirefoxNightlySetup.tar.bz2 "http://download.mozilla.org/?product=firefox-nightly-latest&os=linux64&lang=$LANG"
echo ""
echo "Extracting..."
tar xjf FirefoxNightlySetup.tar.bz2 -C ./

DIR=/opt/firefox-nightly
if [ -d "$DIR" ]; then
    rm -r "$DIR"
fi

mkdir -p /opt/firefox-nightly
mv ./firefox/* /opt/firefox-nightly

# Claeaning
rm FirefoxNightlySetup.tar.bz2
rm -r ./firefox

echo ""
echo "Press any key..."
read
