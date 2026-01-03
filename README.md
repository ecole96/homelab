## Setup
1. Install [Docker](https://www.docker.com/)

2. Copy the contents of `.env.example` and paste it into a file at the project root named `.env`

3. In `.env`, replace the value of `WIREGUARD_PRIVATE_KEY` with the Wireguard key provided by your VPN. If you can't use Wireguard, check [Gluetun documentation](https://github.com/qdm12/gluetun) for using OpenVPN (you will also need to update the .ymls with those variables).

4. Replace the `PUID` and `PGID` values with the respective user and group ID you want to run the stack (Google the commands for finding these)

5. In the project directory, run `init.sh` to create the application and media directories (you may need [Git Bash](https://git-scm.com/downloads) on Windows)

6. Start the stack: `docker compose -f <your-compose-file-here.yml> up -d`
    - Use `mac.yml` for now.
    - Web applications (Radarr, Sonarr, Prowlarr, qBittorrent) are accessible in your browser at `<device-ip>:<host-port>` (host ports by app are found under the `ports` block in the `gluetun` and `jellyfin` sections - it is the number before the colon `:`). If accessed from the same computer they're running on, `localhost:<host-port>` should work. Example, Jellyfin: `localhost:8096`

7. Configure the launched stack:

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

## Stop stack
`docker compose -f <your-compose-file-here.yml> down`
