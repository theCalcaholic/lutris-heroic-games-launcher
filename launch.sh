#!/usr/bin/env bash

set -ex

latest_release="$(curl https://api.github.com/repos/Heroic-Games-Launcher/HeroicGamesLauncher/releases/latest)"
download_url="$(grep -e "browser_download_url.*Heroic.*\.AppImage" <<< "$latest_release" | cut -d : -f 2,3 | tr -d '" ,')"
tag_name="$(grep \"tag_name\": <<< "$latest_release" | cut -d ':' -f 2 | tr -d '" ,')"

if ! [[ -f "./.version" ]] || [[ "$(cat ./.version)" != "$tag_name" ]]
then
  echo "Installing latest version of Heroic Games Launcher..."
  wget -O ./Heroic-Launcher.AppImage "$download_url"
  chmod +x ./Heroic-Launcher.AppImage
fi

nohup ./Heroic-Launcher.AppImage &
