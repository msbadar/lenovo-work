#!/bin/bash

# Define timestamp logger
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
}

IMAGE_NAME="sandbox-rn-claude-claude"
log "Checking if container is running..."
if podman ps --format "{{.Image}}" | grep -q "${IMAGE_NAME}"; then
    log "Container '${IMAGE_NAME}' is already running. Exiting."
    exit 0
fi

# Working on udaan
cd ~/workspace/udaan || exit 1

# # Prompt
# read -r -d '' PROMPT << 'EOM' || true
# TODO: 
# - work on improving overall ui to follow modern design pattern 
# - update plan.md for pending items 
# EOM

# invoking agent
log "Invoking agent with prompt..."

ccr "work on improving overall ui to follow modern design pattern "
ccr "commit changes"

log "Agent run finished."
# Pushing changes
git push origin development


