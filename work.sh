#!/bin/bash
set -eo pipefail

# Terminal
cd ~/workspace/terminal
WEBTERM_STATIC_DIR=dist/web nohup ./dist/webterm --port 4000 --base-path /terminal > webterm.log 2>&1 &

# Tunnel
if podman ps --filter "name=cloudflared" --filter "status=running" -q 2>/dev/null | grep -q .; then
  echo "Cloudflared container is already running. Skipping tunnel."
else
  echo "Starting Cloudflare tunnel..."
  cd ~/workspace/tunnel
  # Add '&' at the end if tunnel.sh does not detach on its own
  bash ./tunnel.sh
fi
