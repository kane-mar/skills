#!/usr/bin/env bash
# archive-item.sh
# Archive a done backlog item's detail file to .backlog/ARCHIVED/.
# The BACKLOG.md table row is NOT touched here — mark its status `done` separately
# (the row keeps its rank). This script only retires the per-item detail file.
# Usage: ./scripts/archive-item.sh ITEM-003

set -euo pipefail

ITEM_ID="${1:?"Usage: $0 <item-id> (e.g. ITEM-003)"}"

# Find the item file in the active ITEMS/ directory.
SRC=$(find .backlog/ITEMS/ -name "${ITEM_ID}--*.md" -print -quit)

if [ -z "$SRC" ]; then
  echo "Error: no item file matching ${ITEM_ID} found in .backlog/ITEMS/"
  exit 1
fi

mkdir -p .backlog/ARCHIVED

DEST=".backlog/ARCHIVED/$(basename "$SRC")"
if [ -e "$DEST" ]; then
  echo "Error: ${DEST} already exists — not overwriting."
  exit 1
fi

mv "$SRC" "$DEST"

echo "Archived: $(basename "$SRC")"
echo "  → $DEST"
echo ""
echo "Reminder: also set the item's Status to 'done' in BACKLOG.md (keep the row, keep its rank)."
