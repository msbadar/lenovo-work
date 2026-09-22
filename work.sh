#!/bin/bash
set -eo pipefail

# --- Background Services ---
# Wrapped in subshells (...) so directory changes don't affect the rest of the script.

# Terminal
# (
#   cd ~/workspace/terminal
#   WEBTERM_STATIC_DIR=dist/web nohup ./dist/webterm --port 4000 --base-path /terminal > webterm.log 2>&1 &
# )

# Nova OS
# (
#   cd ~/workspace/nova-os
#   ./dist/nova-os --port 4001 &
# )

# Tunnel
# if podman ps --filter "name=cloudflared" --filter "status=running" -q 2>/dev/null | grep -q .; then
#   echo "Cloudflared container is already running. Skipping tunnel."
# else
#   echo "Starting Cloudflare tunnel..."
#   (
#     cd ~/workspace/tunnel
#     bash ./tunnel.sh
#   )
# fi

# --- Git Synchronization & Diagnostics ---

# Match git push target branch
git fetch origin
git reset --hard origin/development
git clean -fd  

# Write status files
echo "test $(date +'%Y-%m-%d %H:%M')" > test.txt
#podman ps >> containers.txt

# # Query all ports at once. '|| true' prevents set -e from aborting when a port is inactive.
# lsof -t -i :4000,4001,4002,8080,8000 > ports.txt 2>/dev/null || true

# Commit and push only if changes exist
git add .
if ! git diff-index --quiet HEAD --; then
  git commit -m "logs update $(date +'%Y-%m-%d %H:%M')"
  git push origin development
else
  echo "No log changes to commit."
fi
