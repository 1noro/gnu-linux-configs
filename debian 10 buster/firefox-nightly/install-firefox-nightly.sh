#!/bin/bash
# (c) inoro [202004051359]

# RUN AS ROOT

#~ LANG="en-US"
LANG="es-ES"
EXTRACTED_DIR="firefox"

URL="http://download.mozilla.org/?product=firefox-nightly-latest&os=linux64&lang=$LANG"
NAME="Firefox Nightly"
SHELL_NAME="firefox-nightly"

DOWNLOADED_FILE="$SHELL_NAME-setup.tar.bz2"
INSTALLATION_DIR="/opt/$SHELL_NAME"
DESKTOP_FILE="$SHELL_NAME.desktop"

# --- CLEANING PREVIOUS INSTALLATIONS ------------------------------------------
echo ">> Cleaning the installation stage..."
# Remove EXTRACTED_DIR if exists
if [ -d "$EXTRACTED_DIR" ]; then
    rm -r "$EXTRACTED_DIR"
fi

# Remove DOWNLOADED_FILE if exists
if [ -f "$DOWNLOADED_FILE" ]; then
    rm "$DOWNLOADED_FILE"
fi

# Remove shell link if exists
if [ -f "/usr/local/bin/$SHELL_NAME" ]; then
    rm "/usr/local/bin/$SHELL_NAME"
fi

# Remove gnome shell link if exists
if [ -f "/usr/share/applications/$DESKTOP_FILE" ]; then
    rm "/usr/share/applications/$DESKTOP_FILE"
fi

# Remove icons if exists
if [ -f "/usr/share/icons/$NAME.png" ]; then
    rm "/usr/share/icons/$NAME.png"
fi

if [ -f "/usr/share/icons/$SHELL_NAME.png" ]; then
    rm "/usr/share/icons/$SHELL_NAME.png"
fi

# Remove INSTALLATION_DIR link if exists
if [ -d "$INSTALLATION_DIR" ]; then
    rm -r "$INSTALLATION_DIR"
fi

# --- INSTALLATION -------------------------------------------------------------
echo ">> Downloading $DOWNLOADED_FILE"
wget wget -q --show-progress -O "$DOWNLOADED_FILE" "$URL"
echo ">> Extracting $DOWNLOADED_FILE"
tar xjf "$DOWNLOADED_FILE" -C . --checkpoint=.200

mkdir -p "$INSTALLATION_DIR"
echo ">> Copying $EXTRACTED_DIR/* --> $INSTALLATION_DIR"
cp -r "./$EXTRACTED_DIR/"* "$INSTALLATION_DIR"

echo ">> Copying icons..."
cp "$INSTALLATION_DIR/browser/chrome/icons/default/default128.png" "/usr/share/icons/$SHELL_NAME.png"
cp "$INSTALLATION_DIR/browser/chrome/icons/default/default128.png" "/usr/share/icons/$NAME.png"

echo ">> Copying gnome shell link..."
cp "./$DESKTOP_FILE" "/usr/share/applications/$DESKTOP_FILE"

echo ">> Creating shell link..."
ln -s "$INSTALLATION_DIR/firefox" "/usr/local/bin/$SHELL_NAME"

echo ">> Deleting $DOWNLOADED_FILE"
rm "$DOWNLOADED_FILE"
echo ">> Deleting $EXTRACTED_DIR folder"
rm -r "$EXTRACTED_DIR"

# --- INSTALLING THE UPDATER ---------------------------------------------------
echo ">> Copying updater script..."
cp "./update-$SHELL_NAME.sh" "/opt/update-$SHELL_NAME.sh"
chmod +x "/opt/update-$SHELL_NAME.sh"

echo ">> Copying updater icons..."
cp ./icons/update_128.png "/usr/share/icons/update-$SHELL_NAME.png"
cp ./icons/update_128.png "/usr/share/icons/Update $NAME.png"

echo ">> Copying updater script gnome shell link..."
cp "./update-$SHELL_NAME.desktop" "/usr/share/applications/update-$SHELL_NAME.desktop"
