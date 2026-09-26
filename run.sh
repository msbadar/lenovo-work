#!/bin/bash
# set -eo pipefail


# chmod +x /home/badar/workspace/work/run.sh

# crontab -l 2>/dev/null | grep -Fq "/home/badar/workspace/work/run.sh" || (crontab -l 2>/dev/null; echo "* * * * * /home/badar/workspace/work/run.sh") | crontab -


# # Cleanup
# podman kill --all
# # kill $(lsof -t -i :4000) || true
# # kill $(lsof -t -i :4001) || true
# # kill $(lsof -t -i :8080) || true
# # kill $(lsof -t -i :8000) || true


# # Match git push target branch
# git fetch origin
# git reset --hard origin/development
# git clean -fd  

# # # Write status files



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

