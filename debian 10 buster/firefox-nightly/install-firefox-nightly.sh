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

echo "[Desktop Entry]" > /usr/share/applications/firefox-nightly.desktop
echo "Name=Firefox Nightly" >> /usr/share/applications/firefox-nightly.desktop
echo "Comment=Web Browser" >> /usr/share/applications/firefox-nightly.desktop
echo "Exec=/opt/firefox-nightly/firefox %u" >> /usr/share/applications/firefox-nightly.desktop
echo "Terminal=false" >> /usr/share/applications/firefox-nightly.desktop
echo "Type=Application" >> /usr/share/applications/firefox-nightly.desktop
echo "Icon=/opt/firefox-nightly/browser/chrome/icons/default/default128.png" >> /usr/share/applications/firefox-nightly.desktop
echo "Categories=Network;WebBrowser;" >> /usr/share/applications/firefox-nightly.desktop
echo "MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/vnd.mozilla.xul+xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;" >> /usr/share/applications/firefox-nightly.desktop
echo "StartupNotify=true" >> /usr/share/applications/firefox-nightly.desktop

FILE=/usr/local/bin/firefox-nightly
if [ -f "$FILE" ]; then
    rm "$FILE"
fi
ln -s /opt/firefox-nightly/firefox /usr/local/bin/firefox-nightly

cp /opt/firefox-nightly/browser/chrome/icons/default/default128.png /usr/share/icons/firefox-nightly.png
cp /opt/firefox-nightly/browser/chrome/icons/default/default128.png "/usr/share/icons/Firefox Nightly.png"

# Updater
cp ./update-firefox-nightly.sh /opt/update-firefox-nightly.sh
chmod +x /opt/update-firefox-nightly.sh

cp ./update-firefox-nightly.desktop /usr/share/applications/update-firefox-nightly.desktop

cp ./icons/update_128.png /usr/share/icons/update-firefox-nightly.png
cp ./icons/update_128.png "/usr/share/icons/Update Firefox Nightly.png"

# Clean
rm FirefoxNightlySetup.tar.bz2
rm -r ./firefox
