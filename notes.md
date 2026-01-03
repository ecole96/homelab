
**Folder Permissions**
Ensure media server folders have the right permissions (run from project root):  
    `sudo chown -R your-docker-user-here:your-docker-group-here ./data`  
    `sudo chmod -R a=,a+rX,u+w,g+w /data`

**Jellyfin**
1. Set up libraries
    - Radarr: /data/media/movies 
    - Sonarr: /data/media/tv

**Prowlarr**
1. Add Flaresolverr (Settings > Indexers)
2. Add applications (Radarr, Sonarr - get API keys from each - Settings > General). 
3. Add indexers (use flaresolverr tag when needed).

**Radarr / Sonarr**  
1. Verify hardlinks are set up and set root folder
    - Radarr: /data/media/movies
    - Sonarr: /data/media/tv
2. Set up Qbittorrent (Download Clients).
3. Set up indexers (set Seed Time to 1) and set Maximum File Size in global indexer settings to reduce storage use.

**qBittorrent**
1. Set network interface to tun0
2. Set default save path (/data/torrents).
3. Check "Category paths in Manual mode"
4. Right-click Radarr / Sonarr categories in sidebar, set category paths 
    - Radarr: /data/torrents/movies
    - Sonarr: /data/torrents/tv

*During configuration, keep every hostname reference as "localhost".