#/usr/bin/env bash

SIDEKICK_DMG=sidekick.dmg
SIDEKICK_DMG_URL="https://api.meetsidekick.com/downloads/df/mac"
TARGET_DIR=/Applications/Sidekick2.app

if test -f "$SIDEKICK_DMG"; then
  echo "Found $SIDEKICK_DMG, removing..."
  rm $SIDEKICK_DMG
fi

/usr/local/bin/wget -q -O $SIDEKICK_DMG $SIDEKICK_DMG_URL

if [[ ! -f "$SIDEKICK_DMG" ]] ; then
    echo "Error: download failed."
    exit
fi

/usr/bin/hdiutil attach $SIDEKICK_DMG

if [ ! -d "/Volumes/Sidekick/Sidekick.app" ]; then
  echo "Error: mounting browser image"
  exit
fi

if [ -d "$TARGET_DIR" ]; then
  echo "Removing old version: $TARGET_DIR"
  rm -rf $TARGET_DIR
fi

echo "Installing new version: $TARGET_DIR"
cp -R /Volumes/Sidekick/Sidekick.app $TARGET_DIR

/usr/bin/hdiutil detach /Volumes/Sidekick

rm $SIDEKICK_DMG
echo "  done."
echo
