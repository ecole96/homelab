#!/bin/bash

set -eu

# initialize configs based on environment variables
source .env
source ./admin/.admin.env
source ./media/.media.env

# initialize new config dirs
mkdir -p "$CONFIG_DIR/jellyfin"
mkdir -p "$CONFIG_DIR/portainer"
mkdir -p "$CONFIG_DIR/prowlarr"
mkdir -p "$CONFIG_DIR/qbittorrent"
mkdir -p "$CONFIG_DIR/radarr"
mkdir -p "$CONFIG_DIR/sonarr"
mkdir -p "$CONFIG_DIR/cloudflared"
mkdir -p "$CONFIG_DIR/clipcascade"
mkdir -p "$CONFIG_DIR/open-webui"
mkdir -p "$CONFIG_DIR/icloudpd"
mkdir -p "$CONFIG_DIR/immich-db"
mkdir -p "$CONFIG_DIR/icloudpd"
mkdir -p "$CONFIG_DIR/immich-db"
mkdir -p "$CONFIG_DIR/immich-machine-learning"
mkdir -p "$CONFIG_DIR/immich-server"

# initialize content folders
mkdir -p "$MEDIA_DIR/media/movies"
mkdir -p "$MEDIA_DIR/media/tv"
mkdir -p "$MEDIA_DIR/torrents/movies"
mkdir -p "$MEDIA_DIR/torrents/tv"

CLOUDFLARED_CONFIG="$CONFIG_DIR/cloudflared/config.yml"
sed "s/<TUNNEL_ID>/$TUNNEL_ID/g" ./admin/cloudflared_config.yml > "$CLOUDFLARED_CONFIG" 
sed -i '' "s/<RADARR_DOMAIN>/$RADARR_DOMAIN/g" "$CLOUDFLARED_CONFIG" 
sed -i '' "s/<RADARR_HOST>/$RADARR_HOST/g" "$CLOUDFLARED_CONFIG" 
sed -i '' "s/<SONARR_DOMAIN>/$SONARR_DOMAIN/g" "$CLOUDFLARED_CONFIG" 
sed -i '' "s/<SONARR_HOST>/$SONARR_HOST/g" "$CLOUDFLARED_CONFIG" 
sed -i '' "s/<JELLYFIN_DOMAIN>/$JELLYFIN_DOMAIN/g" "$CLOUDFLARED_CONFIG" 
sed -i '' "s/<JELLYFIN_HOST>/$JELLYFIN_HOST/g" "$CLOUDFLARED_CONFIG" 

echo 'Homelab directories initialized.'
echo "*** Make sure to copy your cloudflared credentials file to $CONFIG_DIR/cloudflared with filename: $TUNNEL_ID.json ***"

echo 'Creating Docker network...'
docker network create --driver bridge homelab_network
echo 'Network created.'

echo 'Complete.'
