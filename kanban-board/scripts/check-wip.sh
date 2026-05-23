#!/usr/bin/env bash
# check-wip.sh
# Display WIP status across all columns.
# Usage: ./scripts/check-wip.sh

set -euo pipefail

if [ ! -f .kanban/CONFIG.md ]; then
  echo "Error: .kanban/CONFIG.md not found. Run init-board.sh first."
  exit 1
fi

echo ""
echo "📊 WIP Status"
echo "━━━━━━━━━━━━━━━"

BOTTLENECKS=""

# Parse columns from CONFIG and count cards in BOARD.md
grep "^\s*-\s*" .kanban/CONFIG.md | while IFS= read -r line; do
  COLUMN=$(echo "$line" | sed 's/.*-\s*//' | sed 's/:.*//')
  LIMIT=$(echo "$line" | sed 's/.*://' | tr -d ' ')

  # Count cards in this column from BOARD.md
  COUNT=0
  if [ -f .kanban/BOARD.md ]; then
    IN_SECTION=false
    while IFS= read -r board_line; do
      if echo "$board_line" | grep -q "^## $COLUMN"; then
        IN_SECTION=true
        continue
      fi
      if $IN_SECTION; then
        if echo "$board_line" | grep -q "^## "; then
          break
        fi
        if echo "$board_line" | grep -q "| \*\*"; then
          COUNT=$((COUNT + 1))
        fi
      fi
    done < .kanban/BOARD.md
  fi

  if [ "$LIMIT" = "-1" ]; then
    LIMIT_DISPLAY="∞"
    STATUS="✅"
  elif [ "$COUNT" -ge "$LIMIT" ]; then
    STATUS="⚠️ AT LIMIT"
    BOTTLENECKS="$BOTTLENECKS\n  → $COLUMN is at WIP limit ($COUNT/$LIMIT)"
  else
    STATUS="✅"
  fi

  printf "%-15s %3s cards  (limit: %3s) %s\n" "$COLUMN" "$COUNT" "$LIMIT_DISPLAY" "$STATUS"
done

echo "━━━━━━━━━━━━━━━"

if [ -n "$BOTTLENECKS" ]; then
  echo -e "🔴 Bottleneck detected:$BOTTLENECKS"
fi

echo ""
