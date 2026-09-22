#!/bin/bash

# Resolve the directory of the current script so it works from anywhere
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"

APP_DIR="$HOME/workspace/terminal"
PORT=4000

if is_port_in_use "$PORT"; then
  echo "Port $PORT is already in use. Skipping terminal."
  exit 0
fi

echo "Port $PORT is free. Starting terminal..."


if [[ ! -d "$APP_DIR" ]]; then
  echo "Error: Directory $APP_DIR does not exist." >&2
  exit 1
fi

cd "$APP_DIR"

# Launch detached from the current shell session
WEBTERM_STATIC_DIR=dist/web nohup ./dist/webterm --port "$PORT" --base-path /terminal > webterm.log 2>&1 &
PID=$!

echo "Terminal started with PID $PID (logging to $APP_DIR/webterm.log)."
