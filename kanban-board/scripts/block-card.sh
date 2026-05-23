#!/usr/bin/env bash
# block-card.sh
# Mark a card as blocked with a reason.
# Usage: ./scripts/block-card.sh CARD-003 "Waiting for email service API key"

set -euo pipefail

CARD="${1:?"Usage: $0 <card-id> <reason>"}"
REASON="${2:?"Usage: $0 <card-id> <reason>"}"
DATE=$(date -Iseconds)

{
  echo ""
  echo "## $CARD — $DATE"
  echo ""
  echo "**Reason:** $REASON"
  echo "**Status:** blocked"
} >> .kanban/BLOCKERS.md

echo "🔴 Blocked: $CARD"
echo "   Reason: $REASON"
echo "   Logged in .kanban/BLOCKERS.md"
echo ""
echo "Note: The card remains visible on the board. Do not hide blocked work."
