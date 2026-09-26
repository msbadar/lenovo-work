#!/bin/bash
# set -eo pipefail

# # Cleanup
# podman kill --all
# # kill $(lsof -t -i :4000) || true


# Terminal
PORT=4002
if ! ss -tuln | grep -q ":${PORT}\b"; then
  (
    cd ~/workspace/terminal || exit 1
    WEBTERM_STATIC_DIR=dist/web ./dist/webterm --port "$PORT" &
  )
fi

# # # Nova OS
# (
#   cd ~/workspace/nova-os
#   ./dist/nova-os --port 4001 &
# )


#Tunnel
(
  cd ~/workspace/tunnel
  bash ./tunnel.sh
)


# Logs
  bash ./logs.sh

