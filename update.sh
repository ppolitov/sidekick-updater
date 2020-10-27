#/usr/bin/env bash

SIDEKICK_DMG=sidekick.dmg
SIDEKICK_DMG_URL="https://api.meetsidekick.com/downloads/df/mac"
TARGET_DIR=/Applications/Sidekick2.app

if test -f "$SIDEKICK_DMG"; then
  echo "Found $SIDEKICK_DMG, removing..."
  rm $SIDEKICK_DMG
fi

wget -q -O $SIDEKICK_DMG $SIDEKICK_DMG_URL

hdiutil attach $SIDEKICK_DMG

if [ -d "$TARGET_DIR" ]; then
  echo "Removing old version: $TARGET_DIR"
  rm -rf $TARGET_DIR
fi

echo "Installing new version: $TARGET_DIR"
cp -R /Volumes/Sidekick/Sidekick.app $TARGET_DIR

hdiutil detach /Volumes/Sidekick

rm $SIDEKICK_DMG
echo "  done."
echo
