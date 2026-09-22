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


# Checks if ANY monitored image is running; exits immediately if found
ensure_images_not_running() {
    if [[ $# -eq 0 ]]; then
        log "Warning: No images provided to check."
        return 0
    fi

    log "Checking if any monitored container is currently active..."
    for img in "$@"; do
        # -F treats the image name as a fixed string rather than a regex pattern
        if podman ps --format "{{.Image}}" | grep -Fq "${img}"; then
            log "Container '${img}' is currently running. Exiting script."
            exit 0
        fi
    done
}
