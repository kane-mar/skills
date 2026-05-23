#!/usr/bin/env bash
# archive-card.sh
# Archive a completed card and log its cycle time.
# Usage: ./scripts/archive-card.sh CARD-003

set -euo pipefail

CARD="${1:?"Usage: $0 <card-id>"}"
DATE=$(date -Iseconds)

CARD_FILE=$(find .kanban/CARDS/ -name "${CARD}--*.md" 2>/dev/null | head -1)

if [ -z "$CARD_FILE" ]; then
  echo "Error: Card $CARD not found in .kanban/CARDS/"
  exit 1
fi

# Extract title and timing info
TITLE=$(grep "^title:" "$CARD_FILE" | sed 's/.*: "//' | sed 's/"$//')
STARTED=$(grep "^started:" "$CARD_FILE" | sed 's/.*: //')
COMPLETED=$(grep "^completed:" "$CARD_FILE" | sed 's/.*: //')

# Estimate cycle time (rough: if both dates exist, compute days)
CYCLE_TIME="—"
if [ "$STARTED" != "—" ] && [ "$COMPLETED" != "—" ] && command -v python3 &>/dev/null; then
  CYCLE_TIME=$(python3 -c "
from datetime import datetime
try:
  s = datetime.fromisoformat('$STARTED')
  e = datetime.fromisoformat('$COMPLETED')
  days = (e - s).days
  hours = (e - s).seconds // 3600
  print(f'{days}d {hours}h' if days > 0 else f'{hours}h')
except:
  print('—')
  ")
fi

# Move card to ARCHIVED
mkdir -p .kanban/ARCHIVED
mv "$CARD_FILE" ".kanban/ARCHIVED/"

# Log cycle time
{
  echo ""
  echo "| $CARD: $TITLE | $STARTED | $COMPLETED | $CYCLE_TIME |"
} >> .kanban/METRICS.md

echo "✅ Archived: $CARD — $TITLE"
echo "   Cycle time: $CYCLE_TIME"
echo "   Card moved to .kanban/ARCHIVED/"
echo "   Cycle time logged in .kanban/METRICS.md"
