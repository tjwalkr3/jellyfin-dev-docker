#!/bin/bash
set -e

echo "Running Jellyfin..."
docker-compose run --build --rm jellyfin
echo "Run terminated!"