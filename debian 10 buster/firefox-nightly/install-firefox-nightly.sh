#!/bin/bash
# (c) inoro [202004051359]

# RUN AS ROOT

#~ LANG="en-US"
LANG="es-ES"
URL="http://download.mozilla.org/?product=firefox-nightly-latest&os=linux64&lang=$LANG"
DOWNLOADED_FILE="FirefoxNightlySetup.tar.bz2"
EXTRACTED_DIR="firefox"
DESTINATION_DIR="/opt/firefox-nightly"
DESKTOP_FILE="firefox-nightly.desktop"
NAME="Firefox Nightly"
SHELL_NAME="firefox-nightly"

echo ">> Cleaning the installation stage..."
if [ -f "$DOWNLOADED_FILE" ]; then
    rm "$DOWNLOADED_FILE"
fi

if [ -d "$EXTRACTED_DIR" ]; then
    rm -r "$EXTRACTED_DIR"
fi

if [ -d "$DESTINATION_DIR" ]; then
    rm -r "$DESTINATION_DIR"
fi

if [ -f "/usr/local/bin/$SHELL_NAME" ]; then
    rm "/usr/local/bin/$SHELL_NAME"
fi

echo ">> Downloading..."
wget wget -q --show-progress -O "$DOWNLOADED_FILE" "$URL"
echo ">> Extracting..."
tar xjf ./"$DOWNLOADED_FILE" -C ./

mkdir -p "$DESTINATION_DIR"
echo ">> Moving..."
mv ./"$EXTRACTED_DIR"/* "$DESTINATION_DIR"

echo ">> Copying icons..."
cp "$DESTINATION_DIR" /browser/chrome/icons/default/default128.png /usr/share/icons/"$SHELL_NAME".png
cp "$DESTINATION_DIR" /browser/chrome/icons/default/default128.png "/usr/share/icons/$NAME.png"

echo ">> Copying gnome shell link..."
cp ./"$DESKTOP_FILE" /usr/share/applications/"$DESKTOP_FILE"

echo ">> Creating shell link..."
ln -s "$DESTINATION_DIR"/firefox /usr/local/bin/"$SHELL_NAME"

echo ">> Cleaning 'FirefoxNightlySetup.tar.bz2' file"
rm "$DOWNLOADED_FILE"
echo ">> Cleaning 'firefox' folder"
rm -r "$EXTRACTED_DIR"

# Updater
echo ">> Copying updater script..."
cp ./update-firefox-nightly.sh /opt/update-firefox-nightly.sh
chmod +x /opt/update-firefox-nightly.sh

echo ">> Copying updater icons..."
cp ./icons/update_128.png /usr/share/icons/update-firefox-nightly.png
cp ./icons/update_128.png "/usr/share/icons/Update Firefox Nightly.png"

echo ">> Copying updater script gnome shell link..."
cp ./update-firefox-nightly.desktop /usr/share/applications/update-firefox-nightly.desktop
