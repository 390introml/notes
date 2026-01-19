#!/bin/bash
set -euo pipefail

# Ensure quarto and git are in PATH (adjust if installed elsewhere)
export PATH="/usr/local/bin:/usr/bin:/bin:$PATH"
# If quarto is installed via quarto-cli in opt:
[[ -d /opt/quarto/bin ]] && export PATH="/opt/quarto/bin:$PATH"

REF="${1:-}"
LOG="/var/log/notes-webhook.log"
LOCK="/tmp/notes-deploy.lock"
TIMEOUT=600  # 10 minutes max for quarto render

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG"
}

# Validate input
if [[ -z "$REF" ]]; then
    log "ERROR: No ref provided"
    exit 1
fi

# Prevent concurrent deployments
exec 200>"$LOCK"
if ! flock -n 200; then
    log "Another deployment in progress, skipping"
    exit 0
fi

# Strict branch validation
case "$REF" in
    "refs/heads/main")
        DIR="/home/catsoop/notes"
        BRANCH="main"
        ;;
    "refs/heads/dev")
        DIR="/home/catsoop/note-dev"
        BRANCH="dev"
        ;;
    *)
        log "Unknown ref: $REF, skipping"
        exit 0
        ;;
esac

log "Deploying $BRANCH to $DIR"

cd "$DIR"

# Pull latest changes
git fetch origin "$BRANCH"
git reset --hard "origin/$BRANCH"

log "Git pull complete"

# Render with Quarto (with timeout protection)
if timeout "$TIMEOUT" quarto render; then
    log "Quarto render complete for $BRANCH"
else
    log "ERROR: Quarto render failed or timed out after ${TIMEOUT}s"
    exit 1
fi
