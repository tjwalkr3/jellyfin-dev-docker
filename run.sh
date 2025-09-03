#!/bin/bash
set -e

echo "Running Jellyfin..."
docker-compose -f docker-compose.yml run --build --rm jellyfin-dev
echo "Run terminated!"