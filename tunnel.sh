if podman ps --format '{{.Image}}' 2>/dev/null | grep -qi "cloudflared"; then
  echo "Cloudflared container is already running. Skipping tunnel."
else
  echo "Starting Cloudflare tunnel..."
  cd ~/workspace/tunnel
  bash ./tunnel.sh
fi
