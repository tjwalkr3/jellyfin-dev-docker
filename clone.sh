#!/bin/bash

# Minimalistic script to clone Jellyfin repositories

echo "Cloning Jellyfin repositories..."

# Clone the main Jellyfin server repository
if [ ! -d "jellyfin" ]; then
    echo "Cloning jellyfin/jellyfin..."
    git clone git@github.com:tjwalkr3/jellyfin.git
else
    echo "jellyfin directory already exists, skipping..."
fi

# Clone the Jellyfin web client repository
if [ ! -d "jellyfin-web" ]; then
    echo "Cloning jellyfin/jellyfin-web..."
    git clone git@github.com:jellyfin/jellyfin-web.git
else
    echo "jellyfin-web directory already exists, skipping..."
fi

echo "Done! Both repositories are now available."
echo "Use ./start.sh to build and start Jellyfin."
