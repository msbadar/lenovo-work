
git pull

echo "run $(date +'%Y-%m-%d %H:%M')" > run.txt

# LOGS
podman ps >> run.txt
{
  printf "%-10s %-10s %-15s\n" "PORT" "PID" "COMMAND"
  for port in 4000 4001 4002 8080 8000; do
    for pid in $(lsof -t -i :"$port" 2>/dev/null || true); do
      cmd=$(ps -p "$pid" -o comm= 2>/dev/null || echo "unknown")
      printf "%-10s %-10s %-15s\n" "$port" "$pid" "$cmd"
    done
  done
} >> run.txt

# # Commit and push only if changes exist
git add .
if ! git diff-index --quiet HEAD --; then
  git commit -m "logs update $(date +'%Y-%m-%d %H:%M')"
  git push origin development
else
  echo "No log changes to commit."
fi
