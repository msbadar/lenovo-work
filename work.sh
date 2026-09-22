#!/bin/bash
set -eo pipefail

# # Terminal
# cd ~/workspace/terminal
# WEBTERM_STATIC_DIR=dist/web nohup ./dist/webterm --port 4000 --base-path /terminal > webterm.log 2>&1 &


# Nova OS
# cd ~/workspace/nova-os
# ./dist/nova-os --port 4001 &


# Tunnel
# if podman ps --filter "name=cloudflared" --filter "status=running" -q 2>/dev/null | grep -q .; then
#   echo "Cloudflared container is already running. Skipping tunnel."
# else
# echo "Starting Cloudflare tunnel..."
# cd ~/workspace/tunnel
# # Add '&' at the end if tunnel.sh does not detach on its own
# bash ./tunnel.sh
# fi

git pull
echo "test $(date +'%Y-%m-%d %H:%M')" > test.txt
podman ps -a > containers.txt

lsof -t -i :4000 > ports.txt
lsof -t -i :4001 >> ports.txt
lsof -t -i :4002 >> ports.txt
lsof -t -i :8080 >> ports.txt
lsof -t -i :8000 >> ports.txt

git add .
git commit -m "logs update $(date +'%Y-%m-%d %H:%M')"
git push origin development
