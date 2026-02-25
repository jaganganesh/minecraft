#!/bin/bash

# Skin Pack Location
PATH="/Users/jagan/Desktop/skinPack"

# Temporary file to keep track of the build number
currentBuild=$(cat skinCompileUpload.dat)
echo "$((currentBuild + 1))" > skinCompileUpload.dat

# Generate unique UUIDs for the manifest
UUID1=$(uuidgen)
UUID2=$(uuidgen)

MANIFEST=$(cat <<EOF
  {
    "header": {
      "name": "Default Skin Pack",
      "description": "A skin pack that contains the default skins for Minecraft.",
      "version": [0, 0, $((currentBuild + 1))],
      "uuid": "$UUID1"
    },
    "modules": [
      {
        "version": [0, 0, $((currentBuild + 1))],
        "type": "skin_pack",
        "uuid": "$UUID2"
      }
    ],
    "format_version": 1
  }
EOF
)

SKIN=$(cat <<EOF
  {
    "serialize_name": "DefaultSkinPack",
    "localization_name": "DefaultSkinPack",
    "skins": [
      {
        "localization_name": "Default Alex",
        "geometry": "geometry.humanoid.customSlim",
        "texture": "alex.png",
        "type": "free"
      },
      {
        "localization_name": "Default Steve",
        "geometry": "geometry.humanoid.custom",
        "texture": "steve.png",
        "type": "free"
      }
    ]
  }
EOF
)

cd $PATH
echo $MANIFEST > manifest.json
echo $SKIN > skins.json
zip -r /Users/jagan/Desktop/skinPack.mcpack . -x "*.DS_Store" -x "__MACOSX"

# Connect your Android device and make sure USB debugging is enabled
adb push /Users/jagan/Desktop/skinPack.mcpack /sdcard/
