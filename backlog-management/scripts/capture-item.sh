#!/usr/bin/env bash
# capture-item.sh
# Quick-capture a new backlog item.
# Usage: ./scripts/capture-item.sh "Title" "Type" [notes]

set -euo pipefail

TITLE="${1:?"Usage: $0 <title> <type> [notes]"}"
TYPE="${2:?"Usage: $0 <title> <type> [notes]"}"
NOTES="${3:-}"

DATE=$(date -Iseconds)
NEXT_NUM=$(find .backlog/ITEMS/ -name 'ITEM-*.md' 2>/dev/null | wc -l | tr -d ' ')
NEXT_NUM=$((NEXT_NUM + 1))
ITEM_ID=$(printf "ITEM-%03d" "$NEXT_NUM")
FILENAME=".backlog/ITEMS/${ITEM_ID}--${TITLE// /-}.md"

cat > "$FILENAME" << ITEM_EOF
---
id: $ITEM_ID
title: "$TITLE"
type: $TYPE
status: captured
created: $DATE
---

# $ITEM_ID: $TITLE

## Description
(Add description)

## Acceptance Criteria
- [ ] (add criteria)

## Technical Notes
(Add notes)
ITEM_EOF

# Also append to BACKLOG.md (at the bottom; rank = priority, so promote by reordering)
{
 echo "| $NEXT_NUM | $ITEM_ID | $TITLE | $TYPE | captured | $NOTES |"
} >> BACKLOG.md

echo "Captured: $ITEM_ID — $TITLE"
echo " File: $FILENAME"
echo " Type: $TYPE"
echo ""
echo "Next: Refine with story and AC when ready to start work."
echo "Note: rank is priority — reorder the row to set its priority position."
