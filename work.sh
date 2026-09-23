#!/bin/bash
set -eo pipefail


# Cleanup
# podman kill --all
# kill $(lsof -t -i :4000) || true
# kill $(lsof -t -i :4001) || true
# kill $(lsof -t -i :8080) || true
# kill $(lsof -t -i :8000) || true


# Match git push target branch
git fetch origin
git reset --hard origin/development
git clean -fd  

# Write status files
echo "run $(date +'%Y-%m-%d %H:%M')" > run.txt


# Terminal
(
  cd ~/workspace/terminal
 WEBTERM_STATIC_DIR=dist/web  ./dist/webterm --port 4002
)

# # Nova OS
(
  cd ~/workspace/nova-os
  ./dist/nova-os --port 4001 &
)


# Tunnel
if podman ps --filter "name=cloudflared" --filter "status=running" -q 2>/dev/null | grep -q .; then
  echo "Cloudflared container is already running. Skipping tunnel."
else
  echo "Starting Cloudflare tunnel..."
  (
    cd ~/workspace/tunnel
    bash ./tunnel.sh
  )
fi

# LOGS
podman ps > containers.txt
{
  printf "%-10s %-10s %-15s\n" "PORT" "PID" "COMMAND"
  for port in 4000 4001 4002 8080 8000; do
    for pid in $(lsof -t -i :"$port" 2>/dev/null || true); do
      cmd=$(ps -p "$pid" -o comm= 2>/dev/null || echo "unknown")
      printf "%-10s %-10s %-15s\n" "$port" "$pid" "$cmd"
    done
  done
} > ports.txt

# Commit and push only if changes exist
git add .
if ! git diff-index --quiet HEAD --; then
  git commit -m "logs update $(date +'%Y-%m-%d %H:%M')"
  git push origin development
else
  echo "No log changes to commit."
fi
