#!/bin/bash

# Define timestamp logger
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
}

IMAGE_NAME="sandbox-rn-claude-claude"
cd ~/workspace/repo-maker || exit 1

log "Checking if container is running..."

if podman ps --format "{{.Image}}" | grep -q "${IMAGE_NAME}"; then
    log "Container '${IMAGE_NAME}' is already running. Exiting."
    exit 0
fi

read -r -d '' PROMPT << 'EOM' || true
work on pending items listed in plan.md. commit changes once finished
EOM

log "Invoking agent with prompt..."
ccr "$PROMPT"
log "Agent run finished."
