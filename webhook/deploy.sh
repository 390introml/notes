#!/bin/bash
set -e

REF="$1"
LOG="/var/log/notes-webhook.log"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG"
}

# Determine which directory based on branch
if [[ "$REF" == "refs/heads/main" ]]; then
    DIR="/home/catsoop/notes"
    BRANCH="main"
elif [[ "$REF" == "refs/heads/dev" ]]; then
    DIR="/home/catsoop/note-dev"
    BRANCH="dev"
else
    log "Unknown ref: $REF, skipping"
    exit 0
fi

log "Deploying $BRANCH to $DIR"

cd "$DIR"

# Pull latest changes
git fetch origin "$BRANCH"
git reset --hard "origin/$BRANCH"

log "Git pull complete"

# Render with Quarto (freeze handles caching)
quarto render

log "Quarto render complete for $BRANCH"
