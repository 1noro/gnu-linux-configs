#!/bin/bash
# (c) inoro [201910272134]
# [update-firefox]

# RUN AS ROOT

#~ LANG="en-US"
LANG="es-ES"

wget -O FirefoxSetup.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=$LANG"
tar xjf FirefoxSetup.tar.bz2 -C /opt

echo "[Desktop Entry]" > /usr/share/applications/firefox-stable.desktop
echo "Name=Firefox Stable" >> /usr/share/applications/firefox-stable.desktop
echo "Comment=Web Browser" >> /usr/share/applications/firefox-stable.desktop
echo "Exec=/opt/firefox/firefox %u" >> /usr/share/applications/firefox-stable.desktop
echo "Terminal=false" >> /usr/share/applications/firefox-stable.desktop
echo "Type=Application" >> /usr/share/applications/firefox-stable.desktop
echo "Icon=/opt/firefox/browser/chrome/icons/default/default128.png" >> /usr/share/applications/firefox-stable.desktop
echo "Categories=Network;WebBrowser;" >> /usr/share/applications/firefox-stable.desktop
echo "MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/vnd.mozilla.xul+xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;" >> /usr/share/applications/firefox-stable.desktop
echo "StartupNotify=true" >> /usr/share/applications/firefox-stable.desktop

mv /usr/local/bin/firefox /usr/local/bin/firefox-ori
ln -s /opt/firefox/firefox /usr/local/bin/firefox
update-alternatives --install /usr/bin/x-www-browser x-www-browser /opt/firefox/firefox 200 && update-alternatives --set x-www-browser /opt/firefox/firefox

rm FirefoxSetup.tar.bz2
