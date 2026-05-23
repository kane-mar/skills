#!/usr/bin/env bash
# unblock-card.sh
# Unblock a previously blocked card.
# Usage: ./scripts/unblock-card.sh CARD-003

set -euo pipefail

CARD="${1:?"Usage: $0 <card-id>"}"
DATE=$(date -Iseconds)

{
  echo ""
  echo "## $CARD — $DATE"
  echo ""
  echo "**Status:** unblocked"
  echo "**Resolved:** $DATE"
} >> .kanban/BLOCKERS.md

echo "✅ Unblocked: $CARD"
echo "   Logged in .kanban/BLOCKERS.md"
