#!/usr/bin/env bash
# archive-card.sh
# Archive a completed card and log cycle time + lead time in METRICS.md.
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
CREATED=$(grep "^created:" "$CARD_FILE" | sed 's/.*: //')
STARTED=$(grep "^started:" "$CARD_FILE" | sed 's/.*: //')
COMPLETED=$(grep "^completed:" "$CARD_FILE" | sed 's/.*: //')

# --- Compute cycle time (work started → completed) ---
compute_time_diff() {
  local START="$1"
  local END="$2"
  local LABEL="$3"

  if [ "$START" = "—" ] || [ "$END" = "—" ] || ! command -v python3 &>/dev/null; then
    echo "—"
    return
  fi

  python3 -c "
from datetime import datetime, timezone
try:
  s = datetime.fromisoformat('$START')
  e = datetime.fromisoformat('$END')
  # Handle naive vs aware datetimes
  if s.tzinfo is None:
    s = s.replace(tzinfo=timezone.utc)
  if e.tzinfo is None:
    e = e.replace(tzinfo=timezone.utc)
  diff = e - s
  days = diff.days
  hours = diff.seconds // 3600
  minutes = (diff.seconds % 3600) // 60
  if days > 0:
    print(f'{days}d {hours}h')
  elif hours > 0:
    print(f'{hours}h {minutes}m')
  else:
    print(f'{minutes}m')
except Exception as ex:
  print('—')
"
}

CYCLE_TIME=$(compute_time_diff "$STARTED" "$COMPLETED")
LEAD_TIME=$(compute_time_diff "$CREATED" "$COMPLETED")

# Move card to ARCHIVED
mkdir -p .kanban/ARCHIVED
mv "$CARD_FILE" ".kanban/ARCHIVED/"

# Log cycle time in the Cycle Time Log section
sed -i '' '/^## Cycle Time Log/,/^## /{
  /^|.*|.*|.*|.*|$/a\
| '"$CARD"': '"$TITLE"' | '"$STARTED"' | '"$COMPLETED"' | '"$CYCLE_TIME"' |
}' .kanban/METRICS.md 2>/dev/null || {
  # Fallback: append to end if sed fails
  echo "" >> .kanban/METRICS.md
  echo "| $CARD: $TITLE | $STARTED | $COMPLETED | $CYCLE_TIME |" >> .kanban/METRICS.md
}

# Log lead time in the Lead Time Log section
sed -i '' '/^## Lead Time Log/,/^## /{
  /^|.*|.*|.*|.*|.*|$/a\
| '"$CARD"': '"$TITLE"' | '"$CREATED"' | '"$COMPLETED"' | '"$LEAD_TIME"' |
}' .kanban/METRICS.md 2>/dev/null || {
  echo "" >> .kanban/METRICS.md
  echo "| $CARD: $TITLE | $CREATED | $COMPLETED | $LEAD_TIME |" >> .kanban/METRICS.md
}

echo "✅ Archived: $CARD — $TITLE"
echo "   Cycle time: $CYCLE_TIME"
echo "   Lead time:  $LEAD_TIME"
echo "   Card moved to .kanban/ARCHIVED/"
echo "   Metrics logged in .kanban/METRICS.md"
