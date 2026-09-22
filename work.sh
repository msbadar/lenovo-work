#!/bin/bash
set -eo pipefail


# Terminal
cd ~/workspace/terminal
WEBTERM_STATIC_DIR=dist/web nohup ./dist/webterm --port 4000 --base-path /terminal > webterm.log 2>&1 &


# Tunnel
if podman ps --format '{{.Image}}' 2>/dev/null | grep -qi "cloudflared"; then
  echo "Cloudflared container is already running. Skipping tunnel."
else
  echo "Starting Cloudflare tunnel..."
  cd ~/workspace/tunnel
  bash ./tunnel.sh
fi
