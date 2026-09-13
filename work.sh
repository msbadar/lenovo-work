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
- create github actions to deploy to cloud run 
- work on pending items listed in plan.md.
- commit changes once finished
EOM

# invoking agent
log "Invoking agent with prompt..."
ccr "$PROMPT"
log "Agent run finished."
ccr "commit changes"

# Pushing changes
git push origin development


# pushing logs
cd ~/workspace/work || exit 1
git add .
gi commit -m "logs +%F %T "
git push origin development
