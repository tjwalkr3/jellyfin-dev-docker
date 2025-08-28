#!/bin/bash
set -e

echo "Running Jellyfin tests..."
docker-compose -f docker-compose.tests.yml run --build --rm jellyfin-tests
echo "Tests completed!"
