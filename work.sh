#!/bin/bash
set -eo pipefail


# Terminal
cd ~/workspace/terminal
WEBTERM_STATIC_DIR=dist/web nohup ./dist/webterm --port 4000 --base-path /terminal > webterm.log 2>&1 &
