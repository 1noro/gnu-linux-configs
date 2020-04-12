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

# --- CLEANING -----------------------------------------------------------------
echo ">> Cleaning the installation stage..."

# Remove EXTRACTED_DIR if exists
if [ -d "$EXTRACTED_DIR" ]; then
    rm -r "$EXTRACTED_DIR"
fi

# Remove DOWNLOADED_FILE if exists
if [ -f "$DOWNLOADED_FILE" ]; then
    rm "$DOWNLOADED_FILE"
fi

# Remove INSTALLATION_DIR if exists
if [ -d "$INSTALLATION_DIR" ]; then
    rm -r "$INSTALLATION_DIR"
fi

# --- UPDATE -------------------------------------------------------------------
echo ">> Downloading $DOWNLOADED_FILE"
wget wget -q --show-progress -O "$DOWNLOADED_FILE" "$URL"
echo ">> Extracting $DOWNLOADED_FILE"
tar xjf "$DOWNLOADED_FILE" -C . --checkpoint=.200
echo ""

mkdir -p "$INSTALLATION_DIR"
echo ">> Copying $EXTRACTED_DIR/* --> $INSTALLATION_DIR"
cp -r "./$EXTRACTED_DIR/"* "$INSTALLATION_DIR"

echo ">> Deleting $DOWNLOADED_FILE"
rm "$DOWNLOADED_FILE"
echo ">> Deleting $EXTRACTED_DIR folder"
rm -r "$EXTRACTED_DIR"

echo ""
echo ">> Press any key..."
read
