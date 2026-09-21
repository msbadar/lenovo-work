# Working on design
# cd ~/workspace/blinkit || exit 1

cd ~/workspace/udaan || exit 1

# Working on udaan
cd ~/workspace/udaan || exit 1

git checkout work
git pull origin work

# Invoking agent
echo "Invoking agent for work1... $PWD"

# ccr "work as per plan.md"
# ccr "update plan.md for remaining items"
# ccr "commit changes"

echo "Agent run finished."

git push origin work


# # Monitored images that cannot run concurrently
# TRACKED_IMAGES=("sandbox-rn-claude-claude" "antigravity")

# # Timestamp logger
# log() {
#     echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
# }

# # Checks if ANY monitored image is running; exits immediately if found
# ensure_none_running() {
#     log "Checking if any monitored container is currently active..."
#     for img in "${TRACKED_IMAGES[@]}"; do
#         if podman ps --format "{{.Image}}" | grep -q "${img}"; then
#             log "Container '${img}' is currently running. Exiting script."
#             exit 0
#         fi
#     done
# }

# work1() {
#     # Working on udaan
#     cd ~/workspace/udaan || exit 1

#     git checkout work
#     git pull origin work

#     # Invoking agent
#     log "Invoking agent for work1... $PWD"
#     ccr "work as per plan.md"
#     ccr "update plan.md for remaining items"
#     ccr "commit changes"

#     log "Agent run finished."

#     # Pushing changes
#     git push origin work
# }

# # work2() {

#     # Working on design
#     cd ~/workspace/blinkit || exit 1

#     git checkout work
#     #git pull origin work

#     # Invoking agent
#     log "Invoking agent for work2...$PWD"
#     agy -p "work on /work folder,  as per plan.md"
#     agy -p "work on /work folder, update plan.md for remaining items"
#     agy -p "work on /work folder, commit changes"

#     log "Agent run finished."

    # Pushing changes
    #git push origin work
# }

# #ensure_none_running
# #work1
# #work2


# # Works
# ensure_none_running

# works=(work1,work2)


# #!/usr/bin/env bash

# # 1. Use spaces instead of commas to separate elements
# works=(work1 work2)
# echo "WORKS: ${works[*]}"

# # 2. Get total element count
# wtotal=${#works[@]}
# echo "TOTAL: $wtotal"

# # 3. Pick a random index
# windex=$(( RANDOM % wtotal ))
# echo "INDEX: $windex"

# # 4. Access the selected element
# s_work=${works[$windex]}
# echo "WORK: $s_work"

# # 5. Execute it as a command (if intended)
# # $s_work

