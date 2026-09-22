#!/bin/bash
set -eo pipefail

PORT=4000

kill $(lsof -t -i :$PORT)

if lsof -Pi :"$PORT" -sTCP:LISTEN -t >/dev/null 2>&1; then
  echo "Port $PORT is already in use. Skipping terminal."
else
  echo "Port $PORT is free. Starting terminal..."
  cd ~/workspace/terminal
  WEBTERM_STATIC_DIR=dist/web ./dist/webterm --port "$PORT" --base-path /terminal &
fi

