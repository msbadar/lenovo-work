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

# Prompt
read -r -d '' PROMPT << 'EOM' || true
TODO: 
- github actions , cloud run service account should have suffix dev or prod based on branch. if main, it should be prod. otherwise it should be dev.
- work on pending items by priority as per priority
- update plan.md for pending items 
EOM

# invoking agent
log "Invoking agent with prompt..."
ccr "$PROMPT"
log "Agent run finished."
ccr "commit changes"

# Pushing changes
git push origin development


