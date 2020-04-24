#!/bin/bash
# (c) inoro [202004051359]

# RUN AS ROOT

#~ LANG="en-US"
LANG="es-ES"

wget -O FirefoxDeveloperSetup.tar.bz2 "http://download.mozilla.org/?product=firefox-devedition-latest&os=linux64&lang=$LANG"
tar xjf FirefoxDeveloperSetup.tar.bz2 -C ./
rm -r /opt/firefox-developer ||: # == || true (en caso de fallar no muestra error
mkdir -p /opt/firefox-developer
mv ./firefox/* /opt/firefox-developer

echo "[Desktop Entry]" > /usr/share/applications/firefox-developer.desktop
echo "Name=Firefox Developer Edition" >> /usr/share/applications/firefox-developer.desktop
echo "Comment=Web Browser" >> /usr/share/applications/firefox-developer.desktop
echo "Exec=/opt/firefox-developer/firefox %u" >> /usr/share/applications/firefox-developer.desktop
echo "Terminal=false" >> /usr/share/applications/firefox-developer.desktop
echo "Type=Application" >> /usr/share/applications/firefox-developer.desktop
echo "Icon=/opt/firefox-developer/browser/chrome/icons/default/default128.png" >> /usr/share/applications/firefox-developer.desktop
echo "Categories=Network;WebBrowser;" >> /usr/share/applications/firefox-developer.desktop
echo "MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/vnd.mozilla.xul+xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;" >> /usr/share/applications/firefox-developer.desktop
echo "StartupNotify=true" >> /usr/share/applications/firefox-developer.desktop

rm /usr/local/bin/firefox-developer ||: # == || true (en caso de fallar no muestra error
ln -s /opt/firefox-developer/firefox /usr/local/bin/firefox-developer

cp /opt/firefox-developer/browser/chrome/icons/default/default128.png /usr/share/icons/firefox-developer.png
cp /opt/firefox-developer/browser/chrome/icons/default/default128.png "/usr/share/icons/Firefox Developer Edition.png"

rm FirefoxDeveloperSetup.tar.bz2
rm -r ./firefox
