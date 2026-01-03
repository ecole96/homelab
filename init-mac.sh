#!/bin/bash

set -eu

# reset dirs
rm -rf ./config
rm -rf ./data

# initialize new config dirs
mkdir -p ./config/jellyfin
mkdir -p ./config/portainer
mkdir -p ./config/prowlarr
mkdir -p ./config/qbittorrent
mkdir -p ./config/radarr
mkdir -p ./config/sonarr
mkdir -p ./config/cloudflared

# initialize content folders
mkdir -p ./data/media/movies
mkdir -p ./data/media/tv
mkdir -p ./data/torrents/movies
mkdir -p ./data/torrents/tv

# initialize cloudflared config file based on environment variables
source .env

CONFIG_FILE_PATH="./config/cloudflared/config.yml"
sed "s/<TUNNEL_ID>/$TUNNEL_ID/g" ./cloudflared_config.yml > "$CONFIG_FILE_PATH" 
sed -i '' "s/<RADARR_DOMAIN>/$RADARR_DOMAIN/g" "$CONFIG_FILE_PATH" 
sed -i '' "s/<RADARR_HOST>/$RADARR_HOST/g" "$CONFIG_FILE_PATH" 
sed -i '' "s/<SONARR_DOMAIN>/$SONARR_DOMAIN/g" "$CONFIG_FILE_PATH" 
sed -i '' "s/<SONARR_HOST>/$SONARR_HOST/g" "$CONFIG_FILE_PATH" 
sed -i '' "s/<JELLYFIN_DOMAIN>/$JELLYFIN_DOMAIN/g" "$CONFIG_FILE_PATH" 
sed -i '' "s/<JELLYFIN_HOST>/$JELLYFIN_HOST/g" "$CONFIG_FILE_PATH" 

echo 'Homelab directories initialized.'
echo "*** Make sure to copy your cloudflared credentials file to ./config/cloudflared with filename: $TUNNEL_ID.json ***"
