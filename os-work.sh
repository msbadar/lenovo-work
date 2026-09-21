#!/bin/bash
set -eo pipefail

wait_for_port() {
  local port="$1"
  local pid="$2"
  local service="$3"
  local max_retries=20
  local count=0

  while ! lsof -Pi :"$port" -sTCP:LISTEN -t >/dev/null 2>&1; do
    if ! kill -0 "$pid" 2>/dev/null; then
      echo "Error: $service (PID $pid) terminated unexpectedly." >&2
      return 1
    fi

    count=$((count + 1))
    if [ "$count" -ge "$max_retries" ]; then
      echo "Error: Timed out waiting for $service on port $port." >&2
      return 1
    fi
    sleep 0.5
  done

  echo "$service is up and listening on port $port."
}

# 1. Start nova-os
PORT=4000
if lsof -Pi :"$PORT" -sTCP:LISTEN -t >/dev/null 2>&1; then
  echo "Port $PORT is already in use. Skipping nova-os."
else
  echo "Port $PORT is free. Starting nova-os..."
  cd ~/workspace/nova-os
  ./dist/nova-os --port "$PORT" &
  NOVA_PID=$!

  wait_for_port "$PORT" "$NOVA_PID" "nova-os"
fi


# 2. Start webterm
PORT=4001
if lsof -Pi :"$PORT" -sTCP:LISTEN -t >/dev/null 2>&1; then
  echo "Port $PORT is already in use. Skipping terminal."
else
  echo "Port $PORT is free. Starting terminal..."
  cd ~/workspace/terminal
  ./dist/webterm --port "$PORT" &
  TERM_PID=$!
  wait_for_port "$PORT" "$TERM_PID" "webterm"
fi



# 3. Check and start Cloudflare tunnel
if podman ps --format '{{.Image}}' 2>/dev/null | grep -qi "cloudflared"; then
  echo "Cloudflared container is already running. Skipping tunnel."
else
  echo "Starting Cloudflare tunnel..."
  cd ~/workspace/cloudflare
  bash ./tunnel.sh
fi
