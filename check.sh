#!/bin/bash

PREVIOUS_VERSION=$(cat latest)
CURRENT_VERSION=$(curl https://api.github.com/repos/ProtonMail/proton-bridge/releases/latest | jq ".tag_name" -r)

VERSION_UPDATED="0"

if [[ $PREVIOUS_VERSION != $CURRENT_VERSION ]]; then
  VERSION_UPDATED="1"
fi

echo "VERSION_UPDATED=$VERSION_UPDATED" >> "$GITHUB_OUTPUT"
echo "VERSION=${CURRENT_VERSION//v}" >> "$GITHUB_OUTPUT"

cat $GITHUB_OUTPUT

echo $CURRENT_VERSION > latest
