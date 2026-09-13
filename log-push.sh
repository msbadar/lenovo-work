cd ~/workspace/work || exit 1
git add .
git commit -m "logs update $(date +'%Y-%m-%d %H:%M')"
git push origin development
