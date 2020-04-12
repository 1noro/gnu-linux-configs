#!/bin/bash
# (c) inoro [202004051359]
# RUN AS ROOT

#~ LANG="en-US"
LANG="es-ES"

FILE=./FirefoxNightlySetup.tar.bz2
if [ -f "$FILE" ]; then
    rm "$FILE"
fi

echo ">> Downloading..."
wget -O FirefoxNightlySetup.tar.bz2 "http://download.mozilla.org/?product=firefox-nightly-latest&os=linux64&lang=$LANG"
echo ">> Extracting..."
tar xjf FirefoxNightlySetup.tar.bz2 -C ./

DIR=/opt/firefox-nightly
if [ -d "$DIR" ]; then
    rm -r "$DIR"
fi

mkdir -p /opt/firefox-nightly
echo ">> Moving..."
mv ./firefox/* /opt/firefox-nightly

echo ">> Cleaning 'FirefoxNightlySetup.tar.bz2' file"
rm ./FirefoxNightlySetup.tar.bz2
echo ">> Cleaning 'firefox' folder"
rm -r ./firefox

echo ""
echo ">> Press any key..."
read
