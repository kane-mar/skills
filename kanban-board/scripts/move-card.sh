#!/usr/bin/env bash
# move-card.sh
# Move a card between columns, respecting WIP limits.
# Usage: ./scripts/move-card.sh CARD-003 "In Progress"

set -euo pipefail

CARD="${1:?"Usage: $0 <card-id> <target-column>"}"
TARGET="${2:?"Usage: $0 <card-id> <target-column>"}"
DATE=$(date -Iseconds)

# Validate column exists in CONFIG
if [ ! -f .kanban/CONFIG.md ]; then
  echo "Error: .kanban/CONFIG.md not found. Run init-board.sh first."
  exit 1
fi

# Check WIP limit for target column
WIP_LIMIT=$(grep -E "^\s*-\s*${TARGET}:" .kanban/CONFIG.md 2>/dev/null | sed 's/.*://' | tr -d ' ' || echo "")
if [ -z "$WIP_LIMIT" ]; then
  echo "Error: Column '$TARGET' not found in .kanban/CONFIG.md"
  echo "Available columns:"
  grep "^\s*-\s*" .kanban/CONFIG.md | sed 's/.*-\s*//' | sed 's/:.*//'
  exit 1
fi

if [ "$WIP_LIMIT" != "-1" ]; then
  # Count current cards in target column from BOARD.md
  IN_COLUMN=0
  if [ -f .kanban/BOARD.md ]; then
    IN_SECTION=false
    while IFS= read -r line; do
      if echo "$line" | grep -q "^## $TARGET"; then
        IN_SECTION=true
        continue
      fi
      if $IN_SECTION; then
        if echo "$line" | grep -q "^## "; then
          break
        fi
        if echo "$line" | grep -q "| \*\*"; then
          IN_COLUMN=$((IN_COLUMN + 1))
        fi
      fi
    done < .kanban/BOARD.md
  fi

  if [ "$IN_COLUMN" -ge "$WIP_LIMIT" ]; then
    echo "🔴 Cannot move $CARD to $TARGET — WIP limit reached ($IN_COLUMN/$WIP_LIMIT)"
    echo "   Finish or move work out of $TARGET first."
    exit 1
  fi
fi

# Update card status in its file
CARD_FILE=$(find .kanban/CARDS/ -name "${CARD}--*.md" 2>/dev/null | head -1)
if [ -n "$CARD_FILE" ]; then
  # Update status and add a move log entry
  if grep -q "^started:" "$CARD_FILE" && [ "$TARGET" != "Backlog" ] && [ "$TARGET" != "Done" ]; then
    # Mark started if this is the first non-backlog, non-done column
    CURRENT_STARTED=$(grep "^started:" "$CARD_FILE" | sed 's/.*: //')
    if [ "$CURRENT_STARTED" = "—" ]; then
      sed -i '' "s/^started:.*/started: $DATE/" "$CARD_FILE"
    fi
  fi
  if [ "$TARGET" = "Done" ]; then
    sed -i '' "s/^completed:.*/completed: $DATE/" "$CARD_FILE"
  fi
fi

echo "✅ $CARD moved to $TARGET"
