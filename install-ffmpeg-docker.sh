#!/bin/bash
set -e

# Install dependencies for ffmpeg and repo management
apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add the Jellyfin repository key
install -d /etc/apt/keyrings
curl -fsSL https://repo.jellyfin.org/debian/jellyfin_team.gpg.key | gpg --dearmor -o /etc/apt/keyrings/jellyfin.gpg

# Add the Jellyfin repository
OS_CODENAME=$(lsb_release -cs)
echo "deb [signed-by=/etc/apt/keyrings/jellyfin.gpg] https://repo.jellyfin.org/debian $OS_CODENAME main" > /etc/apt/sources.list.d/jellyfin.list

# Install ffmpeg
apt-get update && apt-get install -y --no-install-recommends jellyfin-ffmpeg7


# Create symlinks for ffmpeg and ffprobe
ln -s /usr/lib/jellyfin-ffmpeg/ffmpeg /usr/local/bin/ffmpeg
ln -s /usr/lib/jellyfin-ffmpeg/ffprobe /usr/local/bin/ffprobe

# Clean up
rm -rf /var/lib/apt/lists/*
