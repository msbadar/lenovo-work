#!/bin/bash
set -eo pipefail

podman kill --all

bash os-work.sh
bash work-1.sh

