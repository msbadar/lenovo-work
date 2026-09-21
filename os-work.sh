#!/bin/bash
set -eo pipefail

PORT=4000

# 1. Check if port 4000 is already active
if lsof -Pi :"$PORT" -sTCP:LISTEN -t >/dev/null 2>&1; then
  echo "Port $PORT is already in use. Skipping nova-os."
else
  echo "Port $PORT is free. Starting nova-os..."
  cd ~/workspace/nova-os
  ./dist/nova-os --port "$PORT" &

  # Wait for nova-os to start listening before proceeding
  while ! lsof -Pi :"$PORT" -sTCP:LISTEN -t >/dev/null 2>&1; do
    sleep 0.5
  done
  echo "nova-os is up and listening on port $PORT."
fi

# 2. Check if a container based on the cloudflared image is running
if podman ps --format '{{.Image}}' 2>/dev/null | grep -qi "cloudflared"; then
  echo "Cloudflared container is already running. Skipping tunnel."
else
  echo "Starting Cloudflare tunnel..."
  cd ~/workspace/cloudflare
  bash ./tunnel.sh
fi
