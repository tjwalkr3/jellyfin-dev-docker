#!/bin/bash
set -e

echo "Starting Jellyfin..."
docker-compose up --build
echo "Jellyfin stopped!"