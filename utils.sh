#!/bin/bash

is_port_in_use() {
  local port="$1"

  if [[ -z "$port" ]]; then
    echo "Usage: is_port_in_use <port>" >&2
    return 2
  fi

  if command -v lsof >/dev/null 2>&1; then
    lsof -Pi :"$port" -sTCP:LISTEN -t >/dev/null 2>&1
  else
    (exec 3<>/dev/tcp/127.0.0.1/"$port") 2>/dev/null && exec 3>&-
  fi
}


log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
}
